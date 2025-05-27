import numpy as np


def my_wiener_filter1(y, h, K):

    M1, N1 = y.shape# getting the dimensions of y image
    M2, N2 = h.shape# getting the dimensions of h filter
    Mx, Nx = (M1 - M2 + 1, N1 - N2 + 1) # finding the dimensions of the output of the Wiener filter
    
    # padding the h filter so it has dimensions equal to (M1 + M2 - 1)x(N1 + N2 - 1)
    h1 = np.pad(h, ((0, y.shape[0] - 1), (0, y.shape[1]- 1)), mode='constant', constant_values = 0)
    # padding the y filter so it has dimensions equal to (M1 + M2 - 1)x(N1 + N2 - 1)
    y1 = np.pad(y, ((0, h.shape[0] - 1), (0, h.shape[1] - 1)), mode='constant', constant_values  = 0)

    H = np.fft.fft2(h1)# finding the FFT of the padded h filter

    H_conj = np.conj(H) # finding the conjugate filter of the FFT H
    H_norm = np.abs(H)**2 # finding the squared norm of the FFT of the H

    G = H_conj / (H_norm + (1 / K))# creating the G Wiener filter based on the theory
    
    Y = np.fft.fft2(y1)# finding the FFT transform of the input image

    
    X_hat = G*Y # calculating the result of the Wiener filter on the input image
    x_hat = np.fft.ifft2(X_hat) # finding the inverse FFT of the output of the filter
    
    x_hat = np.real(x_hat[:Mx, :Nx]) #keeping only the real part of the inverse FFT and forcing it to have dimensions
    # equal with the input image

    return x_hat
