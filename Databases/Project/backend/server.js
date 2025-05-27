import path from 'path';
import { fileURLToPath } from 'url';
import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
dotenv.config(); // To read the .env file
import helmet from "helmet";
import morgan from "morgan";
import { adminPool, playerPool, developerPool } from "./database.js";
import playerRouter from "./routes/player.js";
import gameRouter from "./routes/game.js";
import reviewRouter from "./routes/reviews.js";
import transactionRouter from "./routes/transaction.js";
import wishListRouter from "./routes/wishlist.js";
import achievementRouter from "./routes/achievement.js";
import dlcRouter from "./routes/dlc.js";
import authenticate from "./authentication.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
console.log('Filename:', __dirname);
const app = express();

const corsOptions = {
    origin: 'http://localhost:3000', // where the frontend is running
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type', 'Authorization'],
    credentials: true
};

app.use(cors(corsOptions)); // Cross-Origin Resource Sharing
app.use(express.json()); // To parse JSON bodies
app.use(helmet()); // To set secure HTTP headers
app.use(morgan('combined')); // To log HTTP requests

// Serve favicon
app.get('/favicon.ico', (req, res) => res.status(204).end());

// Public route
app.get("/", (_, res) => {
    res.status(200).send("Welcome to Gamestorm");
});

// Apply authenticate middleware to all routes below except /player/login and /player/register
app.use("/player", playerRouter); 

// Apply authenticate middleware to other routes
app.use(authenticate);

app.use("/game", gameRouter); 
app.use("/reviews", reviewRouter);
app.use("/transaction", transactionRouter);
app.use("/wishlist", wishListRouter);
app.use("/achievement", achievementRouter);
app.use("/dlc", dlcRouter);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log("Server listening on Port :", PORT);
});