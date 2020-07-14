function Sf = LD3Deval(C,n,x,y,z)

% Computes the interpolation polynomial at points (x,y,z) 
% Copyright (C) Peter Dencker and Wolfgang Erb 01.07.2016
%-------------------------------------------------------------------------------
% INPUT:
% n            : parameters of the Lissajous curve
% C            : coefficient matrix of the interpolation polynomial
% (x,y,z)      : evaluation point
%
% OUTPUT:
% Sf           : evaluated polynomial at point (x,y,z)


% Normalize range
[x,y,z] = norm_range3D(x,y,z,[-1 1 -1 1 -1 1]);

% Compute basis polynomials
Tx = T(n(1), x);
Ty = T(n(2), y);
Tz = T(n(3), z);

Sf = zeros(size(x));

for i = 0:n(1)
    for j = 0:n(2)
        for k = 0:n(3)
            Sf = Sf + C(i+1,j+1,k+1)*Tx(i+1,:).*Ty(j+1,:).*Tz(k+1,:);
        end
    end
end
