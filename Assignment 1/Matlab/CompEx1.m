load('compEx1.mat');

%Calculate and plot the result of pflat for 2D
two_dim = pflat(x2D); 
plot(two_dim(1,:),two_dim(2,:),'.');
axis equal

figure(2)
%Calculate and plot the result of pflat for 3D
three_dim = pflat(x3D);
plot3(three_dim(1,:),three_dim(2,:),three_dim(3,:),'.')
axis equal