# 🧪 Software Engineering II - Testing Project

![License](https://img.shields.io/badge/license-MIT-green.svg)
![Language](https://img.shields.io/badge/language-JavaScript-yellow.svg)
![Framework](https://img.shields.io/badge/framework-Express.js-green.svg)
![Testing](https://img.shields.io/badge/testing-Ava%20%26%20Cypress-blue.svg)
![Semester](https://img.shields.io/badge/semester-9th-orange.svg)

This repository contains the testing project developed for the **Software Engineering II** course at the School of Electrical and Computer Engineering, Aristotle University of Thessaloniki.

## 📚 Table of Contents

- [Overview](#overview)
- [Project Structure](#-project-structure)
- [API Endpoints](#-api-endpoints)
- [Testing](#-testing)
- [How to Run](#-how-to-run)

## Overview

This project focuses on software testing practices for a booking/reservation REST API (ThessBooker):

- Unit testing with Ava
- Integration testing
- End-to-end testing with Cypress
- Code coverage analysis
- API testing best practices

---

## 📁 Project Structure

```
SE2_Project/
├── api/                    # OpenAPI/Swagger specification
├── controllers/            # Request handlers
├── service/               # Business logic
├── utils/                 # Helper functions
├── tests/                 # Unit tests (Ava)
│   ├── directions.test.js
│   ├── init.test.js
│   ├── payment.test.js
│   ├── preorder.test.js
│   ├── ratings.test.js
│   ├── reservation.test.js
│   ├── reviews.test.js
│   └── search.test.js
├── cypress/               # E2E tests (Cypress)
│   └── e2e/
│       └── init.cy.js
├── index.js              # Application entry point
└── package.json          # Dependencies and scripts
```

---

## 🔌 API Endpoints

The ThessBooker API provides the following endpoints:

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/search` | GET | Search for available reservations |
| `/reservation` | POST | Create a new reservation |
| `/payment` | POST | Process payment |
| `/directions` | GET | Get directions to venue |
| `/preorder` | POST | Pre-order services |
| `/ratings` | GET/POST | Get/Submit ratings |
| `/reviews` | GET/POST | Get/Submit reviews |

---

## 🧪 Testing

### Unit Tests (Ava)

Unit tests are located in the `tests/` folder:

| Test File | Coverage |
|-----------|----------|
| `init.test.js` | Application initialization |
| `search.test.js` | Search functionality |
| `reservation.test.js` | Reservation creation |
| `payment.test.js` | Payment processing |
| `directions.test.js` | Directions retrieval |
| `preorder.test.js` | Pre-order functionality |
| `ratings.test.js` | Rating system |
| `reviews.test.js` | Review system |

**Run unit tests:**
```bash
npm test
```

**Run with coverage:**
```bash
npm run test:coverage
```

---

### E2E Tests (Cypress)

End-to-end tests are located in `cypress/e2e/`:

| Test File | Coverage |
|-----------|----------|
| `init.cy.js` | Full user flow testing |

**Run Cypress interactively:**
```bash
npm run cypress:open
```

**Run Cypress headless:**
```bash
npm run cypress:run
```

---

## 🚀 How to Run

### Prerequisites

- Node.js (v14+)
- npm

### Installation

```bash
# Install dependencies
npm install
```

### Running the Application

```bash
# Development mode (with hot reload)
npm run dev

# Production mode
npm start
```

### Running Tests

```bash
# Run all unit tests
npm test

# Run with coverage report
npm run test:coverage

# Run Cypress E2E tests
npm run cypress:run
```

---

## 📊 Code Coverage

The project aims for the following coverage targets:

| Metric | Target |
|--------|--------|
| Statements | 70% |
| Branches | 70% |
| Functions | 70% |
| Lines | 70% |

Coverage reports are generated in the `coverage/` folder.

---

## 🛠️ Technologies Used

| Tool | Purpose |
|------|---------|
| **Node.js** | JavaScript runtime |
| **Express.js** | Web framework |
| **Ava** | Unit testing framework |
| **Cypress** | E2E testing framework |
| **c8/nyc** | Code coverage |
| **OpenAPI/Swagger** | API documentation |

---

## 🐳 Docker

The project includes Docker support:

```bash
# Build the image
docker build -t thessbooker .

# Run the container
docker run -p 3000:3000 thessbooker
```

---

## 📝 Testing Best Practices

This project demonstrates:

1. **Test Isolation** - Each test is independent
2. **Mocking** - External dependencies are mocked
3. **Coverage Analysis** - Tracking code coverage
4. **E2E Testing** - Testing complete user flows
5. **CI/CD Ready** - Tests can run in automated pipelines
