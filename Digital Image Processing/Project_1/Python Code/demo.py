from PIL import Image
import numpy as np
import matplotlib.pyplot as plt
from global_hist_eq import perform_global_hist_equalization
from global_hist_eq import get_equalization_transform_of_img
from adaptive_hist_eq import calculate_eq_transformations_of_regions
from adaptive_hist_eq import perform_adaptive_hist_equalization




filename =  "C:/Users/chris/OneDrive/Υπολογιστής/8o ΕΞΑΜΗΝΟ/ΨΗΦΙΑΚΗ ΕΠΕΞΕΡΓΑΣΙΑ ΕΙΚΟΝΑΣ/input_img.png"

img = Image.open(filename) # loads the image from the destination
#img.show()

bw_img = img.convert("L") # create the gray scale image
bw_img.show()


img_array = np.array(bw_img) # get the array of the gray scale image

# --------------------------- HISTOGRAM OF THE ORIGINAL GRAYSCALE IMAGE --------------------------- 

appearances = list(element for sublist in img_array for element in sublist) # concatanate the 2D matrix into a single list
L = 256
cnt  = [0] * L # list to count the appearances of all the elements in the image
prob = [0] * L # find the probability of each value prob(x_i)

for i in appearances:
    cnt[i] += 1

mySum = sum(cnt)

plt.bar(range(0,256), cnt, color = 'blue')
plt.grid(visible='on')
plt.title("Histogram Of The Original Image")
plt.xlabel("X Values")
plt.ylabel("X Occurrences")
plt.show()




# --------------------------- HISTOGRAM OF THE EQUALIZED GRAYSCALE IMAGE --------------------------- 

equalized_hist = get_equalization_transform_of_img(img_array)
plt.plot(equalized_hist)
plt.title("Transformation of the Image")
plt.grid(visible = 'on')
plt.xlabel('Values of the Original Image')
plt.ylabel('Values of the Transformation of the Equalized Image')
plt.show()


equalized_img = perform_global_hist_equalization(img_array)
equalized_img = Image.fromarray(equalized_img, 'L')
equalized_img.show()
equalized_array = np.array(equalized_img)
res = list(set(i for j in equalized_array for i in j))  # find the different values of the gray scale image

appearances = list(element for sublist in equalized_array for element in sublist)  # concatanate the 2D matrix into a single list

cnt = [0]*256  # list to count the appearances of all the elements in the image


for i in appearances:
    cnt[i] += 1

myHist = list(filter(lambda num: num != 0, cnt))
# with filter(lamda) I create a list with all the values that are different from zero in the cnt list


plt.bar(range(len(cnt)), cnt, color = 'red')
plt.grid(visible='on')
plt.title("Histogram Of The Equalised Image")
plt.xlabel("Y Values")
plt.ylabel("Y Occurrences")
plt.show()





# --------------------------- HISTOGRAM OF THE EQUALIZED GRAYSCALE IMAGE REGIONS --------------------------- 

region_len_h = 64
region_len_w = 48
Dict = calculate_eq_transformations_of_regions(img_array, region_len_h, region_len_w)
newDict = {}
regionHeight = 64
regionWidth = 48

rows, cols = img_array.shape # rows, cols


regions = []
heightPart = cols // regionHeight
widthPart = rows // regionWidth



for i in range(heightPart):
    for j in range(widthPart):
        hStart = i * regionWidth 
        wStart = j * regionHeight 
        regions.append((hStart, wStart)) 
    
for i in range(len(regions)):
    B = img_array[regions[i][0] : regionWidth, regions[i][1] : regionHeight]
    regionHeight += region_len_h
    
    if (regions[i][1] == (heightPart - 1) * region_len_h):
        regionWidth += region_len_w
        regionHeight = region_len_h
        
    newDict[(regions[i][1], regions[i][0])] = np.array(Dict[(regions[i][1], regions[i][0])][B], dtype = np.uint8)

smallArray = [value for value in newDict.values()] # create a list of 49 arrays with dimensions 48x64
rows = [np.concatenate(smallArray[i*7:(i+1)*7], axis = 1) for i in range(widthPart)] # create a rows list of 7 arrays per element
image = np.concatenate(rows, axis=0) # concatenate all the arrays to create the final image
image = Image.fromarray(image, 'L')
image_array = np.array(image)
image.show()

appearances = list(element for sublist in image_array for element in sublist)  # concatanate the 2D matrix into a single list

cnt = [0]*256  # list to count the appearances of all the elements in the image


for i in appearances:
    cnt[i] += 1

myHist = list(filter(lambda num: num != 0, cnt))


plt.bar(range(len(myHist)), myHist, color = 'green')
plt.grid(visible='on')
plt.title("Histogram Of The Equalised Image Regions")
plt.xlabel("X Values")
plt.ylabel("X Occurrences")
plt.show()




# --------------------------- HISTOGRAM OF THE INTERPOLATED GRAYSCALE IMAGE --------------------------- 

img_array = img_array[:widthPart*region_len_w, :heightPart*region_len_h]
# reduce the size of the image to perform the adaptive histogram equalization

adaptiveImage_array = perform_adaptive_hist_equalization(img_array, region_len_h, region_len_w)
adaptiveImage = Image.fromarray(adaptiveImage_array, 'L')
adaptiveImage.show()
appearances = list(element for sublist in adaptiveImage_array for element in sublist)  # concatanate the 2D matrix into a single list

cnt = [0]*256  # list to count the appearances of all the elements in the image


for i in appearances:
    cnt[i] += 1

myHist = list(filter(lambda num: num != 0, cnt))


plt.bar(range(len(myHist)), myHist, color = 'orange')
plt.grid(visible='on')
plt.title("Histogram Of The Interpolated Image")
plt.xlabel("Y Values")
plt.ylabel("Y Occurrences")
plt.show()














