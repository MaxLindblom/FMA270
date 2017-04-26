load('compEx4.mat');
img1 = imread('compEx4im1.JPG');
img2 = imread('compEx4im2.JPG');

imagesc(img1)               %Plot initial images
colormap gray
hold on
figure(2)
imagesc(img2)
colormap gray
hold on

figure(3)                   %Plot 3d representation of point model
Uh=pflat(U);
plot3(Uh(1,:),Uh(2,:),Uh(3,:),'.','Markersize',2);
hold on

P1_center=pflat(null(P1))  %Calculate and plot null spaces (camera centers)
P2_center=pflat(null(P2))
plot3(P1_center(1),P1_center(2),P1_center(3),'*');
plot3(P2_center(1),P2_center(2),P2_center(3),'*');

P1_vec = P1(3,1:3);         %Calculate and plot viewing directions
quiver3(P1_center(1),P1_center(2),P1_center(3),P1_vec(1),P1_vec(2),P1_vec(3),1)
P2_vec = P2(3,1:3);
quiver3(P2_center(1),P2_center(2),P2_center(3),P2_vec(1),P2_vec(2),P2_vec(3),1)

U1 = pflat(P1*U);           %Calculate camera projections of P1 and P2..
U2 = pflat(P2*U);
figure(1)                   %..and plot them over exisiting images
plot(U1(1,:),U1(2,:),'.','Markersize',2);
figure(2)
plot(U2(1,:),U2(2,:),'.','Markersize',2);