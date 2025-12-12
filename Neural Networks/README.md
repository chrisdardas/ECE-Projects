# 🧠 Neural Networks Projects

![License](https://img.shields.io/badge/license-MIT-green.svg)
![Language](https://img.shields.io/badge/language-Python-blue.svg)
![Framework](https://img.shields.io/badge/framework-PyTorch-EE4C2C.svg)
![Platform](https://img.shields.io/badge/platform-Jupyter-orange.svg)
![Semester](https://img.shields.io/badge/semester-9th-orange.svg)

This repository contains projects developed for the **Neural Networks - Deep Learning** course at the School of Electrical and Computer Engineering, Aristotle University of Thessaloniki.

## 📚 Table of Contents

- [Overview](#overview)
- [CIFAR-10 Classification](#-cifar-10-classification)
- [Notebooks](#-notebooks)
- [How to Run](#-how-to-run)

## Overview

This project implements various neural network architectures for image classification on the CIFAR-10 dataset, comparing different approaches:

- K-Nearest Neighbors (KNN) and Nearest Centroid (baseline)
- Multi-Layer Perceptron (MLP)
- Convolutional Neural Networks (CNN)
- Radial Basis Function (RBF) Networks
- Support Vector Machines (SVM)

---

## 🖼️ CIFAR-10 Classification

The CIFAR-10 dataset consists of 60,000 32x32 color images in 10 classes:
- ✈️ Airplane
- 🚗 Automobile
- 🐦 Bird
- 🐱 Cat
- 🦌 Deer
- 🐕 Dog
- 🐸 Frog
- 🐴 Horse
- 🚢 Ship
- 🚚 Truck

---

## 📓 Notebooks

### 1. KNN & Nearest Centroid (`KNN-Nearest_Centroid.ipynb`)

Baseline classifiers for comparison:

| Method | Description |
|--------|-------------|
| K-NN | K-Nearest Neighbors with various k values |
| Nearest Centroid | Classification based on class centroids |

**Key Concepts:**
- Distance metrics (Euclidean, Manhattan)
- Hyperparameter tuning
- Cross-validation

---

### 2. MLP & CNN (`MLP-CNN.ipynb`)

Deep learning approaches using PyTorch:

| Architecture | Description |
|--------------|-------------|
| MLP | Fully connected network on flattened images |
| CNN | Convolutional layers for spatial feature extraction |

**Key Concepts:**
- Network architecture design
- Data augmentation
- Batch normalization
- Dropout regularization
- Learning rate scheduling
- Training vs. validation loss analysis

**Achieved Results:**
- CNN significantly outperforms MLP on CIFAR-10
- Demonstrates importance of spatial feature extraction

---

### 3. RBF Networks (`RBF.ipynb`)

Radial Basis Function neural networks:

| Component | Description |
|-----------|-------------|
| RBF Centers | K-means clustering for center selection |
| Width Parameter | Gaussian kernel width optimization |
| Output Layer | Linear combination of RBF activations |

**Key Concepts:**
- Unsupervised center learning
- Kernel-based classification
- Comparison with traditional neural networks

---

### 4. SVM Classification (`SVM.ipynb`)

Support Vector Machine classifiers:

| Kernel | Description |
|--------|-------------|
| Linear | Linear decision boundary |
| RBF | Non-linear classification with Gaussian kernel |
| Polynomial | Polynomial decision boundaries |

**Key Concepts:**
- Kernel trick
- Multi-class classification (One-vs-All, One-vs-One)
- Hyperparameter tuning (C, gamma)

---

## 🚀 How to Run

1. **Install dependencies:**
   ```bash
   pip install torch torchvision numpy matplotlib scikit-learn jupyter
   ```

2. **Launch Jupyter Notebook:**
   ```bash
   jupyter notebook
   ```

3. **Open and run notebooks:**
   - Start with `KNN-Nearest_Centroid.ipynb` for baselines
   - Then explore `MLP-CNN.ipynb` for deep learning
   - Compare with `RBF.ipynb` and `SVM.ipynb`

---

## 🛠️ Technologies Used

| Tool | Purpose |
|------|---------|
| **Python 3.x** | Programming language |
| **PyTorch** | Deep learning framework |
| **torchvision** | Dataset loading and transforms |
| **NumPy** | Numerical computing |
| **Matplotlib** | Visualization |
| **scikit-learn** | Classical ML algorithms |
| **Jupyter** | Interactive notebooks |

---

## 📊 Results Comparison

| Method | Approximate Accuracy |
|--------|---------------------|
| Nearest Centroid | ~25% |
| K-NN (k=5) | ~35% |
| MLP | ~55% |
| CNN | ~75%+ |
| SVM (RBF kernel) | ~50% |

*Note: Actual results may vary based on hyperparameters and training configuration.*
