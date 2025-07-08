# 🧪 Simulation & Modelling Projects

![License](https://img.shields.io/badge/license-MIT-green.svg)  
![Language](https://img.shields.io/badge/language-MATLAB-blue.svg)  
![Platform](https://img.shields.io/badge/platform-Simulation-lightgrey.svg)

This repository contains simulation and modelling projects developed as part of the **ECE Projects** curriculum at the School of Electrical and Computer Engineering, Aristotle University of Thessaloniki.

## 📚 Table of Contents

- [Overview](#overview)
- [Projects](#projects)
  - [Project A: Offline Least Squares Method](./Lab01)
  - [Project B: Online Estimation Methods](./Lab02)
  - [Project C: Robust Online Parameter Estimation](./Project)
- [Usage](#usage)
- [Requirements](#requirements)
- [Contributing](#contributing)
- [License](#license)

## Overview

This collection of MATLAB-based simulation projects explores essential methods in system identification and real-time parameter estimation, including:

- Offline and online parameter estimation
- Gradient-based adaptation
- Stability and convergence analysis
- Real-time simulation of dynamic systems

## Projects

### 🧮 Project A: Offline Least Squares Method

- Implements classic Least Squares (LS) to estimate system parameters using pre-recorded data.
- Processes all data at once to minimize squared error between model outputs and measured values.
- Useful for accurate parameter identification when the full dataset is available.

### 🔄 Project B: Online Estimation Methods

- Introduces real-time (online) estimation techniques such as:
  - Gradient descent
  - Recursive least squares (RLS)
  - Lyapunov-based update rules
- Parameters are updated incrementally as new measurements become available.
- Enables adaptive behaviour in dynamic systems.

### 🛡️ Project C: Robust Online Parameter Estimation

- Enhances online methods with:
  - Projection algorithms to enforce parameter constraints
  - Normalization techniques for boundedness
  - Lyapunov stability analysis
- Supports robust, stable adaptation under real-time constraints and uncertain data.

## Usage

1. Clone this repository:
   ```bash
   git clone https://github.com/chrisdardas/ECE-Projects.git
