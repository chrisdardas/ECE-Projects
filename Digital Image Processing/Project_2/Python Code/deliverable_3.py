import numpy as np
import cv2 
import matplotlib.pyplot as plt
import time

start = time.time()

filepath = 'im3.jpg'

img = cv2.imread(filepath)

def my_img_rotation(img, angle):
    h, w = img.shape[:2]
    
    # Determine the number of channels
    if len(img.shape) == 2:
        dim = 1
    else:
        dim = img.shape[2]
    
    sin_theta = np.sin(angle) # find the value of sin(theta)
    cos_theta = np.cos(angle) # find the value of cos(theta)
    
    # Calculate new image dimensions based on the rotation angle we want to perform
    new_h = int(np.abs(h * cos_theta) + np.abs(w * sin_theta)) 
    new_w = int(np.abs(w * cos_theta) + np.abs(h * sin_theta))
    
    # Initialize the rotated image
    if dim == 1:
        rot_img = np.zeros((new_h, new_w), dtype=img.dtype) # if image is Grayscale we don't need a third dimension
    else:
        rot_img = np.zeros((new_h, new_w, dim), dtype=img.dtype)
    

    new_center_x, new_center_y = new_w // 2, new_h // 2 # calculating the centers of the new image
    center_x, center_y = w // 2, h // 2 #  calculating the centers of the original image
    
    # Initializing the coordinates of the rotated image, as seen by the rotated frame of reference
    y_indices, x_indices = np.indices((new_h, new_w))
    
    # finding the coordinates of the original Image assuming we know the cordinates of pixels of the rotated Image
    x_coords = (x_indices - new_center_x) * cos_theta - (y_indices - new_center_y) * sin_theta + center_x
    y_coords = (x_indices - new_center_x) * sin_theta + (y_indices - new_center_y) * cos_theta + center_y
    
    x_coords_flat = x_coords.flatten()
    y_coords_flat = y_coords.flatten()
    
    # Pad the image to avoid out-of-bound errors, accordingly for Grayscale Image and for RGB image
    if dim == 1:
        img = np.pad(img, 1, mode='constant', constant_values=0)
    else:
        img = np.pad(img, ((1, 1), (1, 1), (0, 0)), mode='constant', constant_values=0)
    
    # creating a mask which holds the indices of the  x, y coordinates on which we are going to perform bilinear interpolation
    # to find the rotated Image
    valid_mask = (x_coords_flat >= 0) & (x_coords_flat < w) & (y_coords_flat >= 0) & (y_coords_flat < h)
    
    valid_x = x_coords_flat[valid_mask]
    valid_y = y_coords_flat[valid_mask]
    
    valid_x_int = valid_x.astype(int)
    valid_y_int = valid_y.astype(int)
    
    if dim == 1:
        # Bilinear interpolation for grayscale images
        p2 = img[valid_y_int + 1, valid_x_int].astype(float)
        p8 = img[valid_y_int - 1, valid_x_int].astype(float)
        p4 = img[valid_y_int, valid_x_int - 1].astype(float)
        p6 = img[valid_y_int, valid_x_int + 1].astype(float)
        rot_values = (p2 + p4 + p6 + p8) / 4
        
        rot_img_flat = rot_img.flatten() # reducing the dimension of the Image to 1
        rot_img_flat[valid_mask] = rot_values # passing the values of the rotated pixels to the reduced Image
        rot_img = rot_img_flat.reshape((new_h, new_w)) # reshaping the array in order to correspond to a Grayscale Image
    else:
        # Bilinear interpolation for RGB images
        p2 = img[valid_y_int + 1, valid_x_int, :].astype(float)
        p8 = img[valid_y_int - 1, valid_x_int, :].astype(float)
        p4 = img[valid_y_int, valid_x_int - 1, :].astype(float)
        p6 = img[valid_y_int, valid_x_int + 1, :].astype(float)
        rot_values = (p2 + p4 + p6 + p8) / 4
        
        rot_img_flat = rot_img.reshape(-1, dim) # reducing the dimensions from 3D to a 2D array where every row of the array
        # represents a pixel and every column represents the corresponding value of each of the 3 channels
        rot_img_flat[valid_mask] = rot_values # assigning the corresponding rotation values to every pixel for all of the 3 channels
        rot_img = rot_img_flat.reshape((new_h, new_w, dim)) # reshaping the array to get the RGB Image
    
    return rot_img






first_rot = my_img_rotation(img, 54*np.pi/180)
second_rot = my_img_rotation(img, 213*np.pi/180)
rotated_img_rgb = cv2.cvtColor(first_rot, cv2.COLOR_BGR2RGB)
plt.imshow(rotated_img_rgb)
plt.show()

rotated_img_rgb = cv2.cvtColor(second_rot, cv2.COLOR_BGR2RGB)
plt.imshow(rotated_img_rgb)
plt.show()

print(f"Execution time: {time.time() - start} seconds")
