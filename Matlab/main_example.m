% Test examples for polynomial interpolation on the node points LD
% of three dimensional degenerate Lissajous curves
% Copyright (C) Peter Dencker and Wolfgang Erb 01.07.2016

clear all
close all

% Parameter of Lissajous curve, [n1,n2,n3] should be relatively prime
n = [7,6,5];

% Test parameters
range = [-1,1,-1,1,-1,1];  %Range in which interpolation takes place
nofun = 1;                 %Number of test function

%Plotting parameters
vistype = 1;       %Form of visualization [1-2]
N1 = 41;           %Resolution for first image
N2 = 7;            %Resolution for second image (number of balls)
mpar  = 50;        %Parameter for visualization 1 (size of balls)
mpar2 = 50;        %Parameter for visualization 2 (size of balls)

% Create grids for plots
[x1, y1, z1] = meshgrid(linspace(range(1),range(2),N1),linspace(range(3),range(4),N1),linspace(range(5),range(6),N1));
[x2, y2, z2] = meshgrid(linspace(range(1),range(2),N2),linspace(range(3),range(4),N2),linspace(range(5),range(6),N2));
xlin1 = reshape(x1,1,N1 ^ 3);   xlin2 = reshape(x2,1,N2 ^ 3);             
ylin1 = reshape(y1,1,N1 ^ 3);   ylin2 = reshape(y2,1,N2 ^ 3); 
zlin1 = reshape(z1,1,N1 ^ 3);   zlin2 = reshape(z2,1,N2 ^ 3);
       
% Compute Lissajous-Chebyshev node points LD^n and the respective weights
[xLD,yLD,zLD,wLD] = LD3Dpts(n,range);

% Read the functions from the test set
flin1 = testfun3D(xlin1,ylin1,zlin1,nofun);
flin2 = testfun3D(xlin2,ylin2,zlin2,nofun);

fLD = testfun3D(xLD,yLD,zLD,nofun);

% Compute data matrix
tic; G = LD3DdatM(n,fLD,wLD);

% Compute coefficient matrix
C = LD3Dcfsfft(n,G); time_coeff = toc;


% Compute interpolation polynomial at grid and Lissajous points
tic; Sflin1 = LD3Deval(C,n,xlin1,ylin1,zlin1); time_eval = toc;
Sflin2 = LD3Deval(C,n,xlin2,ylin2,zlin2);
SfLD   = LD3Deval(C,n,xLD,yLD,zLD);

Sf1 = reshape(Sflin1,N1,N1,N1);
Sf2 = reshape(Sflin2,N2,N2,N2);

maxerror = norm(Sflin1-flin1,inf);
maxerrorLD = norm(SfLD-fLD,inf);

noLD = (1+n(1))*(1+n(2))*(1+n(3))/4;

if (maxerrorLD > 1e-12)
    fprintf('Error: Interpolation not successful. Reconsider the choice of [n1,n2,n3]!\n');
else
    fprintf('Interpolation successful!');
    if (maxerror < 1e-12)
        fprintf(' The test function was reproduced exactly.\n');
    else
        fprintf(' \n');
    end
end

fprintf('Maximal error for approximation     : %23.18f \n',maxerror);
fprintf('Maximal error at LD points          : %23.18f \n\n',maxerrorLD);

fprintf('Time to compute %6d coefficients : %13.8f seconds\n',noLD,time_coeff);
fprintf('Time to compute %6d evaluations  : %13.8f seconds\n',N1^3,time_eval);
 
% Plots of the interpolating polynomial

switch vistype
    case 1
        figure(1),clf,
        xslice = (range(2)+range(1))/2; 
        yslice = (range(4)+range(3))/2; 
        zslice = (range(6)+range(5))/2;
        slice(x1,y1,z1,Sf1,xslice,yslice,zslice);
        colormap(hot);
        colorbar;
        
        figure(2),clf,
        scatter3(xlin2,ylin2,zlin2,mpar*Sflin2,Sflin2,'fill');
        colormap(hot);
        colorbar
    case 2
        figure(1),clf,
        xslice = []; 
        yslice = []; 
        zslice = [-1,-0.5,0, 0.5,1];
        slice(x1,y1,z1,Sf1,xslice,yslice,zslice);
        colormap(hot);
        colorbar;
        
        figure(2),clf,
        scatter3(xlin2,ylin2,zlin2,mpar2*Sflin2,Sflin2,'fill');
        colormap(hot);
        colorbar
end





