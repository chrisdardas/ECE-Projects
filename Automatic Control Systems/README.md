# 🎛️ Automatic Control Systems Projects

![License](https://img.shields.io/badge/license-MIT-green.svg)
![Language](https://img.shields.io/badge/language-MATLAB-blue.svg)
![Platform](https://img.shields.io/badge/platform-Simulink-lightgrey.svg)
![Semester](https://img.shields.io/badge/semester-7th-orange.svg)

This repository contains projects developed for the **Automatic Control Systems** course at the School of Electrical and Computer Engineering, Aristotle University of Thessaloniki.

## 📚 Table of Contents

- [Overview](#overview)
- [Section A: Classical Control](#-section-a-classical-control)
- [Section B: Adaptive Control (MRAC)](#-section-b-adaptive-control-mrac)
- [Project Report](#-project-report)

## Overview

The projects focus on the analysis and design of control systems, covering topics such as:

- Time-domain and frequency-domain analysis
- Stability and performance criteria
- State-space representation and control
- Model Reference Adaptive Control (MRAC)

---

## 📊 Section A: Classical Control

This section focuses on classical control techniques with various input signals:

| File | Description |
|------|-------------|
| `thema1_unit_step.m` | Unit step response analysis |
| `thema1_ramp.m` | Ramp input response analysis |
| `thema2_unit_step.m` | Extended unit step analysis |
| `thema2_ramp.m` | Ramp input with various slopes |
| `ramp1.m`, `ramp2.m`, `ramp3.m` | Ramp signal generators |
| `sat.m` | Saturation function implementation |

**Key concepts:**
- Step and ramp response analysis
- Controller design with saturation limits
- Performance metrics evaluation

---

## 🔄 Section B: Adaptive Control (MRAC)

This section implements **Model Reference Adaptive Control (MRAC)** techniques:

| File | Description |
|------|-------------|
| `MRAC.m` | Main MRAC implementation |
| `MRACtrig.m` | MRAC with trigonometric reference signals |
| `ControllerFunction.m` | Adaptive controller function |
| `ControllerFunctionMRCA.m` | MRAC-specific controller |
| `rectangular.m`, `rectangularMRCA.m` | Rectangular signal testing |
| `trigonometric.m`, `trigonometricMRCA.m` | Sinusoidal signal testing |
| `Ycalc.m` | Output calculation functions |

**Key concepts:**
- Adaptive parameter estimation
- Reference model tracking
- Lyapunov stability analysis
- Various reference input types (rectangular, trigonometric)

---

## 📄 Project Report

📄 Full project report: [`Control3_Project_AEM 10335.pdf`](./Control3_Project_AEM%2010335.pdf)

---

## 🚀 How to Run

1. Open MATLAB
2. Navigate to the `Matlab Code` folder
3. Run `main.m` for Section A or `main2.m` for Section B
4. View simulation results and plots
