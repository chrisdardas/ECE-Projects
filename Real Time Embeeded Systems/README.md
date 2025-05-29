# ⚙️ Real-Time Embedded Systems Projects

![License](https://img.shields.io/badge/license-MIT-green.svg)
![Language](https://img.shields.io/badge/language-C-blue.svg)
![Platform](https://img.shields.io/badge/platform-Raspberry%20Pi-lightgrey.svg)

Welcome to the **Real-Time Embedded Systems** project repository! This collection showcases hands-on assignments developed during the Real-Time Embedded Systems course at the [School of Electrical and Computer Engineering](https://ece.auth.gr/), Aristotle University of Thessaloniki.

> 🛠️ Focused on real-time scheduling, concurrency, inter-process communication, and low-level hardware interaction using C and the POSIX threads API.

---

## 📚 Table of Contents

- [🚀 Overview](#-overview)
- [🧠 Core Concepts](#-core-concepts)

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
