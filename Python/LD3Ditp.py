""" 
Main Python module for bivariate polynomial interpolation 
on general Lissajous-Chebyshev node points LC 
(C) P. Dencker and W. Erb 01.10.2016

This python module was written by W. Erb (01.10.2018)
"""

import numpy as np

def norm_range(x,y,z,raold,ranew):      
          x = (x - raold[0]) / (raold[1] - raold[0])
          y = (y - raold[2]) / (raold[3] - raold[2])
          z = (z - raold[4]) / (raold[5] - raold[4])
          x = (x*(ranew[1]-ranew[0])) + ranew[0]
          y = (y*(ranew[3]-ranew[2])) + ranew[2]
          z = (z*(ranew[5]-ranew[4])) + ranew[4]
          return x, y, z
      
def T(N,x):
          y=np.cos(np.outer(np.arange(0, N+1, 1),np.arccos(x)))
          return y

def LD3Dpts(m,LCrange):      
          zx =  np.cos(np.linspace(0,1,m[0]+1)*np.pi)
          zy =  np.cos(np.linspace(0,1,m[1]+1)*np.pi)
          zz =  np.cos(np.linspace(0,1,m[2]+1)*np.pi)
          LC1, LC0, LC2 = np.meshgrid(zy,zx,zz)
          W = np.ones((m[0]+1,m[1]+1,m[2]+1))/m[0]/m[1]/m[2]*4
          W[0,:,:] = W[0,:,:]/2
          W[m[0],:,:] = W[m[0],:,:]/2
          W[:,0,:] = W[:,0,:]/2
          W[:,m[1],:] = W[:,m[1],:]/2
          W[:,:,0] = W[:,:,0]/2
          W[:,:,m[2]] = W[:,:,m[2]]/2
          M1, M0, M2 = np.meshgrid(np.arange(0,m[1]+1,1),np.arange(0,m[0]+1,1),np.arange(0,m[2]+1,1)) 
          findM = np.where(np.mod(M0+M1+1,2)*np.mod(M0+M2+1,2)*np.mod(M1+M2+1,2)==1)
          xLC = LC0[findM]
          yLC = LC1[findM]
          zLC = LC2[findM]
          wLC = W[findM] 
          xLC, yLC, zLC = norm_range(xLC,yLC,zLC,[-1,1,-1,1,-1,1],LCrange)
          return xLC, yLC, zLC, wLC
      
def LD3Dmask(m):
          M1, M0, M2 = np.meshgrid(np.arange(0,m[1]+1,1),np.arange(0,m[0]+1,1),np.arange(0,m[2]+1,1)) 
          R1 = 1.0*(M0*m[1]+M1*m[0]<m[0]*m[1])
          R2 = 1.0*(M0*m[2]+M2*m[0]<m[0]*m[2])
          R3 = 1.0*(M1*m[2]+M2*m[1]<m[1]*m[2])
          R = R1*R2*R3;
          R[0,0,m[2]] = 1/2;
          return R
            
def LD3DdatM(m,f,wLC):      
          M1, M0, M2 = np.meshgrid(np.arange(0,m[1]+1,1),np.arange(0,m[0]+1,1),np.arange(0,m[2]+1,1)) 
          findM = np.where(np.mod(M0+M1+1,2)*np.mod(M0+M2+1,2)*np.mod(M1+M2+1,2)==1)
          G = np.zeros((m[0]+1,m[1]+1,m[2]+1))
          G[findM] = f*wLC
          G = np.reshape(G,M1.shape)
          return G
      
def LD3Dcfsfft(m,G):
          Gh = np.fft.fft(G,2*m[0],0).real  
          Gh = Gh[0:m[0]+1,:,:]           
          Ghh = np.fft.fft(Gh,2*m[1],1).real      
          Ghh = Ghh[:,0:m[1]+1,:]
          Ghhh = np.fft.fft(Ghh,2*m[2],2).real      
          Ghhh = Ghhh[:,:,0:m[2]+1]
          
          M1, M0, M2 = np.meshgrid(np.arange(0,m[1]+1,1),np.arange(0,m[0]+1,1),np.arange(0,m[2]+1,1))  
          Alpha = (2-1.0*(M0<1))*(2-1.0*(M1<1))*(2-1.0*(M2<1))
          R = LD3Dmask(m)
          C = Ghhh*Alpha*R
          return C
      
def LD3Deval(C, m, x, y, z, LCrange):
          x,y,z = norm_range(x,y,z,LCrange,[-1, 1, -1, 1, -1, 1])
          Tx = T(m[0], x)
          Ty = T(m[1], y)
          Tz = T(m[2], z)
          Sf = np.zeros(x.shape);

          for i in range(m[0]+1):
              for j in range(m[1]+1):
                  for k in range(m[2]+1):
                      Sf = Sf + C[i,j,k]*Tx[i,:]*Ty[j,:]*Tz[k,:]
          # for more efficiency you can also use Chebyshev grid and FFT here            
          return Sf
      
def testfun3D(x,y,z,n):
          if n == 1:
                  f = 1 + np.exp(-((x+0.3)**2+(y+0.15)**2+z**2))
          elif n == 2:
                  K = [1,1,2];
                  f = np.cos(K[0]*np.arccos(x))*np.cos(K[1]*np.arccos(y))*np.cos(K[2]*np.arccos(z))
          elif n == 3:
                  f = 1/(1+2*np.sqrt((x+0.3)**2+(y+0.15)**2+z**2))
          return f