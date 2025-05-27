import numpy as np
from global_hist_eq import get_equalization_transform_of_img


def calculate_eq_transformations_of_regions(img_array, region_len_h, region_len_w):
    
    
    dim = img_array.shape # get the dimensions of the image array 
    rows, cols = dim

    heightPart = cols // region_len_h # integer division to get the number of vertical regions
    widthPart =  rows // region_len_w # integer division to get the number of horizontal regions
    regionHeight = region_len_h
    regionWidth = region_len_w
    regions = []

    for i in range(heightPart):
        for j in range(widthPart):
            wStart = i * region_len_w
            hStart = j * region_len_h
            regions.append((wStart, hStart)) # creating the tuple that is going to be the key for our dictionary
            # I am firstly iterating over the horizontal axis because Python numpy arrays and Images have the rows and
            # columns switched
            
    
    

    myDictionary ={} # initializing the Dictionary


    for i in range(len(regions)):
        A = img_array[regions[i][0] : regionWidth, regions[i][1] : regionHeight] # getting a region from the whole image
        regionHeight += region_len_h # this is to increment the step for the vertical axis 
        # first I create the row regions and then I move on to the next column
        
        if(regions[i][1] == region_len_h * (heightPart - 1)):
            regionWidth += region_len_w
            regionHeight = region_len_h
            
        myDictionary[(regions[i][1], regions[i][0])] = np.array(get_equalization_transform_of_img(A), dtype = np.uint8)
        # adding the transformation of every region of the original Image to the dictionary 
        # with it's corresponding key
        
    return myDictionary


def perform_adaptive_hist_equalization(img_array, region_len_h, region_len_w):
    
            
    Dict = calculate_eq_transformations_of_regions(img_array, region_len_h, region_len_w)
    # receiving the dictionary created from the previous function
    
    dim = img_array.shape
    
    rows, cols = dim # rows = 360, cols = 480
    regions = list(Dict.keys()) # transforming the dictionary keys in to a list of tuples
    # which we are going to use later to create a dictionary 
    regionHeight = region_len_h
    regionWidth = region_len_w
    heightPart = cols // region_len_h
    widthPart =  rows // region_len_w
    centers = {} # initializing the dictionary of the centers of each region
    k = 0
    
    for i in range(heightPart): # I am iterating as many times as the numbers of region of row
        for j in range(widthPart):
            centers[regions[k]] = ((regionWidth - 1) / 2, (regionHeight - 1) / 2)
            # Here I create a dictionary which has as keys a tuple corresponding to the region which center we want to find
            # the value of each region is the center of each region which is found by dividing each coordinate in half
            regionHeight += 2*region_len_h
            k += 1
        regionHeight = region_len_h
        regionWidth += 2*region_len_w
        
    newDict = {}
    regionHeight = region_len_h
    regionWidth = region_len_w
           
    for key, value in centers.items():
        newDict[value] = Dict[key] # create a dictionary where every center is matched with the corresponding transformation
        
    centers = list(centers.values()) # create a list of tuples with the centers of each region
     
    arr1 = [] # creating an empty list in which I am going to store the centers of the smaller dimension of the Image
    arr2 = [] # creating an empty list in which I am going to store the centers of the greater dimension of the Image
     
    for i in range(len(centers)):
        arr1.append(centers[i][0]) # Here I just the centers of each region to the above empty initialized lists
        arr2.append(centers[i][1])
         
         
    arr1 = sorted(list(set(arr1))) # Since the number of the centers is going to appear multiple times 
    # I convert them to set's and then back to lists to get only one instance of each center and then I sort
    # the list because it's going to be useful for the next step where I identify which pixels belong to the regions 
    # that are going to interpolated and which are not
    arr2 = sorted(list(set(arr2)))

    
    points = [] # I create an empty list of points which will represent which points have been interpolated

    
    for i in range(rows):
        for j in range(cols):
            # I take every pixel of the picture and try to identify in which region it belongs
            for k in range(len(arr1) - 1):
                if i > arr1[k] and i < arr1[k+1]:
                    # with this if statement I check if it belongs between two centers in the width dimension
                    for m in range(len(arr2) - 1):
                        # if it does belong between two centers in the width dimension then I check if it belongs between
                        # any centers in the height dimension
                        if j > arr2[m] and j < arr2[m+1]:
                            # if it does indeed belong then I perform the interpolation
                            T1 = (arr1[k], arr2[m]) # the transformation of the upper left corner 
                            T2 = (arr1[k], arr2[m+1]) # the transformation of the upper right corner
                            T3 = (arr1[k+1], arr2[m]) # the transformation of the lower left corner
                            T4 = (arr1[k+1], arr2[m+1]) # the transformation of the lower right corner
                            a = (i - arr1[k]) / (arr1[k+1] - arr1[k])
                            b = (j - arr2[m]) / (arr2[m+1] - arr2[m])
                            pixel = img_array[i][j]
                            img_array[i][j] = (1-a) * (1-b) * newDict[T1][pixel] + (1-a)*b*newDict[T2][pixel] + a*(1-b)*newDict[T3][pixel] + a*b*newDict[T4][pixel]
                            points.append((i, j)) # after I perform the interpolation I add the pixel to the points list
    
    for i in range(rows):
        for j in range(cols):
            # I try every of the picture and try to identify in which region it belongs
            if (i,j) in points:
                continue # if the pixel belongs in the interpolated pixels then I don't do anything and I continue the loop
            else:
                # if the picture doesn't belong in the interior interpolated pixels then it is an exterior point
                # and for that reason I have to define in which region it belongs so I can apply the proper transformation
                res1 = [result - i for result in arr1] # I create a list where every element represents the distance of the
                # pixel from each center in the width dimension
                res2 = [result - j for result in arr2] # I create a list where every element represents the distance of the 
                # pixel from each center in the height dimension
                res1 = min(enumerate(res1), key=lambda x: abs(x[1]-0))
                # the above line of code is finding the index and the value in the res1 list which is closer to zero
                # where the lamda function takes the key pair (index, value) and returns absolute distance from zero 
                res1 = res1[0] # with this way I get the proper index to define in which region my pixel belongs
                res2 = min(enumerate(res2), key=lambda x: abs(x[1]-0))
                res2 = res2[0]
                img_array[i][j] = newDict[(arr1[res1], arr2[res2])][img_array[i][j]]
                # after that I apply the proper transformation to every exterior pixel

    return img_array
