import {Router} from 'express'; // Import the Router class
import {adminPool, playerPool, developerPool} from '../database.js'; // Import the database connection

const router = Router(); // Router for achievement route

router.get("/", async (req, res) => {
    const role = req.user.role;
    console.log("Role:", role);
    console.log("User:", req.user);
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
            return res.status(403).send("Unauthorized");
    }

    const sql = "SELECT username, title FROM unlockedachievements WHERE player_id = ?";
    const values = req.user.id;
    console.log('Values:', values);

    try {
        const [rows] = await db.query(sql, values);
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching wishlist:', error);
        res.status(500).json({ message: 'Server error.' });
    };
});

export default router; // Export the router