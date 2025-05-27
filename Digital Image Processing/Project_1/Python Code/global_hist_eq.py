import numpy as np
import matplotlib.pyplot as plt

def get_equalization_transform_of_img(img_array):
    appearances = list(element for sublist in img_array for element in sublist) # concatanate the 2D matrix into a single list
    L = 256
    cnt  = [0] * L # list to count the appearances of all the elements in the image
    prob = [0] * L # find the probability of each value prob(x_i)

    for i in appearances:
        cnt[i] += 1 # increment the counter for each appearance of an element
    
    mySum = sum(cnt) # create the denominator to calculate the cummulative pdf

    prob = list(i/mySum for i in cnt) # calculation of the cummulative pdf 
    # creating a list with the probability of an element appearing in the image

    v = [0] * L
    y = [0] * L
    v[0] = prob[0]

    for i in range(1, len(prob)):
        v[i] = v[i-1] + prob[i] # creating the vk vector 

    v = np.array(v)
    y = np.round((v-v[0])/(1-v[0])*(L-1)) # creating the transformation that is going to be applied to the image

    equalization_transform = np.array(y, dtype=np.uint8) # changing its type to the desired return type as mentioned in the project

    return equalization_transform


def perform_global_hist_equalization(img_array):
    
    T = get_equalization_transform_of_img(img_array) # get the global transformation of the image
    s = T[img_array] # apply the transformation to the img_array data s = T[r]
    # array slicing, numpy performs the mapping of the transformation
    equalized_img = np.array(s, dtype=np.uint8)
    return equalized_img

