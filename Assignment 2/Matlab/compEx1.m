clear all
close all

load('compEx1data.mat');
plot3(X(1,:),X(2,:),X(3,:),'.','Markersize',2); %Plot datapoints and cameras
hold on
plotcams(P);
axis equal

img1_data=pflat(x{1});                          %Calculate visible points in first image
visible=isfinite(img1_data(1,:));
img1=imread(imfiles{1});
P1=P{1};

xproj1=pflat(P1*(X));                       
figure(2)                                       %And plot over the image
hold on
axis equal
imagesc(img1);
plot(x{1}(1,visible),x{1}(2,visible),'*');
plot(xproj1(1,:),xproj1(2,:),'.');              %As well as projected points

T1=[1 0 0 0; 0 4 0 0; 0 0 1 0; 0.1 0.1 0 1];
T2=[1 0 0 0; 0 1 0 0; 0 0 1 0; 1/16 1/16 0 1];

P1_prime=P;                                     %Calculate P1_prime
for i = 1:length(P1_prime);
    P1_prime{i}=P{i}*inv(T1);
end


P2_prime=P;                                     %Calculate P2_prime
for i = 1:length(P2_prime);
    P2_prime{i}=P{i}*inv(T2);
end

X1_prime=pflat(T1*X);                             %As well as X1_prime and x2_prime
X2_prime=pflat(T2*X);

figure(3)                                       %Plot transformed points
axis equal
hold on
plot3(X1_prime(1,:),X1_prime(2,:),X1_prime(3,:),'.','Markersize',2);
plotcams(P1_prime);

figure(4)
axis equal
hold on
plot3(X2_prime(1,:),X2_prime(2,:),X2_prime(3,:),'.','Markersize',2);
plotcams(P2_prime);

figure(5)                                       %Plot new projected points
axis equal
hold on
xproj1_prime=pflat(P1_prime{1}*X1_prime);
imagesc(img1);
plot(x{1}(1,visible),x{1}(2,visible),'*');
plot(xproj1_prime(1,:),xproj1_prime(2,:),'.');
