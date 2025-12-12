# 🤖 Robotics Projects

![License](https://img.shields.io/badge/license-MIT-green.svg)
![Language](https://img.shields.io/badge/language-MATLAB-blue.svg)
![Platform](https://img.shields.io/badge/platform-Simulation-lightgrey.svg)
![Semester](https://img.shields.io/badge/semester-8th-orange.svg)

This repository contains projects developed for the **Robotics** course at the School of Electrical and Computer Engineering, Aristotle University of Thessaloniki.

## 📚 Table of Contents

- [Overview](#overview)
- [Project Description](#-project-description)
- [Robot Models](#-robot-models)
- [How to Run](#-how-to-run)

## Overview

The project focuses on robotic arm control and kinematics, covering:

- Forward kinematics
- Inverse kinematics
- Trajectory planning
- Robot arm manipulation
- Workspace analysis

---

## 🎯 Project Description

Implementation of inverse kinematics algorithms for robotic arm control using MATLAB.

### Key Features

| Feature | Description |
|---------|-------------|
| **Inverse Kinematics** | Computing joint angles for desired end-effector position |
| **Forward Kinematics** | Computing end-effector position from joint angles |
| **Trajectory Planning** | Generating smooth paths for the robot arm |
| **Visualization** | 3D rendering of robot arm movements |

---

## 🦾 Robot Models

### UR5 Robot (`ur5robot.p`)

The UR5 is a 6-DOF industrial collaborative robot:

| Specification | Value |
|---------------|-------|
| Degrees of Freedom | 6 |
| Payload | 5 kg |
| Reach | 850 mm |
| Repeatability | ±0.1 mm |

### Human Arm Model (`human_arm.p`)

Biomechanical model of a human arm for comparison and analysis:

| Feature | Description |
|---------|-------------|
| Joint Configuration | Shoulder, elbow, wrist |
| Motion Range | Anatomically accurate limits |
| Application | Human-robot interaction studies |

---

## 💻 MATLAB Implementation

**Main File:** `robotics_final.m`

### Code Structure

```matlab
% robotics_final.m
% Main entry point for robotics simulations

% 1. Robot Model Loading
% 2. Forward Kinematics Implementation
% 3. Inverse Kinematics Solver
% 4. Trajectory Generation
% 5. Visualization and Animation
```

### Key Functions

| Function | Purpose |
|----------|---------|
| Forward Kinematics | DH parameter-based FK calculation |
| Inverse Kinematics | Numerical/analytical IK solution |
| Jacobian | Computing the Jacobian matrix |
| Trajectory | Point-to-point motion planning |

---

## 📄 Project Report

📄 Full project report: [`Robotics_10335.pdf`](./Robotics_10335.pdf)

The report includes:
- Robot model description
- DH parameter table
- Mathematical derivations
- Simulation results
- Performance analysis

---

## 🚀 How to Run

1. **Open MATLAB**

2. **Navigate to the Matlab Code folder:**
   ```matlab
   cd 'Robotics/Matlab Code'
   ```

3. **Run the main simulation:**
   ```matlab
   robotics_final
   ```

4. **View the robot visualization and results**

---

## 🛠️ Technologies Used

| Tool | Purpose |
|------|---------|
| **MATLAB** | Numerical computing and simulation |
| **Robotics Toolbox** | Robot modeling and kinematics |
| **3D Visualization** | Robot arm rendering |

---

## 📖 Key Concepts

| Concept | Description |
|---------|-------------|
| **DH Parameters** | Denavit-Hartenberg convention for robot modeling |
| **Transformation Matrices** | Homogeneous transformations for position/orientation |
| **Jacobian** | Relationship between joint and task space velocities |
| **Singularities** | Configurations where robot loses degrees of freedom |
| **Workspace** | Reachable space of the end-effector |
