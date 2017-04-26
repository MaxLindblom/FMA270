clear all
close all
load('compEx3data.mat');
im1=imread('cube1.JPG');
im2=imread('cube2.JPG');

[f1,d1]=vl_sift(single(rgb2gray(im1)),'PeakThresh',1);      
[f2,d2]=vl_sift(single(rgb2gray(im2)),'PeakThresh',1);

[matches,scores]=vl_ubcmatch(d1,d2);

x1=[f1(1,matches(1,:));f1(2,matches(1,:))];         %SIFT point sets
x2=[f2(1,matches(2,:));f2(2,matches(2,:))];

P1=[10.8623 1.7555 -8.1730 157.2420;                %Cameras as calculated in computer exercise 3
    -2.1797 12.8709 -2.1427 183.2248;
    0.0039 0.0025 0.0025 0.1496];

P2=[11.8668 2.2747 -6.2144 140.5595;
    -2.3374 13.1582 -2.2128 178.9158;
    0.0032 0.0028 0.0033 0.1513];

K1=rq(P1(1:3,1:3));
K1=K1./K1(3,3)
K2=rq(P2(1:3,1:3));
K2=K2./K1(3,3);

zerocol=zeros(3,1);
n=size(x1);

x1(3,:)=1;
x2(3,:)=1;
x1i=x1(1:3,1);
x2i=x2(1:3,1);
M=[P1 -x1i zerocol;P2 zerocol -x2i];
[U,S,V]=svd(M);
v=V(:,end);
X=v(1:4,1);
for i=2:n(2)                            %Triangulation of points using SVD
    x1i=x1(1:3,i);
    x2i=x2(1:3,i);
    M=[P1 -x1i zerocol;P2 zerocol -x2i];
    [U,S,V]=svd(M);
    v=V(:,end);
    X=[X v(1:4,1)];
end
%X=X/X(4);

xproj1=pflat(P1*X);                     %Calculate projections
xproj2=pflat(P2*X);



subplot(2,2,1)                          %Plot images and projections, as well as SIFT sets
imagesc(im1);
hold on
axis equal
plot(xproj1(1,:),xproj1(2,:),'*')
plot(x1(1,:),x1(2,:),'.')

subplot(2,2,2)
imagesc(im2);
hold on
axis equal
plot(xproj2(1,:),xproj2(2,:),'*')
plot(x2(1,:),x2(2,:),'.')

                                      %Normalization left out as it does
                                      %not work properly
% x1n=inv(K1)*x1;
% x2n=inv(K2)*x2;
% x1i=x1n(1:3,1);
% x2i=x2n(1:3,1);
% M=[P1 -x1i zerocol;P2 zerocol -x2i];
% [U,S,V]=svd(M);
% v=V(:,end);
% X=v(1:4,1);
% for i=1:n(2)                           
%     x1i=x1n(1:3,i);
%     x2i=x2n(1:3,i);
%     M=[P1 -x1i zerocol;P2 zerocol -x2i];
%     [U,S,V]=svd(M);
%     v=V(:,end);
%     X=[X v(1:4,1)];
% end
% %X=X/X(4);
% 
% 
% 
% xproj1=pflat(K1*P1*X);
% xproj2=pflat(K2*P2*X);
% 
% subplot(2,2,3)
% hold on
% axis equal
% plot(xproj1(1,:),xproj1(2,:),'*')
% plot(x1(1,:),x1(2,:),'.')
% 
% subplot(2,2,4)
% hold on
% axis equal
% plot(xproj2(1,:),xproj2(2,:),'*')
% plot(x2(1,:),x2(2,:),'.')

good_points=(sqrt(sum((x1(1:2,:)-xproj1(1:2,:)).^2)) < 3 & ...
sqrt(sum((x2(1:2,:)-xproj2(1:2,:)).^2)) < 3);

X=pflat(X(:,good_points));

P=cell(1,2);                            %Plot 3D scene and cameras
P{1}=P1;
P{2}=P2;
figure(2)
hold on
plot3(X(1,:),X(2,:),X(3,:),'.')
plot3(Xmodel(1,:),Xmodel(2,:),Xmodel(3,:),'.')
plotcams(P);