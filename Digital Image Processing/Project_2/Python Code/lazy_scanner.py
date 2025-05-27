import numpy as np
import cv2
import matplotlib.pyplot as plt
import itertools

# Load image
filepath = 'im4.jpg'
img = cv2.imread(filepath, cv2.IMREAD_GRAYSCALE)

# Verify the image is loaded correctly
if img is None:
    raise ValueError(f"Image at path {filepath} could not be loaded.")

# Apply Gaussian blur and Canny edge detector
img = cv2.resize(img, (1020, 1320))
img = cv2.GaussianBlur(img, (13, 13), sigmaX=2)
edges = cv2.Canny(img, 90, 180)

binary_image = np.where(edges > 0, 255, 0).astype(np.uint8)

def my_hough_transform(img_binary, d_rho, d_theta, n):
    H, W = img_binary.shape
    rho_max = np.ceil(np.sqrt(H**2 + W**2)).astype(int)
    rho_values = np.arange(-rho_max, rho_max, d_rho)
    theta_values = np.arange(-np.pi / 2, np.pi / 2, d_theta)
    Hough = np.zeros((2 * rho_max, len(theta_values)))
    edge_pixels = np.argwhere(img_binary > 0)
    cos_theta = np.cos(theta_values)
    sin_theta = np.sin(theta_values)
    x, y = edge_pixels[:, 1], edge_pixels[:, 0]
    rho = x[:, np.newaxis] * cos_theta + y[:, np.newaxis] * sin_theta
    rho_index = np.floor(rho / d_rho).astype(int)
    np.add.at(Hough, (rho_index + rho_max, np.arange(len(theta_values))), 1)
    loc_max, loc_max_values = find_local_maxima(Hough, n)
    L = np.zeros((n, 2))
    rho_index = loc_max[:, 0]
    theta_index = loc_max[:, 1]
    L[:, 0] = rho_index - rho_max
    L[:, 1] = theta_values[theta_index]
    return [Hough, L]

def find_local_maxima(array, n):
    masked_array = array
    array = np.pad(array, (1, 1), mode='constant', constant_values=(0, 0))
    mask = (array[1:-1, 1:-1] > array[:-2, 1:-1]) & \
           (array[1:-1, 1:-1] > array[2:, 1:-1]) & \
           (array[1:-1, 1:-1] > array[1:-1, :-2]) & \
           (array[1:-1, 1:-1] > array[1:-1, 2:]) & \
           (array[1:-1, 1:-1] > array[:-2, :-2]) & \
           (array[1:-1, 1:-1] > array[:-2, 2:]) & \
           (array[1:-1, 1:-1] > array[2:, :-2]) & \
           (array[1:-1, 1:-1] > array[2:, 2:])
    local_maxima = np.argwhere(mask)
    sorted_indices = np.argsort(masked_array[mask])[::-1]
    local_maxima = local_maxima[sorted_indices]
    if n >= len(local_maxima):
        return local_maxima, masked_array[mask][sorted_indices]
    else:
        return local_maxima[:n], masked_array[mask][sorted_indices][:n]

def find_intersections(lines):
    intersections = []
    for (rho1, theta1), (rho2, theta2) in itertools.combinations(lines, 2):
        angle_diff = np.abs(theta1 - theta2)
        # Check if lines are perpendicular 
        if np.abs(angle_diff - np.pi / 2) < np.deg2rad(10):  # Allowing a small tolerance of 1 degrees
            if np.abs(np.sin(theta1 - theta2)) > 1e-6:  # Ensure lines are not parallel
                A = np.array([[np.cos(theta1), np.sin(theta1)], [np.cos(theta2), np.sin(theta2)]])
                B = np.array([rho1, rho2])
                intersection = np.linalg.solve(A, B)
                if (0 <= intersection[0] < img.shape[1]) and (0 <= intersection[1] < img.shape[0]):
                    intersections.append(intersection)
    return np.array(intersections)

def order_points(pts):
    rect = np.zeros((4, 2), dtype="float32")
    s = pts.sum(axis=1)
    rect[0] = pts[np.argmin(s)]
    rect[2] = pts[np.argmax(s)]
    diff = np.diff(pts, axis=1)
    rect[1] = pts[np.argmin(diff)]
    rect[3] = pts[np.argmax(diff)]
    return rect

def four_point_transform(image, pts):
    rect = order_points(pts)
    (tl, tr, br, bl) = rect

    widthA = np.sqrt(((br[0] - bl[0]) ** 2) + ((br[1] - bl[1]) ** 2))
    print(widthA)
    widthB = np.sqrt(((tr[0] - tl[0]) ** 2) + ((tr[1] - tl[1]) ** 2))
    print(widthB)
    maxWidth = max(int(widthA), int(widthB))
    minWidth = min(int(widthA), int(widthB))

    heightA = np.sqrt(((tr[0] - br[0]) ** 2) + ((tr[1] - br[1]) ** 2))
    print(heightA)
    heightB = np.sqrt(((tl[0] - bl[0]) ** 2) + ((tl[1] - bl[1]) ** 2))
    print(heightB)
    maxHeight = max(int(heightA), int(heightB))
    minHeight = min(int(heightA), int(heightB))
    print();print()


    cropped = img[minWidth : maxWidth, minHeight : maxHeight]
    return cropped

def group_points_to_rectangles(points, distance_threshold=10):
    rectangles = []
    points = points.tolist()
    while len(points) >= 4:
        found_rectangle = False
        for combination in itertools.combinations(points, 4):
            if is_rectangle(combination, distance_threshold):
                rectangles.append(combination)
                for point in combination:
                    points.remove(point)
                found_rectangle = True
                break
        if not found_rectangle:
            break
    return rectangles

def is_rectangle(points, threshold):
    rect = order_points(np.array(points))
    (tl, tr, br, bl) = rect
    d1 = np.linalg.norm(tr - tl)
    d2 = np.linalg.norm(br - bl)
    d3 = np.linalg.norm(tr - br)
    d4 = np.linalg.norm(tl - bl)
    return abs(d1 - d2) > threshold and abs(d3 - d4) > threshold

d_rho = 1
d_theta = np.pi / 180
n = 20  # Increase the number of lines to detect
Hough, lines = my_hough_transform(binary_image, d_rho, d_theta, n)

# Find intersections of lines
intersections = find_intersections(lines)

# Group intersections into rectangles
rectangles = group_points_to_rectangles(intersections, distance_threshold=10)

# Plot original image with detected lines and intersections
plt.figure(figsize=(12, 6))
plt.subplot(1, 2, 1)
plt.imshow(img, cmap='gray')
plt.title('Detected Edges using Hough Transform')

# Plot detected lines
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

plt.imshow(img, cmap='gray')
plt.scatter(points_x, points_y, color='red', s=0.01)

# Plot intersections
for intersection in intersections:
    plt.plot(intersection[0], intersection[1], 'bo')  # blue circle
plt.show()

# Plot cropped images for each rectangle
plt.subplot(1, 2, 2)
for i, rect_points in enumerate(rectangles):
    rect_points = np.array(rect_points, dtype="float32")
    cropped_image = four_point_transform(img, rect_points)
    plt.subplot(2, len(rectangles), i + 1)
    plt.imshow(cropped_image, cmap='gray')
    plt.title(f'Cropped Image {i+1}')
    
plt.show()
