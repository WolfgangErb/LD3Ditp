% Plot a degenerate 3D-Lissajous curve, its node points LD
% and the corresponding index set
% Copyright (C) Peter Dencker and Wolfgang Erb 01.07.2016

clear all
close all

% Parameters of the 3D degenerate Lissajous curve
% (should be relatively prime)
n = [7,6,5];

% Plotting parameter
scale = 80;           % size of the LD-points in plots

% shorten notation
n1 = n(1); n2 = n(2); n3 = n(3); 

% Generate Lissajous curve
t = 0:0.001:pi;
x = cos(n2*n3*t); y = cos(n1*n3*t); z = cos(n1*n2*t);

% Mask for the index set
R = LD3Dmask([n1,n2,n3]);
[M2,M1,M3] = meshgrid(0:n2,0:n1,0:n3);
R = R.*(2.^(double(M1>0) + double(M2>0) + double(M3 > 0)));

% Total number of elements in LD
NoLD = (1+n1)*(1+n2)*(1+n3)/4;

% Number of elements in different faces of LD 
LN = [2,n1+n2+n3-3, ((n1-1)*(n2-1)+(n2-1)*(n3-1)+(n1-1)*(n3-1))/2, (n1-1)*(n2-1)*(n3-1)/4];

% Initialize
LD1 = zeros(LN(1),3); LD2 = zeros(LN(2),3); LD3 = zeros(LN(3),3); LD4 = zeros(LN(4),3);
gamma1 = zeros(LN(1),3); gamma2 = zeros(LN(2),3); gamma3 = zeros(LN(3),3); gamma4 = zeros(LN(4),3);
M1 = scale*ones(LN(1),1); M2 = scale*ones(LN(2),1); M3 = scale*ones(LN(3),1); M4 = scale*ones(LN(4),1);
i1 = 1; i2 = 1; i3 = 1; i4 = 1;

A = -[1/n1,1/n2,0;1/n1,0,1/n3; 0,1/n2,1/n3; -1, 0, 0; 0, -1,0; 0,0,-1];
b = -[1;1;1;0;0;0];

% Compute elements of LD
for i = 0:n1
    for j = 0:n2
        for k = 0:n3
            if (R(i+1,j+1,k+1) == 1)
                LD1(i1,1) = cos(n2*n3*pi*(i/n1 + j/n2 + k/n3));
                LD1(i1,2) = cos(n1*n3*pi*(i/n1 + j/n2 + k/n3));
                LD1(i1,3) = cos(n2*n1*pi*(i/n1 + j/n2 + k/n3));
                gamma1(i1,:) = [i,j,k];
                i1 = i1+1;
            elseif (R(i+1,j+1,k+1) == 2)
                LD2(i2,1) = cos(n2*n3*pi*(i/n1 + j/n2 + k/n3));
                LD2(i2,2) = cos(n1*n3*pi*(i/n1 + j/n2 + k/n3));
                LD2(i2,3) = cos(n2*n1*pi*(i/n1 + j/n2 + k/n3));
                gamma2(i2,:) = [i,j,k];
                i2 = i2+1;
            elseif (R(i+1,j+1,k+1) == 4)
                LD3(i3,1) = cos(n2*n3*pi*(i/n1 + j/n2 + k/n3));
                LD3(i3,2) = cos(n1*n3*pi*(i/n1 + j/n2 + k/n3));
                LD3(i3,3) = cos(n1*n2*pi*(i/n1 + j/n2 + k/n3));
                gamma3(i3,:) = [i,j,k];
                i3 = i3+1;
            elseif (R(i+1,j+1,k+1) == 8)
                LD4(i4,1) = cos(n2*n3*pi*(i/n1 + j/n2 + k/n3));
                LD4(i4,2) = cos(n1*n3*pi*(i/n1 + j/n2 + k/n3));
                LD4(i4,3) = cos(n2*n1*pi*(i/n1 + j/n2 + k/n3));
                gamma4(i4,:) = [i,j,k];
                i4 = i4+1;
            end
        end
    end
end
% Number of elements in the different sets
fprintf('Points of LD in [-1,1]^3          (total number) : %10d \n',NoLD);
fprintf('Points of LD in the interior of [-1,1]^3   (red) : %10d \n',LN(4));
fprintf('Points of LD on the faces of [-1,1]^3    (green) : %10d \n',LN(3));
fprintf('Points of LD on the edges of [-1,1]^3   (yellow) : %10d \n',LN(2));
fprintf('Points of LD on the vertices of [-1,1]^3 (white) : %10d \n',LN(1));

% Plot the curve and the points in LD
%         black : the degenerate 3D-Lissajous curve in [-1,1]^3
%         red   : Points of LD in the interior of [-1,1]^3
%         green : Points of LD on the faces of [-1,1]^3
%         yellow: Points of LD on the edges of [-1,1]^3
%         white : Points of LD on the vertices of [-1,1]^3

figure(1), clf,
plot3(x,y,z,'k','LineWidth',2);
view([-50 20]);
grid on;
set(gca,'FontSize',14);
xlabel('x_1'); ylabel('x_2'); zlabel('x_3');
title('Lissajous curve $\ell^{(\underline{\mathbf{n}})}$ and $\mathbf{LD}^{(\underline{\mathbf{n}})}$ points', ...
'interpreter','latex','fontsize',16)
hold on
scatter3(LD1(:,1),LD1(:,2),LD1(:,3),M1,'fill','MarkerFaceColor','w','MarkerEdgeColor','k');
hold on
scatter3(LD2(:,1),LD2(:,2),LD2(:,3),M2,'fill','MarkerFaceColor',[236,218,136]/255,'MarkerEdgeColor','k');
hold on
scatter3(LD3(:,1),LD3(:,2),LD3(:,3),M3,'fill','MarkerFaceColor',[59,178,160]/255,'MarkerEdgeColor','k');
hold on
scatter3(LD4(:,1),LD4(:,2),LD4(:,3),M4,'fill','MarkerFaceColor',[181,22,33]/255,'MarkerEdgeColor','k');
hold off

% Plot the index set with the polygonal boundary for the LD-nodes

figure(2), clf,
plotregion(A,b,[],[],[0.9,0.9,0.9]);
view([124 20]);
set(gca,'FontSize',15);
xlabel('\gamma_1'); ylabel('\gamma_2'); zlabel('\gamma_3');
title('Index set $\Gamma^{(\underline{\mathbf{n}})}$ for interpolation on $\mathbf{LD}^{(\underline{\mathbf{n}})}$ points', ...
'interpreter','latex','fontsize',16)
hold on
scatter3(gamma1(:,1),gamma1(:,2),gamma1(:,3),M1,'fill','MarkerFaceColor','w','MarkerEdgeColor','k');
hold on
scatter3(gamma2(:,1),gamma2(:,2),gamma2(:,3),M2,'fill','MarkerFaceColor',[236,218,136]/255,'MarkerEdgeColor','k');
hold on
scatter3(gamma3(:,1),gamma3(:,2),gamma3(:,3),M3,'fill','MarkerFaceColor',[59,178,160]/255,'MarkerEdgeColor','k');
hold on
scatter3(gamma4(:,1),gamma4(:,2),gamma4(:,3),M4,'fill','MarkerFaceColor',[181,22,33]/255,'MarkerEdgeColor','k');
hold off

