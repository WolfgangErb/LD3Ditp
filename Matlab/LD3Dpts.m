function [xLD, yLD, zLD, wLD] = LD3Dpts(n,range)

% Computes LD points with parameter n for a given range
% Copyright (C) Peter Dencker and Wolfgang Erb 01.07.2016
%-------------------------------------------------------------------------------
% INPUT:
% n=[n1,n2,n3]   : parameters of the Lissajous curve
% range          : range of the x,y and z-coordinates
%
% OUTPUT:  
% xLD,yLD,zLD    : coordinates of the nodes of the Lissajous curve
% wLD            : weight function for the nodes

% Determination of points
zx = cos(linspace(0,1,n(1)+1)*pi);
zy = cos(linspace(0,1,n(2)+1)*pi);
zz = cos(linspace(0,1,n(3)+1)*pi);

[LD2,LD1,LD3] = meshgrid(zy,zx,zz);
  
% Determination of weight function
W = ones(n(1)+1,n(2)+1,n(3)+1)/n(1)/n(2)/n(3)*4;
W(1,:,:) = W(1,:,:)/2;
W(n(1)+1,:) = W(n(1)+1,:)/2;
W(:,1,:) = W(:,1,:)/2;
W(:,n(2)+1,:) = W(:,n(2)+1,:)/2;
W(:,:,1) = W(:,:,1)/2;
W(:,:,n(3)+1) = W(:,:,n(3)+1)/2; 
 
% Selection of used points
[M2,M1,M3] = meshgrid(0:n(2),0:n(1),0:n(3));
findM = find((mod(M1+M2+1,2)).*(mod(M1+M3+1,2)).*(mod(M3+M2+1,2)));

xLD = LD1(findM)';
yLD = LD2(findM)';
zLD = LD3(findM)';
wLD = W(findM)';

% normalize range
[xLD, yLD, zLD] = norm_range3D(xLD,yLD,zLD,range);

return


