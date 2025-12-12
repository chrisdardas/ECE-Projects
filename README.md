# Electrical and Computer Engineering Projects

<div align="center">

📁 A curated collection of university projects in signal processing, machine learning, embedded systems, and more  
👨‍💻 Developed during my studies at the **School of Electrical and Computer Engineering, Aristotle University of Thessaloniki**

![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![MATLAB](https://img.shields.io/badge/MATLAB-orange?style=flat&logo=mathworks&logoColor=white)
![PyTorch](https://img.shields.io/badge/PyTorch-EE4C2C?style=flat&logo=pytorch&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)
![C](https://img.shields.io/badge/C-00599C?style=flat&logo=c&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-121011?style=flat&logo=gnu-bash&logoColor=white)
![Javascript](https://img.shields.io/badge/JavaScript-F7DF1E?style=flat&logo=javascript&logoColor=black)

![GitHub repo size](https://img.shields.io/github/repo-size/chrisdardas/ECE-Projects)
![GitHub last commit](https://img.shields.io/github/last-commit/chrisdardas/ECE-Projects)
![GitHub top language](https://img.shields.io/github/languages/top/chrisdardas/ECE-Projects)
![License](https://img.shields.io/badge/license-MIT-green.svg)

</div>

## 📖 Table of Contents

- [About This Repository](#-about-this-repository)
- [Projects Overview](#-projects-overview)
- [Key Project Highlights](#-key-project-highlights)
- [Repository Structure](#-repository-structure)
- [Getting Started](#-getting-started)
- [Technologies Used](#️-technologies-used)
- [License](#-license)

## 📌 About This Repository

This repository serves as a comprehensive archive of my academic journey through the Electrical and Computer Engineering program at Aristotle University of Thessaloniki. It showcases a diverse range of projects spanning multiple domains including:

- 🔬 **Signal Processing & Communications** - Parameter estimation, antenna design, telecommunication systems
- 🤖 **Machine Learning & AI** - Deep learning, pattern recognition, neural networks
- 💻 **Systems & Software** - Embedded systems, operating systems, databases
- 🎯 **Control & Optimization** - Automatic control systems, genetic algorithms, robotics

Each folder corresponds to a specific subject or course and contains well-documented code, comprehensive reports, and supplementary materials. These projects demonstrate practical applications of theoretical concepts learned throughout the curriculum.

---

## 🧠 Projects Overview

| Subject | Project | Semester | Tools/Technologies |
|--------|---------|----------|---------------------|
| [Telecommunication Systems](./Telecommunication%20Systems) | SNR Optimization & Parameter Estimation | 6th | MATLAB |
| [Antennas & Propagation](./Antennas%20%26%20Propagation) | Antenna Design, Radiation Patterns & Array Beamforming | 7th | MATLAB, 4nec2 |
| [Automatic Control Systems](./Automatic%20Control%20Systems) | Classical Control & Model Reference Adaptive Control (MRAC) | 7th | MATLAB, Simulink |
| [Optimization Techniques](./Optimization%20Techniques) | Steepest Descent, Constrained Optimization & Genetic Algorithms | 7th | MATLAB |
| [Robotics](./Robotics) | UR5 Robot Inverse Kinematics & Trajectory Planning | 8th | MATLAB |
| [Simulation & Modeling](./Simulation-Modelling) | Offline/Online Parameter Estimation (LS, RLS, Gradient Descent) | 8th | MATLAB |
| [Digital Image Processing](./Digital%20Image%20Processing) | Histogram Equalization, Document Scanning & Wiener Filtering | 8th | Python, OpenCV |
| [Estimation & Detection Theory](./Estimation%20%26%20Detection%20Theory) | MLE, MMSE & Detection Theory | 8th | MATLAB |
| [Real-Time Embedded Systems](./Real%20Time%20Embedded%20Systems) | Producer-Consumer, Real-Time Stock Data Processing | 8th | C, pthreads |
| [Data Analysis](./Data%20Analysis) | Statistical Analysis, Regression & Hypothesis Testing | 9th | MATLAB |
| [Databases](./Databases) | Full-Stack Game Database (MySQL + React + Node.js) | 9th | MySQL, JavaScript, React |
| [Neural Networks](./Neural%20Networks) | CIFAR-10 Classification with MLP, CNN, RBF & SVM | 9th | PyTorch, Python |
| [Operating Systems](./Operating%20Systems) | Process Management, IPC & Shell Scripting | 9th | C, Bash |
| [Software Engineering II](./SE2_Project) | Unit Testing (Ava) & E2E Testing (Cypress) | 9th | JavaScript, Ava, Cypress |
| [Pattern Recognition & ML](./Pattern%20Recognition%20%26%20Machine%20Learning) | PCA, K-NN, SVM & Random Forest Classification | 9th | Scikit-learn, Python |

---

## 🌟 Key Project Highlights

### 🔥 Neural Networks - CIFAR-10 Classification
Deep learning project implementing multiple neural network architectures for image classification on the CIFAR-10 dataset, comparing traditional and deep learning approaches.

**Key Features:**
- Multi-Layer Perceptron (MLP) implementation from scratch
- Custom Convolutional Neural Network (CNN) architecture
- Radial Basis Function (RBF) networks
- Support Vector Machine (SVM) comparison
- Data augmentation and regularization techniques
- Comprehensive performance analysis and visualization

### 🎮 Full-Stack Database Application
End-to-end development of a game database system with complete backend API and modern React frontend.

**Technologies:** MySQL, JavaScript, React, Node.js, Express, JWT Authentication

**Features:**
- RESTful API design
- User authentication
- CRUD operations
- Docker containerization

### ⚙️ Real-Time Embedded Systems - Stock Data Processing
Multi-threaded real-time application for processing live financial data on Raspberry Pi.

**Key Features:**
- WebSocket connection to Finnhub API
- Producer-consumer pattern with bounded buffer
- Candlestick chart generation
- Moving average calculations
- POSIX threads synchronization

### 🤖 Robotics - UR5 Inverse Kinematics
Implementation of robotic arm control using inverse kinematics algorithms in MATLAB for the UR5 industrial robot.

**Key Features:**
- DH parameter modeling
- Forward and inverse kinematics
- Trajectory planning
- 3D visualization

### 📡 Antenna Design & Simulation
Advanced antenna modeling and simulation using 4nec2 software, analyzing radiation patterns, impedance matching, and array configurations.

---

## 📁 Repository Structure

```
ECE-Projects/
├── Antennas & Propagation/              # Antenna modeling, radiation patterns, array design
├── Automatic Control Systems/           # Classical control & MRAC adaptive control
├── Data Analysis/                       # Statistical analysis, regression, hypothesis testing
├── Databases/                           # Full-stack game database (MySQL + React + Node.js)
├── Digital Image Processing/            # Histogram equalization, document scanning, Wiener filtering
├── Estimation & Detection Theory/       # MLE, MMSE, detection theory
├── Neural Networks/                     # CIFAR-10 classification (MLP, CNN, RBF, SVM)
├── Operating Systems/                   # Process management, IPC, shell scripting
├── Optimization Techniques/             # Gradient descent, constrained optimization, genetic algorithms
├── Pattern Recognition & ML/            # PCA, K-NN, SVM, decision trees, random forest
├── Real Time Embedded Systems/          # Producer-consumer, real-time stock data processing
├── Robotics/                            # UR5 robot inverse kinematics, trajectory planning
├── SE2_Project/                         # Software testing (Ava unit tests, Cypress E2E)
├── Simulation-Modelling/                # Offline/online parameter estimation (LS, RLS)
└── Telecommunication Systems/           # SNR optimization, parameter estimation
```

---

## 🚀 Getting Started

### Prerequisites

Depending on the project you want to explore, you may need:

- **MATLAB** (R2019b or later) - For signal processing, control systems, and robotics projects
- **Python 3.7+** - For machine learning, image processing, and data analysis projects
- **PyTorch** - For neural network projects
- **MySQL** - For database projects
- **Node.js & npm** - For full-stack web development projects
- **GCC Compiler** - For C-based embedded systems projects

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/chrisdardas/ECE-Projects.git
   cd ECE-Projects
   ```

2. **Navigate to a specific project:**
   ```bash
   cd "Neural Networks"  # Example
   ```

3. **Follow project-specific instructions:**
   Each project folder may contain its own README with detailed setup and execution instructions.

### Running Python Projects

For Python-based projects (Neural Networks, Digital Image Processing, Pattern Recognition):

```bash
# Install required packages
pip install -r requirements.txt  # If available

# Run Jupyter notebooks
jupyter notebook
```

### Running MATLAB Projects

For MATLAB-based projects (most signal processing and control projects):

```matlab
% Open MATLAB and navigate to the project folder
cd 'path/to/project'

% Run the main script
main.m  % Or the specific entry point file
```

---

## 🛠️ Technologies Used

### Programming Languages
- **Python** - Machine learning, data analysis, image processing
- **MATLAB** - Signal processing, control systems, simulations, robotics
- **C** - Embedded systems, operating systems, real-time applications
- **JavaScript** - Full-stack web development (Node.js, React)
- **SQL** - Database design, queries, stored procedures
- **Bash** - Shell scripting and system administration

### Frameworks & Libraries
- **PyTorch** - Deep learning framework for neural networks
- **Scikit-learn** - Classical machine learning algorithms
- **OpenCV** - Computer vision and image processing
- **NumPy & Pandas** - Data manipulation and analysis
- **Matplotlib & Seaborn** - Data visualization
- **React** - Frontend development
- **Node.js & Express** - Backend development, REST APIs
- **MySQL** - Relational database management
- **libwebsockets** - WebSocket communication for real-time systems
- **pthreads** - POSIX threading for concurrent programming

### Tools & Software
- **4nec2** - Antenna modeling and simulation
- **Jupyter Notebook** - Interactive computing environment
- **Git** - Version control
- **Docker** - Containerization
- **Ava** - JavaScript unit testing framework
- **Cypress** - End-to-end testing framework

---

## 📄 License

This repository is licensed under the MIT License - see the individual project folders for specific licensing information.

---
