import { Router } from "express";
import { adminPool, developerPool, playerPool } from "../database.js";

const router = Router(); // Create a new router

router.get("/", async (req, res) => {
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
    try{
        const [results] = await db.query("SELECT rating, comment FROM review");
        res.status(200).send(results);
    } catch(error){
        console.error('Error fetching reviews:', error);
        res.status(500).json({ message: 'Server error.' });
    }
});

router.post("/", async (req, res) => {
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
    const sql = "INSERT INTO review (rating, comment, publication_date, player_id) VALUES (?, ?, ?, ?)";
    const values =[
        req.body.rating,
        req.body.comment,
        new Date(),
        req.user.player_id
    ];

    try {
        const [result] = await db.query(sql, values);
        res.status(201).send("Review Added");
    } catch (error) {
        console.error('Error adding review:', error);
        res.status(500).json({ message: 'Server error.' });
    };
});

router.put("/:review_id", async (req, res) => {
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
    const sql = "UPDATE review SET rating = ?, comment = ? WHERE review_id = ?";
    const values = [
        req.body.rating,
        req.body.comment,
        req.params.review_id
    ];
    try {
        const [result] = await db.query(sql, values);
        res.status(201).send("Review Updated");
    } catch (error) {
        console.error('Error updating review:', error);
        res.status(500).json({ message: 'Server error.' });
    };
});

router.delete("/:review_id", async (req, res) => {
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
    const sql = "DELETE FROM review WHERE review_id = ?";
    const values = [req.params.review_id];
    try {
        const [result] = await db.query(sql, values);
        res.status(204).send("Review Deleted");
    } catch (error) {
        console.error('Error deleting review:', error);
        res.status(500).json({ message: 'Server error.' });
    };
});

export default router;