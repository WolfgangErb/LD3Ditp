""" 
Script to plot the Lissajous-Chebyshev node points LC and 
the corresponding spectral index sets
(C) P. Dencker and W. Erb 01.10.2016

This python implementation was written by W. Erb (01.10.2018)
"""

import LD3Ditp as LC
#from math import gcd
import numpy as np
import matplotlib as mpl
#from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt

#Set the parameters (please change here)
LCrange = [-1, 1, -1, 1,-1,1]     #Range of area covered by Lissajous curves
m       = [7,5,4]                 #Frequency parameters (must be relatively prime)

#Generate 3D-LD points and prepare plot for LD points
xLC, yLC, zLC, wLC = LC.LD3Dpts(m,LCrange)
    
t = np.linspace(0, 2*np.pi, 1000)
x = np.cos(m[1]*m[2]*t)
y = np.cos(m[0]*m[2]*t)
z = np.cos(m[0]*m[1]*t)

x, y, z = LC.norm_range(x,y,z,np.array([-1, 1, -1, 1,-1,1]),LCrange)
 
#Prepare plot for spectral index sets
 
R = LC.LD3Dmask(m)
NoLC = np.count_nonzero(R)
gamma = np.zeros((NoLC,3))
ii = 0

for i in range(m[0]+1):
    for j in range(m[1]+1):
        for k in range(m[2]+1):
            if (R[i,j,k] > 0):
                gamma[ii,:] = [i,j,k]
                ii = ii+1
            
#Plot
mpl.rcParams['legend.fontsize'] = 10

fig = plt.figure(figsize=(12, 6))

ax1 = fig.add_subplot(121,projection='3d')
ax1.plot(x,y,z,color=(183/255,207/255,246/255),linewidth=2,zorder=1,label='3D Lissajous curve')
  
ax1.scatter(xLC, yLC, zLC, marker='o', edgecolor='k', color = (65/255,105/255,225/255), s = 100, zorder = 2,label='LD nodes')
ax1.set_xlabel('$x_1$')
ax1.set_ylabel('$x_2$')
ax1.set_zlabel('$x_3$')
ax1.view_init(10, 75)
ax1.legend()

ax2 = fig.add_subplot(122,projection='3d')
ax2.scatter(gamma[:,0], gamma[:,1], gamma[:,2], marker='o', edgecolor='k', color = (181/255,22/255,33/255), s = 80, label = 'Spectral indices')
ax2.set_xlabel('$\gamma_1$')
ax2.set_ylabel('$\gamma_2$')
ax2.set_zlabel('$\gamma_3$')
ax2.view_init(10, 60)
ax2.legend()

fig.tight_layout()  
plt.show()