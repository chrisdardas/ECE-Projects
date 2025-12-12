# 🤖 Pattern Recognition & Machine Learning Projects

![License](https://img.shields.io/badge/license-MIT-green.svg)
![Language](https://img.shields.io/badge/language-Python-blue.svg)
![Library](https://img.shields.io/badge/library-Scikit--learn-orange.svg)
![Platform](https://img.shields.io/badge/platform-Jupyter-orange.svg)
![Semester](https://img.shields.io/badge/semester-9th-orange.svg)

This repository contains projects developed for the **Pattern Recognition & Machine Learning** course at the School of Electrical and Computer Engineering, Aristotle University of Thessaloniki.

## 📚 Table of Contents

- [Overview](#overview)
- [Notebooks](#-notebooks)
- [Dataset](#-dataset)
- [How to Run](#-how-to-run)

## Overview

The projects focus on classical machine learning algorithms for pattern classification, including:

- Dimensionality reduction (PCA)
- K-Nearest Neighbors (KNN)
- Support Vector Machines (SVM)
- Decision trees and ensemble methods
- Model evaluation and cross-validation

---

## 📓 Notebooks

### 1. Classification & Analysis (`Team22-AC.ipynb`)

Main classification notebook implementing various algorithms:

| Algorithm | Description |
|-----------|-------------|
| **PCA** | Principal Component Analysis for dimensionality reduction |
| **K-NN** | K-Nearest Neighbors classifier |
| **SVM** | Support Vector Machines with various kernels |
| **Decision Trees** | Tree-based classification |
| **Random Forest** | Ensemble of decision trees |

**Key Topics:**
- Feature extraction and selection
- Model training and hyperparameter tuning
- Cross-validation strategies
- Performance metrics (accuracy, precision, recall, F1)
- Confusion matrix analysis
- ROC curves and AUC

---

### 2. Dimensionality Reduction (`Team22-D.ipynb`)

Deep dive into dimensionality reduction techniques:

| Technique | Description |
|-----------|-------------|
| **PCA** | Linear projection to principal components |
| **LDA** | Linear Discriminant Analysis |
| **Feature Selection** | Selecting most relevant features |

**Key Topics:**
- Eigenvalue decomposition
- Variance explained ratio
- Optimal number of components
- Visualization of reduced data

---

## 📊 Dataset

**File:** `labels22.npy`

The dataset contains labeled samples for multi-class classification:
- Features are stored in NumPy format
- Labels correspond to distinct pattern classes
- Used for training and evaluation of classifiers

---

## 📄 Project Report

📄 Full project report: [`Team22.pdf`](./Team22.pdf)

The report includes:
- Theoretical background
- Algorithm descriptions
- Experimental setup
- Results and analysis
- Conclusions

---

## 🚀 How to Run

1. **Install dependencies:**
   ```bash
   pip install numpy scikit-learn matplotlib seaborn jupyter
   ```

2. **Navigate to Python Code folder:**
   ```bash
   cd "Pattern Recognition & Machine Learning/Python Code"
   ```

3. **Launch Jupyter Notebook:**
   ```bash
   jupyter notebook
   ```

4. **Open and run notebooks:**
   - `Team22-AC.ipynb` - Main classification experiments
   - `Team22-D.ipynb` - Dimensionality reduction analysis

---

## 🛠️ Technologies Used

| Tool | Purpose |
|------|---------|
| **Python 3.x** | Programming language |
| **NumPy** | Numerical computing |
| **Scikit-learn** | Machine learning library |
| **Matplotlib** | Plotting and visualization |
| **Seaborn** | Statistical visualization |
| **Jupyter** | Interactive notebooks |

---

## 📈 Algorithms Summary

| Algorithm | Type | Use Case |
|-----------|------|----------|
| PCA | Unsupervised | Dimensionality reduction |
| K-NN | Supervised | Instance-based classification |
| SVM | Supervised | Margin-based classification |
| Decision Tree | Supervised | Rule-based classification |
| Random Forest | Ensemble | Robust classification |

---

## 🎯 Key Results

The project demonstrates:
- Effect of PCA on classification performance
- Comparison of different classifiers
- Impact of hyperparameter tuning
- Trade-offs between model complexity and accuracy
