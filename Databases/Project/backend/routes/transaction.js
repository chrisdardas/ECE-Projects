import { Router } from 'express';
import { adminPool, playerPool, developerPool } from "../database.js"; // Import the database connection

const router = Router(); // Router for transaction

router.post("/:player_id", async (req, res) => {
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
            return res.status(403).send("Unauthorized");
    }
    const sql = "INSERT INTO transaction (transaction_amount, payment_method, player_id) VALUES (?, ?, ?)";
    const values = [
        req.body.transaction_amount,
        req.body.payment_method,
        req.params.player_id
    ];
    try {
        await db.query(sql, values);
        res.status(201).send("Transaction Added");
    } catch (error) {
        console.error('Error adding transaction:', error);
        res.status(500).json({ message: 'Server error.' });
    };
});

export default router; // Export the router