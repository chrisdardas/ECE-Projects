import mysql from "mysql2/promise";
import dotenv from "dotenv";
dotenv.config(); // To read the .env file

const dbConfig = {
    host: process.env.DB_HOST,
    database: process.env.DB_DATABASE
};

// console.log("DB_HOST:", process.env.DB_HOST);
// console.log("DB_PLAYER_USER:", process.env.DB_PLAYER_USER);
// console.log("DB_PLAYER_PASS:", process.env.DB_PLAYER_PASS);

// Admin Connection Pool
const adminPool = mysql.createPool({
    ...dbConfig,
    user: process.env.DB_ADMIN_USER,
    password: process.env.DB_ADMIN_PASS,
    waitForConnections: true
});

// Player Connection Pool
const playerPool = mysql.createPool({
    ...dbConfig,
    user: process.env.DB_PLAYER_USER,
    password: process.env.DB_PLAYER_PASS,
    waitForConnections: true
});

// Developer Connection Pool
const developerPool = mysql.createPool({
    ...dbConfig,
    user: process.env.DB_DEVELOPER_USER,
    password: process.env.DB_DEVELOPER_PASS,
    waitForConnections: true
});

const roleToPoolMap = {
    admin: adminPool,
    player: playerPool,
    developer: developerPool,
};

const getDatabasePool = (role) => roleToPoolMap[role] || null;

export { adminPool, playerPool, developerPool };
// export { getDatabasePool };