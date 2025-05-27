import numpy as np 
import cv2
import matplotlib.pyplot as plt
import time


start = time.time()


filepath = 'im2.jpg'

image = cv2.imread(filepath)
img = cv2.imread(filepath, cv2.IMREAD_GRAYSCALE)

#img = cv2.resize(img, (1020, 1320))
#img = cv2.GaussianBlur(img, (13, 13), sigmaX = 2)
#edges = cv2.Canny(img, 90, 180)

img = cv2.GaussianBlur(img, (37,37), sigmaX = 6) # applying Gaussian mask to smoothe the image
edges = cv2.Canny(img, 25, 75) # applying Canny edge detector with these thresholds
#img = cv2.GaussianBlur(img, (7, 7), sigmaX = 1) # applying Gaussian mask to smooth the image
#edges = cv2.Canny(img, 100, 300) # applying Canny edge detector with these thresholds

binary_image = np.where(edges > 0, 255, 0).astype(np.uint8)


def my_hough_transform(img_binary, d_rho, d_theta, n):
    
    H, W = img_binary.shape
    
    rho_max = np.ceil(np.sqrt(H**2 + W**2)).astype(int) # get maximum rho value to be equal to the diagonal of the input image
    
    rho_values = np.arange(-rho_max, rho_max, d_rho) # create a rho vector with  d_rho step
    theta_values = np.arange(-np.pi/2, np.pi/2, d_theta) # create a theta vector with d_theta step
    
    Hough = np.zeros((2*rho_max, len(theta_values))) # initialize the Hough matrix
    
    edge_pixels = np.argwhere(img_binary > 0) # find all the edge pixels
    
    cos_theta = np.cos(theta_values) # vector of cosine values
    sin_theta = np.sin(theta_values) # vector of sine values
    
    
    x, y = edge_pixels[:,1], edge_pixels[:,0] # get the corresponding coordinates of the pixels
    
    rho = x[:, np.newaxis] * cos_theta + y[:, np.newaxis] * sin_theta # create a vector of all the rho values
    
    rho_index = np.floor(rho/d_rho).astype(int) # round down all the rho values as integers
    np.add.at(Hough, (rho_index + rho_max, np.arange(len(theta_values))), 1) # add one vote to the element with the 
    # rho and theta index
    
    
    loc_max = find_local_maxima(Hough, n) # function to find the n greatest local maxima of the Hough matrix
    
    L = np.zeros((n,2)) # initializing the line matrix
    rho_index = loc_max[:, 0] # retreiving the rho indices
    theta_index = loc_max[:, 1] # retreiving the theta_indices 
    
    L[:, 0] = rho_index - rho_max
    L[:, 1] = theta_values[theta_index] 
    
   
   # Determine pixels not contributing to the local maxima
    maxima_votes = np.zeros((H, W), dtype=bool)
    
    for i, j in loc_max:
        rho = rho_values[i]
        theta = theta_values[j]
        for y, x in edge_pixels:
            rho_computed = x * np.cos(theta) + y * np.sin(theta)
            closest_rho_index = int(np.floor(rho_computed / d_rho))
            if closest_rho_index == i:
                maxima_votes[y, x] = True
    
    res = np.sum((img_binary > 0) & (~maxima_votes))
    
    return [Hough, L, res]
    

def find_local_maxima(array, n):
    
    masked_array = array
    
    array = np.pad(array, (1,1), mode='constant', constant_values = (0,0)) # padding the array with zeros 
    
    mask = (array[1:-1, 1:-1] > array[:-2, 1:-1]) & \
           (array[1:-1, 1:-1] > array[2:, 1:-1]) & \
           (array[1:-1, 1:-1] > array[1:-1, :-2]) & \
           (array[1:-1, 1:-1] > array[1:-1, 2:]) & \
           (array[1:-1, 1:-1] > array[:-2, :-2]) & \
           (array[1:-1, 1:-1] > array[:-2, 2:]) & \
           (array[1:-1, 1:-1] > array[2:, :-2]) & \
           (array[1:-1, 1:-1] > array[2:, 2:]) # comparing each pixel with all its 8 neighbours to decide if it is a local maximum
           
    local_maxima = np.argwhere(mask) # getting the indices of all the local maxima
    
    # sorting the local maxima in declining order
    sorted_indices = np.argsort(masked_array[mask])[::-1] 
    local_maxima = local_maxima[sorted_indices]
    
    if n >= len(local_maxima):
        return local_maxima
    else:
        return local_maxima[:n] # returning the first n local maxima
    


# Perform Hough Transform
d_rho = 1
d_theta = np.pi / 180
n = 8 # Number of lines to detect
Hough, lines, res = my_hough_transform(binary_image, d_rho, d_theta, n)


# Extract points for plt.scatter
points_x = []
points_y = []
threshold = 1e-6  # Small value to avoid division by zero
for rho, theta in lines:
    a = np.cos(theta)
    b = np.sin(theta)
    if np.abs(b) > threshold:
        for x in range(binary_image.shape[1]):
            y = (rho - x * a) / b
            if 0 <= y < binary_image.shape[0]:
                points_x.append(x)
                points_y.append(int(y))
    if np.abs(a) > threshold:
        for y in range(binary_image.shape[0]):
            x = (rho - y * b) / a
            if 0 <= x < binary_image.shape[1]:
                points_x.append(int(x))
                points_y.append(y)

# Plot the original image with the detected edges
H, W = binary_image.shape
 
rho_max = np.ceil(np.sqrt(H**2 + W**2)).astype(int) 
rho = np.floor(lines[:,0]/d_rho + rho_max) 
theta = np.floor(lines[:,1]/(d_theta*180/np.pi) + np.pi/2 ) * (180/np.pi)
print(theta)
plt.imshow(Hough, cmap='gray')
plt.gca().set_aspect(0.01)
plt.scatter(theta,rho,color='red',s=1)
plt.show()

# RGB image with the lines found by Hough Transform
#points_x = [5*x for x in points_x]
#points_y = [5*y for y in points_y]
plt.imshow(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
plt.scatter(points_x, points_y, color='red', s=0.01)
plt.title('Detected Edges using Hough Transform')
plt.show()


# Grayscale Image with the lines found by Hough Transform
plt.imshow(img, cmap='gray')
plt.scatter(points_x, points_y, color='red', s=0.01)
plt.title('Detected Edges using Hough Transform')
plt.show()

# Print execution time
print(f"Execution time: {time.time() - start} seconds")
print(res)



