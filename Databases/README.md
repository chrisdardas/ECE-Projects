# 🗄️ Databases Projects

![License](https://img.shields.io/badge/license-MIT-green.svg)
![Language](https://img.shields.io/badge/language-SQL-blue.svg)
![Language](https://img.shields.io/badge/language-JavaScript-yellow.svg)
![Language](https://img.shields.io/badge/language-React-cyan.svg)
![Platform](https://img.shields.io/badge/platform-MySQL-lightgrey.svg)
![Semester](https://img.shields.io/badge/semester-9th-orange.svg)

This repository contains projects developed for the **Databases** course at the School of Electrical and Computer Engineering, Aristotle University of Thessaloniki.

## 📚 Table of Contents

- [Overview](#overview)
- [Assignment 1: Database Design](#-assignment-1-database-design)
- [Assignment 2: SQL Implementation](#-assignment-2-sql-implementation)
- [Final Project: Full-Stack Game Database](#-final-project-full-stack-game-database)

## Overview

The projects focus on database design and implementation as well as full-stack development, including:

- Entity-Relationship modeling
- SQL query development
- Normalization techniques
- Stored procedures and triggers
- Full-stack web application development

---

## 📋 Assignment 1: Database Design

Database design fundamentals and ER modeling.

📄 Report: [`Team_7_Assignment_1.pdf`](./Team_7_Assignment_1.pdf)

---

## 🔧 Assignment 2: SQL Implementation

SQL database implementation with queries, views, and stored procedures.

📁 Location: [`Team_7_Assignment_2/SQL DATABASE`](./Team_7_Assignment_2/SQL%20DATABASE)

---

## 🎮 Final Project: Full-Stack Game Database

A complete full-stack web application for managing a game database.

### Architecture

```
Project/
├── backend/                 # Node.js + Express REST API
│   ├── server.js           # Main server entry point
│   ├── database.js         # MySQL database connection
│   ├── authentication.js   # User authentication logic
│   └── routes/             # API route handlers
│
└── frontend/               # React.js web application
    ├── src/                # React components and logic
    └── public/             # Static assets
```

### Backend

| Component | Description |
|-----------|-------------|
| `server.js` | Express server setup and middleware configuration |
| `database.js` | MySQL connection pool management |
| `authentication.js` | JWT-based user authentication |
| `routes/` | RESTful API endpoints for game data |

### Frontend

- Built with **React.js**
- Modern responsive UI
- User authentication flow
- CRUD operations for game management

### Technologies Used

| Layer | Technology |
|-------|------------|
| Database | MySQL |
| Backend | Node.js, Express.js |
| Frontend | React.js |
| Authentication | JWT |

### 🚀 How to Run

**Backend:**
```bash
cd Project/backend
npm install
npm start
```

**Frontend:**
```bash
cd Project/frontend
npm install
npm start
```

**Docker (Alternative):**
```bash
cd Project
docker build -t game-database .
docker run -p 3000:3000 game-database
```
