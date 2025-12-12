# 📡 Telecommunication Systems Projects

![License](https://img.shields.io/badge/license-MIT-green.svg)
![Language](https://img.shields.io/badge/language-MATLAB-blue.svg)
![Semester](https://img.shields.io/badge/semester-6th-orange.svg)

This repository contains projects developed for the **Telecommunication Systems** course at the School of Electrical and Computer Engineering, Aristotle University of Thessaloniki.

## 📚 Table of Contents

- [Overview](#overview)
- [Project: SNR Optimization](#-project-snr-optimization)
- [MATLAB Implementation](#-matlab-implementation)
- [How to Run](#-how-to-run)

## Overview

The project focuses on parameter estimation and optimization in communication systems, including:

- Signal-to-Noise Ratio (SNR) analysis
- Parameter estimation techniques
- Optimal transmission angle determination
- Communication system performance optimization

---

## 📊 Project: SNR Optimization

### Problem Description

Estimating optimal transmission parameters to maximize the Signal-to-Noise Ratio (SNR) in a communication system.

### Key Objectives

| Objective | Description |
|-----------|-------------|
| Parameter Estimation | Determine optimal system parameters |
| SNR Maximization | Find configuration for maximum SNR |
| Performance Analysis | Analyze system behavior under different conditions |

---

## 💻 MATLAB Implementation

The `Matlab Code` folder contains implementations of various estimation algorithms:

| File | Description |
|------|-------------|
| `Askisi1.m` | Main exercise implementation |
| `BestA.m` | Optimal amplitude calculation |
| `BestTHETA.m` | Optimal angle estimation |
| `Comparison.m` | Comparison of different methods |
| `OptimalTheta.m` | Theta optimization algorithm |
| `maxSEP.m` | Maximum Separation computation |
| `maxtheta.m` | Maximum theta calculation |

### Algorithm Overview

```
1. System Model Definition
   └── Define channel characteristics and noise model

2. Parameter Space Exploration
   └── Search for optimal transmission parameters

3. SNR Calculation
   └── Compute SNR for each parameter configuration

4. Optimization
   └── Find parameters maximizing SNR

5. Results Visualization
   └── Plot SNR vs parameters
```

---

## 📈 Key Concepts

| Concept | Description |
|---------|-------------|
| **SNR** | Ratio of signal power to noise power |
| **BER** | Bit Error Rate in digital communications |
| **AWGN** | Additive White Gaussian Noise model |
| **Optimal θ** | Transmission angle for maximum performance |

---

## 📄 Project Report

📄 Full project report: [`report.pdf`](./report.pdf)

The report includes:
- Theoretical background on SNR
- Mathematical derivations
- Simulation methodology
- Results and analysis
- Conclusions

---

## 🚀 How to Run

1. **Open MATLAB**

2. **Navigate to the Matlab Code folder:**
   ```matlab
   cd 'Telecommunication Systems/Matlab Code'
   ```

3. **Run the main script:**
   ```matlab
   Askisi1
   ```

4. **For comparisons:**
   ```matlab
   Comparison
   ```

5. **View results and plots**

---

## 🛠️ Technologies Used

| Tool | Purpose |
|------|---------|
| **MATLAB** | Numerical computing and simulation |
| **Communications Toolbox** | Communication system modeling |

---

## 📊 Results

The project demonstrates:
- Impact of transmission angle on SNR
- Optimal parameter selection strategies
- Trade-offs in communication system design
- Performance visualization techniques
