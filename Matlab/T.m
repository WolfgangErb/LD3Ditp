function y = T(N,x)

% Auxiliary function to compute
% Chebyshev polynomials of first kind up to degree N.

y=cos((0:N)'*acos(x));
end