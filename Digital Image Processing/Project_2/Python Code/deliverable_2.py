# -*- coding: utf-8 -*-
"""
Created on Tue May 14 22:48:26 2024

@author: chris
"""

import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
import cv2
import time


start = time.time()


def my_corner_harris(img, k, sigma):

    Sobel_y_kernel = 0.25 * np.array([[1, 2, 1], [0, 0, 0], [-1, -2, -1]])# Sobel kernel to find the partial dervivative in the y axis
    Sobel_x_kernel = np.transpose(Sobel_y_kernel) # Sobel kernel to find the partial derivative in the x axis

    # Applying the masks to create elements of the A matrix
    I1 = signal.convolve2d(img, Sobel_x_kernel, mode='same') 
    I2 = signal.convolve2d(img, Sobel_y_kernel, mode='same')

    I12 = I1 * I2
    I1  = I1 * I1
    I2  = I2 * I2

    # creating the Gaussian window to be odd in order to have a central pixel
    if round(4*sigma) % 2 == 0:
        N = round(4*sigma) + 1
    else:
        N = round(4*sigma)
        
    # creating the Gaussian window
    u1 = np.arange(-N, N + 1, 1)
    u2 = np.arange(-N, N + 1, 1)
    w = np.exp(-(u1[np.newaxis,:] ** 2 + u2[:, np.newaxis] ** 2) / 2*sigma**2)


    # applying the Gaussian mask to the elements of the A matrix therefore creating the M matrix
    I1  = signal.convolve2d(I1, w, mode='same')
    I2  = signal.convolve2d(I2, w, mode='same')
    I12 = signal.convolve2d(I12, w, mode='same')

    H, W = img.shape
    harris_response = np.zeros((H,W))


    # for efficiency (because the Image is EXTREMELY LARGE) I break it into chunks and 
    chunk_size = 100 

    # I calculate parts of the M matrix and finding the R value for a chunk of pixels of the original image

    for i in range(0, H, chunk_size):
        for j in range(0, W, chunk_size):

            i_end = min(i + chunk_size, H)
            j_end = min(j + chunk_size, W)
            

            I1_chunk = I1[i:i_end, j:j_end]
            I2_chunk = I2[i:i_end, j:j_end]
            I12_chunk = I12[i:i_end, j:j_end]


            M = np.empty((i_end - i, j_end - j, 2, 2))
            M[:, :, 0, 0] = I1_chunk
            M[:, :, 0, 1] = I12_chunk
            M[:, :, 1, 0] = I12_chunk
            M[:, :, 1, 1] = I2_chunk

         
            det_M = np.linalg.det(M)
            trace_M = np.trace(M, axis1=2, axis2=3)


            R_chunk = det_M - k * np.power(trace_M, 2)

            harris_response[i:i_end, j:j_end] = R_chunk
            
            
    return harris_response





def my_corner_peaks(harris_response, rel_threshold):
    
    # I calculate the threshold for which I want to find the corners
    rel_threshold = harris_response.max() * rel_threshold
    # I am finding the indices for which harris_response values are greater than this threshold
    indices = np.argwhere(harris_response > rel_threshold)
    
    # creating an array with the pixel values where each value contains the coordinates of the pixels
    corner_locations = np.array(indices)
    
    return corner_locations




filename = 'im2.jpg'

image = cv2.imread(filename)
img = cv2.imread(filename, cv2.IMREAD_GRAYSCALE) / 255



R = my_corner_harris(img, 0.05, 1)


corners = my_corner_peaks(R, 0.06)

plt.imshow(img, cmap='gray')
plt.scatter(corners[:, 1], corners[:, 0], marker='s', color='red', s=2)
plt.title('Detected Corners Using Harris Algorithm')
plt.show()


plt.imshow(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
plt.scatter(corners[:, 1], corners[:, 0], marker='s', color='red', s=2)
plt.title('Detected Corners Using Harris Algorithm')
plt.show()
    
end = time.time()
print(end - start)
    
