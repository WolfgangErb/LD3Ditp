function C = LD3Dcfsfft(n,G)

% Computes the coefficient matrix of the interpolating polynomial
% Copyright (C) Peter Dencker and Wolfgang Erb 01.07.2016
%----------------------------------------------------------------------
% INPUT:    
% n = [n1,n2,n3]  : parameters of Lissajous curve
% G               : (n1+1)x(n2+1)x(n3+1) data matrix

% Output: 
% C               : (n1+1)x(n2+1)x(n3+1) coefficient matrix


% Execute Chebyshev transform along single dimensions
Gh = real(fft(G,2*n(1),1));   
Gh = Gh(1:n(1)+1,:,:);           

Ghh = real(fft(Gh,2*n(2),2));       
Ghh = Ghh(:,1:n(2)+1,:);

Ghhh = real(fft(Ghh,2*n(3),3));       
Ghhh = Ghhh(:,:,1:n(3)+1);

% Chebyshev normalization factors
[M2,M1,M3] = meshgrid(0:n(2),0:n(1),0:n(3));
Alpha = (2-(M1<1)).*(2-(M2<1)).*(2-(M3<1));

% Mask for coefficients
Mask = LD3Dmask(n);
    
% Final coefficient matrix
C = Ghhh.*Alpha.*Mask;
