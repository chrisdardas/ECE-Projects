# 💻 Operating Systems Projects

![License](https://img.shields.io/badge/license-MIT-green.svg)
![Language](https://img.shields.io/badge/language-C-blue.svg)
![Language](https://img.shields.io/badge/language-Bash-green.svg)
![Platform](https://img.shields.io/badge/platform-Linux-lightgrey.svg)
![Semester](https://img.shields.io/badge/semester-9th-orange.svg)

This repository contains projects developed for the **Operating Systems** course at the School of Electrical and Computer Engineering, Aristotle University of Thessaloniki.

## 📚 Table of Contents

- [Overview](#overview)
- [OS Labs](#-os-labs)
- [Bash Quizzes](#-bash-quizzes)
- [How to Run](#-how-to-run)

## Overview

The projects focus on operating system concepts and UNIX/Linux programming, including:

- Process management (fork, exec, wait)
- Inter-process communication (pipes, signals)
- File I/O operations
- Shell scripting and Bash programming
- Memory management
- System calls

---

## 🔬 OS Labs

### Lab 01: Introduction to Linux
Basic Linux commands and environment setup.

### Lab 02: Shell Basics
Shell scripting fundamentals and command-line operations.

### Lab 03: Process Creation

| File | Description |
|------|-------------|
| `lab03.c` | Main process creation program |
| `lab03.h` | Header file with declarations |
| `Makefile` | Build automation |

**Key Concepts:**
- `fork()` system call
- Process hierarchy
- Parent-child relationships

---

### Lab 04: Inter-Process Communication

| File | Description |
|------|-------------|
| `example1.c` | Basic process creation |
| `example2.c` | Process synchronization |
| `example3.c` | Shared memory introduction |
| `example4.c` | Pipe communication |
| `example5.c` | Advanced IPC |

**Key Concepts:**
- Pipes and FIFOs
- Signal handling
- Process synchronization

---

### Lab 05: Advanced Topics
Advanced operating system concepts including scheduling and memory management.

---

### Lab X: System Calls Deep Dive

| File | Description |
|------|-------------|
| `fork.c` | Process forking examples |
| `kill.c` | Signal sending and handling |
| `pipe.c` | Pipe-based communication |
| `sum.c` | Parallel computation |
| `writeFile.c` | File I/O operations |

---

## 📝 Bash Quizzes

Shell scripting exercises covering various aspects of Bash programming:

### Quiz 1: Basic Shell Scripts

| File | Description |
|------|-------------|
| `calculateAEM.sh` | Student ID calculation script |
| `FINAL_v2.sh` | Final version of utility scripts |
| `final.sh` | Complete solution |
| `test.sh` | Test scripts |

---

### Quiz 2-5: Advanced Scripting

Progressive exercises covering:
- Text processing with `awk`, `sed`, `grep`
- File manipulation
- Control structures
- Functions and parameters
- Regular expressions

---

## 🚀 How to Run

### C Programs

1. **Navigate to lab folder:**
   ```bash
   cd "Operating Systems/OS Labs/Lab03"
   ```

2. **Compile the code:**
   ```bash
   make
   # or
   gcc -o program lab03.c
   ```

3. **Run the program:**
   ```bash
   ./program
   ```

### Bash Scripts

1. **Make executable:**
   ```bash
   chmod +x script.sh
   ```

2. **Run:**
   ```bash
   ./script.sh
   # or
   bash script.sh
   ```

---

## 🛠️ Technologies Used

| Tool | Purpose |
|------|---------|
| **C** | System programming |
| **Bash** | Shell scripting |
| **GCC** | C compiler |
| **Make** | Build automation |
| **Linux** | Operating system |

---

## 📖 Key Concepts Covered

| Topic | Labs |
|-------|------|
| Process Management | Lab 03, Lab 04, Lab X |
| IPC (Pipes, Signals) | Lab 04, Lab X |
| File Operations | Lab X |
| Shell Scripting | Quiz 1-5 |
| System Calls | All Labs |
