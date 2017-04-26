clear all
close all
load('compEx1data.mat')
load('Fmat.mat')
im1=imread('kronan1.JPG');
im2=imread('kronan2.JPG');

x1n=N1*x{1};                            %Normalize points
x2n=N2*x{2};

n=size(x{1}(1,:));

%F=[0 0 -0.0005;0 0 0.0024;0.0006 -0.0023 -0.0881]; %Fundamental matrix as calculated in CompEx1
P1=[1 0 0 0;0 1 0 0;0 0 1 0];
det(F)
e2=null(F')
e2x= [0 -e2(3) e2(2);e2(3) 0 -e2(1);-e2(2) e2(1) 0];
P2=[e2x*F e2];                          %Calculate P2 from F

P1n=N1*P1;
P2n=N2*P2;
zerocol=zeros(3,1);

x1=x1n(1:3,1);                          
x2=x2n(1:3,1);
M=[P1n -x1 zerocol;P2n zerocol -x2];
[U,S,V]=svd(M);
v=V(:,end);
X=v(1:4,1);
for i=1:n(2)                            %Triangulation of points
    x1=x1n(1:3,i);
    x2=x2n(1:3,i);
    M=[P1n -x1 zerocol;P2n zerocol -x2];
    [U,S,V]=svd(M);
    v=V(:,end);
    X=[X v(1:4,1)];
end

x1_proj=pflat(P1*X);                    %Plot image 1
imagesc(im1)
hold on
axis equal
plot(x{1}(1,:),x{1}(2,:),'*')
plot(x1_proj(1,:),x1_proj(2,:),'.')

figure(2)                               %Plot image 2
x2_proj=pflat(P2*X);
imagesc(im2)
hold on
axis equal
plot(x{2}(1,:),x{2}(2,:),'*')
plot(x2_proj(1,:),x2_proj(2,:),'.')

X=pflat(X);
figure(3)                               %Plot 3d points
axis equal
plot3(X(1,:),X(2,:),X(3,:),'.','Markersize',2);

P1
P2

save('Pmatrices.mat')