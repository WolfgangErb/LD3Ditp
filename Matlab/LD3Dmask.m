function R = LD3Dmask(n)

% Computes the mask for the coefficients of the interpolation polynomial
% Copyright (C) Peter Dencker and Wolfgang Erb 01.07.2016

[M2,M1,M3] = meshgrid(0:n(2),0:n(1),0:n(3));
R3 = double(M1/n(1) + M2/n(2) < 1);
R2 = double(M1/n(1) + M3/n(3) < 1);
R1 = double(M2/n(2) + M3/n(3) < 1);

R = R1.*R2.*R3; 

R(1,1,n(3)+1) = 1/2;

end




