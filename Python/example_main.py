""" 
Main test example for polynomial interpolation on the node points LD
of 3D degenerate Lissajous curves

(C) P. Dencker and W. Erb 01.7.2016

This python implementation was written by W. Erb (01.07.2020)
"""

import LD3Ditp as LC
#from mpl_toolkits import mplot3d
import numpy as np
from numpy import linalg as LA
import matplotlib.pyplot as plt

#Set the parameters
LCrange = [-1, 1, -1, 1, -1, 1]   #Range of Lissajous curves
m       = [15,14,13]              #Frequency parameters (have to be relatively prime)

nofun   = 1                       #Number of test function
Nd      = 15                      #Discretization for plot

# Extract LD points
xLC, yLC, zLC, wLC = LC.LD3Dpts(m,LCrange)
NoLC = wLC.size

# Extract function values at LD points
fLC = LC.testfun3D(xLC,yLC,zLC,nofun)
# Generate data matrix at LD points
G = LC.LD3DdatM(m,fLC,wLC)
# Calculate the expansion coefficients
C = LC.LD3Dcfsfft(m,G)

#Evaluate the interpolation polynomial at new grid
[x, y , z] = np.meshgrid(np.linspace(LCrange[0],LCrange[1],Nd),np.linspace(LCrange[2],LCrange[3],Nd),np.linspace(LCrange[4],LCrange[5],Nd))   
Sflin = LC.LD3Deval(C,m,x.flatten(),y.flatten(),z.flatten(),LCrange)   
SfLC  = LC.LD3Deval(C,m,xLC,yLC,zLC,LCrange)      
Sf    = np.reshape(Sflin,(Nd,Nd,Nd))  

# Calculate the errors
maxerror   = LA.norm(Sflin-LC.testfun3D(x.flatten(),y.flatten(),z.flatten(),nofun),np.inf);
maxerrorLC = LA.norm(SfLC-fLC,np.inf);

# Display the results and plot the interpolant
if (maxerrorLC > 1e-12):
    print('Error: Interpolation not successful!')
else:
    print('Interpolation successful!')
    if (maxerror < 1e-12):
        print('The test function was reproduced exactly.\n')
    else:
        print('')

print('Number of interpolation points   : %23d' % NoLC)
print('Maximal error for approximation  : %23.18f' % maxerror)
print('Maximal error at LC points       : %23.18f \n' % maxerrorLC)
 
fig = plt.figure(figsize=(10, 8))
ax = plt.axes(projection='3d')
ax.scatter(x,y,z, c = Sflin, cmap='hot', s = 20, zorder = 1)  #edgecolor='none'
ax.set_title('3D Lissajous interpolant')
ax.set_xlabel('$x_1$')
ax.set_ylabel('$x_2$')
ax.set_zlabel('$x_3$')
ax.view_init(15, 230)

fig.tight_layout()  
plt.show()