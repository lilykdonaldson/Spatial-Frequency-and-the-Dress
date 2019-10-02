import cv2
import numpy as np
import matplotlib.pyplot as plt
from PIL import Image

img = cv2.imread('images/thedress.jpeg')
plt.subplot(121),plt.imshow(img)
plt.show()
plt.clf()

R = img[:,:,0]
G = img[:,:,1]
B = img[:,:,2]
# R_gaussian = cv2.GaussianBlur(R,(3,3),cv2.BORDER_DEFAULT)
# G_gaussian = cv2.GaussianBlur(G,(3,3),cv2.BORDER_DEFAULT)
# B_gaussian = cv2.GaussianBlur(B,(3,3),cv2.BORDER_DEFAULT)
# RGB_gaussian = (R_gaussian+ G_gaussian+ B_gaussian)
RGB_gaussian = np.zeros(img.shape)
RGB_gaussian[:,:,0]=R 
RGB_gaussian[:,:,1]=G
RGB_gaussian[:,:,2]=B
img2 = Image.fromarray(RGB_gaussian, 'RGB')
print(RGB_gaussian[0][0])
print(img[0][0])
print(RGB_gaussian[5][5])
print(type(img[5][5][0]))
print(type(RGB_gaussian[5][5][0]))


plt.subplot(121),plt.imshow(img2)
plt.show()