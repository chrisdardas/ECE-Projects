# 🖼️ Digital Image Processing Projects

![License](https://img.shields.io/badge/license-MIT-green.svg)
![Language](https://img.shields.io/badge/language-Python-blue.svg)
![Library](https://img.shields.io/badge/library-OpenCV-green.svg)
![Library](https://img.shields.io/badge/library-NumPy-blue.svg)
![Semester](https://img.shields.io/badge/semester-8th-orange.svg)

This repository contains projects developed for the **Digital Image Processing** course at the School of Electrical and Computer Engineering, Aristotle University of Thessaloniki.

## 📚 Table of Contents

- [Overview](#overview)
- [Project 1: Histogram Equalization](#-project-1-histogram-equalization)
- [Project 2: Document Scanning & Edge Detection](#-project-2-document-scanning--edge-detection)
- [Project 3: Image Restoration & Wiener Filtering](#-project-3-image-restoration--wiener-filtering)
- [How to Run](#-how-to-run)

## Overview

The projects involve processing and analyzing digital images, covering:

- Image enhancement and filtering
- Histogram equalization techniques
- Edge detection and document scanning
- Image restoration and Wiener filtering
- Frequency domain analysis

---

## 📊 Project 1: Histogram Equalization

Implementation of histogram equalization techniques for image enhancement.

| File | Description |
|------|-------------|
| `global_hist_eq.py` | Global histogram equalization |
| `adaptive_hist_eq.py` | Adaptive (local) histogram equalization (CLAHE) |
| `demo.py` | Demonstration script comparing techniques |

**Key Concepts:**
- Contrast enhancement
- Global vs. adaptive approaches
- Histogram analysis and visualization

📄 Report: [`report.pdf`](./Project_1/report.pdf)

---

## 📄 Project 2: Document Scanning & Edge Detection

Automatic document detection and perspective correction (lazy scanner).

| File | Description |
|------|-------------|
| `lazy_scanner.py` | Main document scanner implementation |
| `deliverable_1.py` | Edge detection algorithms |
| `deliverable_2.py` | Corner detection and perspective transform |
| `deliverable_3.py` | Complete scanning pipeline |

**Key Concepts:**
- Canny edge detection
- Hough line transform
- Perspective transformation
- Document boundary detection

📄 Report: [`report.pdf`](./Project_2/report.pdf)

---

## 🔧 Project 3: Image Restoration & Wiener Filtering

Image restoration techniques using Wiener filtering for deblurring and denoising.

| File | Description |
|------|-------------|
| `wiener_filtering.py` | Wiener filter implementation |
| `alt_wiener_filtering.py` | Alternative Wiener filter approach |
| `demo.py` | Demonstration with test images |
| `hw3_helper_utils.py` | Helper functions and utilities |

**Test Images:**
- `cameraman.tif` - Classic test image for restoration
- `checkerboard.tif` - Geometric pattern for testing

**Key Concepts:**
- Motion blur modeling
- Wiener deconvolution
- Noise estimation
- Frequency domain filtering

📄 Report: [`report.pdf`](./Project_3/report.pdf)

---

## 🚀 How to Run

1. **Install dependencies:**
   ```bash
   pip install numpy opencv-python matplotlib scipy
   ```

2. **Navigate to project folder:**
   ```bash
   cd "Digital Image Processing/Project_1/Python Code"
   ```

3. **Run the demo:**
   ```bash
   python demo.py
   ```

---

## 🛠️ Technologies Used

- **Python 3.x** - Programming language
- **OpenCV** - Computer vision library
- **NumPy** - Numerical computing
- **Matplotlib** - Visualization
- **SciPy** - Scientific computing
