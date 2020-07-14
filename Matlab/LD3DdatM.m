function G = LD3DdatM(n,f,wLD)

% Generates the data matrix from the function evaluations and the weights
% Copyright (C) Peter Dencker and Wolfgang Erb 01.07.2016
%-------------------------------------------------------------------------
% INPUT:
% n = [n1,n2,n3]  : parameters of Lissajous curve
% f               : function values at LD points
% wLD             : weights at LD points

% Output:
% C               : (n1+1)x(n2+1)x(n3+1) data matrix

% Generation of Data Matrix
[M2,M1,M3] = meshgrid(0:n(2),0:n(1),0:n(3));
findM = find((mod(M1+M2+1,2)).*(mod(M1+M3+1,2)).*(mod(M3+M2+1,2)));

G = zeros((n(1)+1)*(n(2)+1)*(n(3)+1),1);
G(findM) = f.*wLD;
G = reshape(G,size(M1));

return