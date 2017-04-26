clear all
close all
load('compEx3data.mat');
im1=imread('cube1.JPG');
im2=imread('cube2.JPG');

mean1=mean(x{1}(1:2,:),2);              %Calculate means and standard deviations
mean2=mean(x{2}(1:2,:),2);
std1=std(x{1}(1:2,:),0,2);
std2=std(x{2}(1:2,:),0,2);
N1=[1/std1(1) 0 1/-std1(1)*mean1(1);0 1/std1(2) 1/-std1(2)*mean1(2);0 0 1];     %Calculate normalization matrices
N2=[1/std2(1) 0 1/-std2(1)*mean1(1);0 1/std2(2) 1/-std2(2)*mean1(2);0 0 1];
norm1=N1*x{1};
norm2=N2*x{2};                          %Normalize points
plot(norm1(1,:),norm1(2,:),'*')

n=size(x{1});
M=zeros(3*n(2),12+n(2));
for i=1:n(2)                            %Calculate M matrix
    Xi=Xmodel(:,i);
    Xi(4,1)=1;
    xi=norm1(:,i);
    M(3*i-2,1:4)=Xi';
    M(3*i-1,5:8)=Xi';
    M(3*i,9:12)=Xi';
    M(3*i-2:3*i,12+i)=-xi;
end
[U,S,V]=svd(M);                         %And its SVD
sol=V(:,end);
if sol(end,end)<0
    sol=-sol;
end
P1n=reshape(sol(1:12),[4 3])';          %Normalized P1

M=zeros(3*n(2),12+n(2));
for i=1:n(2)
    Xi=Xmodel(:,i);
    Xi(4,1)=1;
    xi=norm2(:,i);
    M(3*i-2,1:4)=Xi';
    M(3*i-1,5:8)=Xi';
    M(3*i,9:12)=Xi';
    M(3*i-2:3*i,12+i)=-xi;
end
[U,S,V]=svd(M);
sol=V(:,end);
if sol(end,end)<0
    sol=-sol;
end
P2n=reshape(sol(1:12),[4 3])';          %Normalized P2

P1=inv(N1)*P1n;                         %Calculate actual P1 and P2
P2=inv(N2)*P2n; 

X=Xmodel;
X(4,:)=1;
x1_proj=pflat(P1*X);                    %Calculate projections
x2_proj=pflat(P2*X);
P=cell(1,2);
P{1}=P1;
P{2}=P2;

figure(2)                               %Plot both figures and projected points
subplot(2,2,1)
imagesc(im1)
hold on
axis equal
plot(x1_proj(1,:),x1_proj(2,:),'*')
plot(x{1}(1,:),x{1}(2,:),'*')
subplot(2,2,3)                          %Also plot cameras and 3D model
plot3(X(1,:),X(2,:),X(3,:),'*')
hold on
plotcams(P);

subplot(2,2,2)
imagesc(im2)
hold on
axis equal
plot(x2_proj(1,:),x2_proj(2,:),'*')
plot(x{2}(1,:),x{2}(2,:),'*')

K1=rq(P1(1:3,1:3));                     %Calculate K matrices using rq.m
K1 = K1./K1(3,3)
K2=rq(P2(1:3,1:3));
K2 = K2./K2(3,3)

P1
P2