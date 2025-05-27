import { Router } from 'express';
import jwt from 'jsonwebtoken';
import authenticate from '../authentication.js';
import { playerPool, developerPool, adminPool } from '../database.js';

const router = Router(); // Create a new router

// Public routes
router.post("/login", async (req, res) => {
    const { email, username } = req.body;
    console.log('req.body:', req.body);
    console.log(`Login attempt for Email: ${email}, Username: ${username}`);

    if (!email || !username) {
        console.log('Missing email or username in request.');
        return res.status(400).json({ success: false, message: 'Email and Username are required.' });
    }

    try {
        let user = null;
        let role = null;
        let pool = null;

        // Attempt to find user in Player Pool
        const playerQuery = 'SELECT * FROM player WHERE email = ?';
        const [playerUsers] = await playerPool.query(playerQuery, [email]);

        if (playerUsers.length > 0) {
            user = playerUsers[0];
            role = 'player';
            pool = playerPool;
        } else {
            // Attempt to find user in Developer Pool
            const developerQuery = 'SELECT * FROM developer WHERE email = ?';
            const [developerUsers] = await developerPool.query(developerQuery, [email]);

            if (developerUsers.length > 0) {
                user = developerUsers[0];
                role = 'developer';
                pool = developerPool;
            }
        }

        if (!user) {
            console.log('No matching user found in Player or Developer tables.');
            return res.status(401).json({ success: false, message: 'Invalid email or password.' });
        }

        const payload = {
            id: user.id || user.player_id || user.developer_id,
            role: role
        };

        const token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '1h' });

        const sanitizedUser = {
            id: user.id || user.player_id || user.developer_id,
            email: user.email,
            username: user.username || user.name,
            role: role
        };

        return res.status(200).json({
            success: true,
            token,
            user: sanitizedUser
        });
    } catch (error) {
        console.error('Error during login:', error);
        return res.status(500).json({ success: false, message: 'Server error.' });
    }
});

router.post("/", async (req, res) => {
    const { username, email, password, role } = req.body; 
    console.log(`Registration attempt for Username: ${username}, Email: ${email}, Role: ${role}`);
    const db = playerPool;

    const checkQuery = "SELECT * FROM player WHERE username = ?";
    const insertQuery = "INSERT INTO player (username, email) VALUES (?, ?)";

    try {
        // Check if username already exists
        const [existingUsers] = await db.query(checkQuery, [username]);

        if (existingUsers.length > 0) {
            return res.status(400).json({ message: 'Username already exists.' });
        }
        // Insert the new player
        const token = jwt.sign(
            { username, email, role },
            process.env.JWT_SECRET,
            { expiresIn: '1h' }
        );
        await db.query(insertQuery, [username, email]); 
        res.status(201).json({ message: 'Account created successfully.', token });
    } catch (error) {
        console.error('Error during registration:', error);
        res.status(500).json({ message: 'Server error.' });
    }
});

// Apply the authenticate middleware to all routes below
router.use(authenticate);

router.get("/", async (req, res) => {
    const { ban_status, achievement_id } = req.query;
    console.log("Auth check - User:", req.user);
    const role = req.user.role;
    console.log("ROLE: ", role);
    const sql = "SELECT A.player_id, A.username, C.achievement_id, C.title, C.date_of_completion FROM player AS A JOIN player_unlocks_achievement AS B ON A.player_id = B.player_id JOIN achievement AS C ON B.achievement_id = C.achievement_id WHERE C.achievement_id = ?;";
    let db;

    switch(role){
        case "admin":
            db = adminPool;
            break;
        case "player":
            db = playerPool;
            break;
        case "developer":
            db = developerPool;
            break;
        default:
            return res.status(403).send("Unauthorized to view players");
    }

    try{
        if (achievement_id !== undefined) {
            const [results] = await db.query(sql, [achievement_id]);
            return res.status(200).json(results);
        } else if (ban_status !== undefined) {
            const [results] = await db.query("SELECT * FROM player WHERE ban_status = ?", [ban_status]);
            return res.status(200).json(results);
        } else {
            const [results] = await db.query("SELECT * FROM player");
            return res.status(200).json(results);
        }
    } catch (error) {
        console.error('Error fetching players:', error);
        res.status(500).json({ message: 'Server error.' });
    }
});

router.get("/:player_id", async (req, res) => {
    console.log("Auth check - User:", req.user);
    const role = req.user.role;
    let db;
    
    switch(role) {
        case "admin":
            db = adminPool;
            break;
        case "player":
            db = playerPool;
            break;
        case "developer":
            db = developerPool;
            break;
        default:
            return res.status(403).send("Invalid role");
    }

    try {
        if (role === "player" && String(req.user.id) !== String(req.params.player_id)) {
            console.log(`Access denied - User ${req.user.id} attempted to access player ${req.params.player_id}`);
            return res.status(403).send("Unauthorized");
        }

        const [results] = await db.query("SELECT * FROM player WHERE player_id = ?", [req.params.player_id]);
        
        if (!results.length) {
            return res.status(404).send("Player not found");
        }
        
        res.status(200).send(results[0]);
    } catch (error) {
        console.error('Error fetching player:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

router.put("/:player_id", async (req, res) => {
    const role = req.user.role;
    let db;
    switch(role){
        case "admin":
            db = adminPool;
            break;
        case "player":
            db = playerPool;
            break;
        case "developer":
            db = developerPool;
            break;
        default:
            return res.status(403).send("Unauthorized to update player");
    }
    const sql = "UPDATE player SET username = ?, email = ?, total_playtime = ?, achievement_points = ?, ban_status = ?, last_login = ? WHERE player_id = ?";
    const values =[
        req.body.username,
        req.body.email,
        req.body.total_playtime,
        req.body.achievement_points,
        req.body.ban_status,
        req.body.last_login,
        req.params.player_id
    ];
    try{
        const [ results ] = await db.query(sql, values);
        res.status(200).send("Player Updated");
    } catch (error) {
        console.error('Error updating player:', error);
        res.status(500).json({ message: 'Server error.' });
    }
});

router.delete("/:player_id", async (req, res) => {
    const role = req.user.role;
    let db;
    if(role === "admin"){
        db = adminPool;
    } else {
        return res.status(403).send("Unauthorized to delete player");
    }
    try {
        const [results] = await db.query('DELETE FROM player WHERE player_id = ?', [req.params.player_id]);
        res.status(204).send("Player Deleted");
    } catch (error) {
        console.error('Error deleting player:', error);
        res.status(500).json({ message: 'Server error.' });
    }
});

export default router; // Export the router