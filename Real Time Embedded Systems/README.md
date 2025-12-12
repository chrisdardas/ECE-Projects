# ⚙️ Real-Time Embedded Systems Projects

![License](https://img.shields.io/badge/license-MIT-green.svg)
![Language](https://img.shields.io/badge/language-C-blue.svg)
![Platform](https://img.shields.io/badge/platform-Raspberry%20Pi-lightgrey.svg)
![Semester](https://img.shields.io/badge/semester-8th-orange.svg)

Welcome to the **Real-Time Embedded Systems** project repository! This collection showcases hands-on assignments developed during the Real-Time Embedded Systems course at the [School of Electrical and Computer Engineering](https://ece.auth.gr/), Aristotle University of Thessaloniki.

> 🛠️ Focused on real-time scheduling, concurrency, inter-process communication, and low-level hardware interaction using C and the POSIX threads API.

---

## 📚 Table of Contents

- [🚀 Overview](#-overview)
- [🧠 Core Concepts](#-core-concepts)
- [📂 Projects](#-projects)
- [🚀 How to Run](#-how-to-run)

---

## 🚀 Overview

This repository contains a series of real-time system projects developed in C. These exercises simulate real-time application behavior on a **Raspberry Pi**, with focus on:

- ✅ Real-time scheduling (RM, DM, EDF)
- ✅ Multithreading and synchronization with **pthreads**
- ✅ Time-constrained task execution and system latency analysis
- ✅ Periodic and aperiodic task management
- ✅ Timer interrupts and system resource handling

> Each project explores key real-time principles and provides insight into both theoretical and practical design challenges in embedded systems.

---

## 🧠 Core Concepts

| Concept                     | Description                                                                 |
|----------------------------|-----------------------------------------------------------------------------|
| **RM / DM / EDF Scheduling** | Implementation and comparison of common real-time scheduling algorithms   |
| **POSIX Threads**           | Concurrency via `pthreads`, with mutexes, condition variables, and barriers |
| **Timer APIs**              | High-resolution timers (`timer_create`, `timer_settime`, etc.)            |
| **Producer-Consumer**       | Buffer management using multithreading and semaphores                     |
| **CPU Affinity / Priority** | Task binding and dynamic priority configuration for real-time tuning       |

---

## 📂 Projects

### 🔄 Producer-Consumer Problem

Classic synchronization problem implemented with pthreads.

| File | Description |
|------|-------------|
| `producer_consumer.c` | Multi-threaded producer-consumer implementation |
| `Makefile` | Build automation |
| `script.py` | Python visualization script |

**Key Features:**
- Bounded buffer with mutex protection
- Condition variables for synchronization
- Semaphore-based solution comparison

📁 Location: [`Procuder-Consumer Problem/`](./Procuder-Consumer%20Problem/)

---

### 📈 RTES Final Project: Real-Time Stock Data Processing

A comprehensive real-time system for processing financial data with multiple concurrent tasks.

| File | Description |
|------|-------------|
| `project.c` | Main application (~500 lines of C) |
| `Makefile` | Build configuration |
| `PythonCode_For_Plots/` | Visualization scripts |
| `data/` | Sample data files |
| `report/` | Project documentation |

**System Architecture:**

```
┌─────────────┐     ┌─────────────┐     ┌──────────────────┐
│  Producers  │ ──▶ │   Queue     │ ──▶ │    Consumers     │
│ (WebSocket) │     │ (10000 cap) │     │ (Data Processing)│
└─────────────┘     └─────────────┘     └──────────────────┘
       │                                         │
       ▼                                         ▼
┌─────────────────┐                   ┌──────────────────────┐
│ Minute Candles  │                   │ Moving Average Calc  │
└─────────────────┘                   └──────────────────────┘
```

**Key Features:**
- WebSocket connection to Finnhub API for real-time stock data
- Producer threads fetching market data
- Consumer threads processing and analyzing data
- Candlestick chart generation (1-minute intervals)
- Moving average calculations (15-minute window)
- Thread synchronization with mutexes and condition variables
- Signal handling for graceful shutdown

**Libraries Used:**
- `libwebsockets` - WebSocket client
- `jansson` - JSON parsing
- `pthreads` - POSIX threading

📁 Location: [`RTES Project/`](./RTES%20Project/)

---

## 🚀 How to Run

### Producer-Consumer

```bash
cd "Real Time Embedded Systems/Procuder-Consumer Problem"
make
./producer_consumer
```

### RTES Final Project

**Prerequisites:**
```bash
# Install dependencies (on Raspberry Pi / Linux)
sudo apt-get install libwebsockets-dev libjansson-dev
```

**Build and Run:**
```bash
cd "Real Time Embedded Systems/RTES Project"
make
./project
```

**Visualization:**
```bash
cd PythonCode_For_Plots
python3 plot_candlesticks.py
```

---

## 🛠️ Technologies Used

| Tool | Purpose |
|------|---------|
| **C** | System programming language |
| **POSIX Threads** | Multithreading API |
| **libwebsockets** | WebSocket communication |
| **jansson** | JSON processing |
| **Make** | Build automation |
| **Python** | Data visualization |
| **Raspberry Pi** | Target platform |
