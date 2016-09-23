function [ x, y, z ] = norm_range3D( x,y,z,range)
 
% normalize old range to [0,1]x[0,1]x[0,1]
x = (x - min(x)) / (max(x) - min(x));
y = (y - min(y)) / (max(y) - min(y));
z = (z - min(z)) / (max(z) - min(z));

% normalize to new range
x = (x*(range(2)-range(1))) + range(1);
y = (y*(range(4)-range(3))) + range(3);
z = (z*(range(6)-range(5))) + range(5);

end

