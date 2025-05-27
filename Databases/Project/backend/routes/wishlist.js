import { Router } from 'express';
import { adminPool, playerPool, developerPool } from "../database.js"; // Import the database connection

const router = Router(); // Router for transaction

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

    const sql = "SELECT * FROM wishlist WHERE player_id = ?";
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

router.post("/", async (req, res) => {
    const role = req.user.role;
    console.log("Role:", role);

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

    const sql = "INSERT INTO wishlist (wishlist_id, player_id) VALUES (?, ?)";
    const values = [
        req.body.wishlist_id,
        req.user.id
    ];

    try {
        await db.query(sql, values);
        res.status(201).send("Wishlist Added");
    } catch (error) {
        console.error('Error adding wishlist:', error);
        res.status(500).json({ message: 'Server error.' });
    };
});

router.post("/:wishlist_id", async (req, res) => {
    const role = req.user.role;
    console.log("Role:", role);

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

    const sql = "DELETE FROM wishlist WHERE wishlist_id = ? AND player_id = ?";
    const values = [
        req.params.wishlist_id,
        req.user.id
    ];

    try {
        await db.query(sql, values);
        res.status(204).send("Wishlist Deleted");
    } catch (error) {
        console.error('Error deleting wishlist:', error);
        res.status(500).json({ message: 'Server error.' });
    };
});

router.delete("/:wishlist_id", async (req, res) => {
    const role = req.user.role;
    console.log("Role:", role);

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

    const sql = "DELETE FROM wishlist WHERE wishlist_id = ? AND player_id = ?";
    const values = [
        req.params.wishlist_id,
        req.user.id
    ];

    try {
        await db.query(sql, values);
        res.status(204).send("Wishlist Deleted");
    } catch (error) {
        console.error('Error deleting wishlist:', error);
        res.status(500).json({ message: 'Server error.' });
    };
});

export default router; // Export the router