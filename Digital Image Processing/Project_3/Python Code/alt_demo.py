# -*- coding: utf-8 -*-
"""
Created on Mon Jun 17 22:34:37 2024

@author: chris
"""

import numpy as np
import matplotlib.pyplot as plt
import cv2
import hw3_helper_utils
from scipy.signal import convolve2d
from alt_wiener_filtering import my_wiener_filter1

K = 20
length_angle = [(10, 0), (20, 30)]
noise_levels = [0.02, 0.2]
images = ['checkerboard.tif', 'cameraman.tif']


for filename in images:
    for value in length_angle:
        for n in noise_levels:
            
            x = cv2.imread(filename, cv2.IMREAD_GRAYSCALE)  # reading the input image
            x = x.astype(np.float32) / 255.0
            h = hw3_helper_utils.create_motion_blur_filter(value[0], value[1])  # creating the motion blur filter
            y0 = convolve2d(x, h, mode="full")  # convolving the input image with the motion blur image
            v = n * np.random.randn(*y0.shape)  # creating the noise
            
            y = y0 + v # adding WGN to the result of the convolution

            M1, N1 = y.shape
            M2, N2 = h.shape
            (Mx, Nx) = (M1 - M2 + 1, N1 - N2 + 1)

            x_hat = my_wiener_filter1(y, h, K)  # getting the result of the wiener filter
            
            # correctly padding the filter and the y and y0 images so I can perform the DFT
            h1 = np.pad(h, ((0, y.shape[0] - 1), (0, y.shape[1] - 1)), mode='constant', constant_values = 0)
            y1 = np.pad(y, ((0, h.shape[0] - 1), (0, h.shape[1] - 1)), mode='constant', constant_values = 0)
            y2 = np.pad(y0, ((0, h.shape[0] - 1), (0, h.shape[1] - 1)), mode='constant', constant_values = 0)

            H = np.fft.fft2(h1)  # performing the FFT transform on the padded filter
            Y = np.fft.fft2(y1)  # performing the FFT transform on the result of the convolution with WGN
            
            mask = np.abs(H) < 1e-8  # creating a mask to find all the values of H which have a value close to zero
            H_inv = 1 / H  # creating the H_inv filter
            H_inv[mask] = 0  #  frequencies that are zero for the H filter are set to zero for the 1/H

            X_inv = Y * H_inv
            x_inv = np.fft.ifft2(X_inv)
            
            x_inv = np.real(x_inv[:y.shape[0], :y.shape[1]])

            Y0 = np.fft.fft2(y2)

            X_inv0 = Y0 * H_inv
            x_inv0 = np.fft.ifft2(X_inv0)
            
            x_inv0 = np.real(x_inv0[:y.shape[0], :y.shape[1]])

            x_hat = x_hat[:Mx, :Nx]
            x_inv = x_inv[:Mx, :Nx]
            x_inv0 = x_inv0[:Mx, :Nx]

            # creating a list for J for K in range from 1 to 200
            J = []

            for k in range(1, 201):
                x_hat1 = my_wiener_filter1(y, h, k)
                J.append(np.mean((x_inv0 - x_hat1) ** 2))

            x_hat = np.clip(x_hat, 0, 1)
            x_inv = np.clip(x_inv, 0, 1)
            x_inv0 = np.clip(x_inv0, 0, 1)

            # plotting the desired images
            fig, axs = plt.subplots(nrows=2, ncols=3)
            fig.suptitle(f'Filename = {filename}, K = {K}, length_angle = {value}, noise_level = {n}', fontsize=16)
            axs[0][0].imshow(x, cmap='gray')
            axs[0][0].set_title("Original image x")
            axs[0][1].imshow(y0, cmap='gray')
            axs[0][1].set_title("Clean image y0")
            axs[0][2].imshow(y, cmap='gray')
            axs[0][2].set_title("Blurred and noisy image y")
            axs[1][0].imshow(x_inv0, cmap='gray')
            axs[1][0].set_title("Inverse filtering noiseless output x_inv0")
            axs[1][1].imshow(x_inv, cmap='gray')
            axs[1][1].set_title("Inverse filtering noisy output x_inv")
            axs[1][2].imshow(x_hat, cmap='gray')
            axs[1][2].set_title("Wiener filtering output x_hat")
            plt.show()

            #  plotting the J curve and finding the best K which minimises the MSE
            plt.plot(J)
            plt.ylabel('MSE for J')
            plt.xlabel('K')
            plt.title('MSE')
            minJ = np.argmin(J) + 1
            plt.axvline(minJ, color = 'r', label=f'Optimal K = {minJ}')
            plt.legend()
            plt.grid()
            plt.show()


