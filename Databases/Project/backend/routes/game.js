import { Router } from "express";
import { adminPool, playerPool, developerPool } from "../database.js";


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
    const { multiplayer_support } = req.query;
    // console.log(multiplayer_support);
    try{
        if (multiplayer_support !== undefined) {
            // console.log("Handling multiplayer_support filter");
            const sql = "SELECT game_id, title FROM game WHERE multiplayer_support = ?";
            const [results] = await db.query(sql, [multiplayer_support]);
            res.status(200).send(results);
        } else {
            // console.log("Fetching all games");
            const [results] = await db.query("SELECT * FROM game");
            res.status(200).send(results);
        }
    }
    catch (error) {
        console.error('Error fetching games:', error);
        res.status(500).json({ message: 'Server error.' });
    }
});

router.get("/:game_id", async (req, res, next) => {
    // console.log("GETTING GAME BY ID");
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
        const [results] = await db.query("SELECT title FROM game WHERE game_id = ?", [req.params.game_id]);
        res.status(200).send(results);
    } catch (error) {
        console.error('Error fetching game:', error);
        res.status(500).json({ message: 'Server error.' });
    };
});

router.post("/", async (req, res) => {
    const role = req.user.role;
    let db;
    switch(role){
        case "admin":
            db = adminPool;
            break;
        case "developer":
            db = developerPool;
            break;
        default:
            return res.status(403).send("Unauthorized");
    }
    const sql = "INSERT INTO game (title, release_date, price, age_rating, dlcs_available, multiplayer_support, genre_name, developer_id, platform_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    const values =[
        req.body.title,
        req.body.release_date,
        req.body.price,
        req.body.age_rating,
        req.body.dlcs_available,
        req.body.multiplayer_support,
        req.body.genre_name,
        req.body.developer_id,
        req.body.platform_id
    ];
    try {
        const [results] = await db.query(sql, values);
        res.status(201).send(results);
    } catch (error) {
        console.error('Error adding game:', error);
        res.status(500).json({ message: 'Server error.' });
    }
});

router.delete("/:game_id", async (req, res) => {
    const role = req.user.role;
    let db;
    switch(role){
        case "admin":
            db = adminPool;
            break;
        case "developer":
            db = developerPool;
            break;
        default:
            return res.status(403).send("Unauthorized");
    }
    const sql = "DELETE FROM game WHERE game_id = ?";
    const value = [req.params.game_id];

    try{
        const [resutls] = await db.query(sql, value);
        res.status(204).send("Game Deleted");
    } catch (error) {
        console.error('Error deleting game:', error);
        res.status(500).json({ message: 'Server error.' });
    }
});


export default router; // Export the router