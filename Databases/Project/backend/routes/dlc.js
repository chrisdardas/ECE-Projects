import {Router} from 'express'; // Import the Router class
import {adminPool, playerPool, developerPool} from '../database.js'; // Import the database connection

const router = Router();

router.get("/", async (req, res) => {
    const role = req.user.role;

    let db;
    switch(role){
        case 'admin':
            db = adminPool;
            break;
        case 'player':
            db = playerPool;
            break;
        case 'developer':
            db = developerPool;
            break;
        default:
            return res.status(401).send("Unauthorized");
    };

    try {
        const sql = "SELECT title, description FROM dlc ";
        const [results] = await db.query(sql);
        res.status(200).send(results);
    } catch (error) {
        console.error('Error fetching DLC:', error);
        res.status(500).json({message: 'Server error.'});
    }
});

export default router;