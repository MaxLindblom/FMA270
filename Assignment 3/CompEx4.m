clear all
close all
load('compEx1data.mat')
load('compEx3data.mat')
im2=imread('kronan2.JPG');

x1n=K\x{1};                    %Normalize image points
x2n=K\x{2};

n=size(x{1}(1,:));

for i=1:n(2)                        %Configure M matrix
    xx=x2n(:,i)*x1n(:,i)';
    M(i,:)=xx(:)';
end

[U,S,V]=svd(M);                     %Setup estimaton of E matrix
v=V(:,end);
Eapprox=reshape(v,[3,3]);

[U,S,V]=svd(Eapprox);               %Calculate exact E matrix
if det(U*V')>0
    E=U*diag([1 1 0])*V';
else
    V=-V;
    E=U*diag([1 1 0])*V';
end

W=[0 -1 0;1 0 0;0 0 1];
u3=U(:,3);

P1=[1 0 0 0;0 1 0 0;0 0 1 0];
P21=[U*W*V' u3];                    %Calculate P2 matrix

zerocol=zeros(3,1);

x1=x1n(1:3,1);
x2=x1n(1:3,1);
M=[P1 -x1 zerocol;P21 zerocol -x2];
[Ut,St,Vt]=svd(M);
v=Vt(:,end);
X1=v(1:4,1);
for i=1:n(2)                        %Triangulate to find 3D points
    x1=x1n(1:3,i);
    x2=x2n(1:3,i);
    M=[P1 -x1 zerocol;P21 zerocol -x2];
    [Ut,St,Vt]=svd(M);
    v=Vt(:,end);
    X1=[X1 v(1:4,1)];
end
X1=pflat(X1);
subplot(1,2,1)                      %Plot 3D points and cameras
plot3(X1(1,:),X1(2,:),X1(3,:),'.','Markersize',2);
hold on
P=cell(1,2);
P{1}=P1;
P{2}=P21;
plotcams(P);
subplot(1,2,2)                      %Plot image, image points and projected points
axis equal
P21n=K*P21;
imagesc(im2);
hold on
x21_proj=pflat(P21n*X1);
plot(x{2}(1,:),x{2}(2,:),'*')
plot(x21_proj(1,:),x21_proj(2,:),'.')

                                    %Repeat for all configurations of P2

P22=[U*W*V' -u3];

x1=x1n(1:3,1);
x2=x1n(1:3,1);
M=[P1 -x1 zerocol;P22 zerocol -x2];
[Ut,St,Vt]=svd(M);
v=Vt(:,end);
X2=v(1:4,1);
for i=1:n(2)
    x1=x1n(1:3,i);
    x2=x2n(1:3,i);
    M=[P1 -x1 zerocol;P22 zerocol -x2];
    [Ut,St,Vt]=svd(M);
    v=Vt(:,end);
    X2=[X2 v(1:4,1)];
end
X2=pflat(X2);
figure(2)
subplot(1,2,1)
plot3(X2(1,:),X2(2,:),X2(3,:),'.','Markersize',2);
hold on
P=cell(1,2);
P{1}=P1;
P{2}=P22;
plotcams(P);
subplot(1,2,2)
axis equal
P22n=K*P22;
imagesc(im2);
hold on
x22_proj=pflat(P22n*X2);
plot(x{2}(1,:),x{2}(2,:),'*')
plot(x22_proj(1,:),x22_proj(2,:),'.')

P23=[U*W'*V' u3];

x1=x1n(1:3,1);
x2=x1n(1:3,1);
M=[P1 -x1 zerocol;P23 zerocol -x2];
[Ut,St,Vt]=svd(M);
v=Vt(:,end);
X3=v(1:4,1);
for i=1:n(2)
    x1=x1n(1:3,i);
    x2=x2n(1:3,i);
    M=[P1 -x1 zerocol;P23 zerocol -x2];
    [Ut,St,Vt]=svd(M);
    v=Vt(:,end);
    X3=[X3 v(1:4,1)];
end
X3=pflat(X3);
figure(3)
subplot(1,2,1)
plot3(X3(1,:),X3(2,:),X3(3,:),'.','Markersize',2);
hold on
P=cell(1,2);
P{1}=P1;
P{2}=P23;
plotcams(P);
subplot(1,2,2)
axis equal
P23n=K*P23;
imagesc(im2);
hold on
x23_proj=pflat(P23n*X3);
plot(x{2}(1,:),x{2}(2,:),'*')
plot(x23_proj(1,:),x23_proj(2,:),'.')

P24=[U*W'*V' -u3];

x1=x1n(1:3,1);
x2=x1n(1:3,1);
M=[P1 -x1 zerocol;P24 zerocol -x2];
[Ut,St,Vt]=svd(M);
v=Vt(:,end);
X4=v(1:4,1);
for i=1:n(2)
    x1=x1n(1:3,i);
    x2=x2n(1:3,i);
    M=[P1 -x1 zerocol;P24 zerocol -x2];
    [Ut,St,Vt]=svd(M);
    v=Vt(:,end);
    X4=[X4 v(1:4,1)];
end
X4=pflat(X4);
figure(4)
subplot(1,2,1)
plot3(X4(1,:),X4(2,:),X4(3,:),'.','Markersize',2);
hold on
P=cell(1,2);
P{1}=P1;
P{2}=P24;
plotcams(P);
subplot(1,2,2)
axis equal
P24n=K*P24;
imagesc(im2);
hold on
x24_proj=pflat(P24n*X4);
plot(x{2}(1,:),x{2}(2,:),'*')
plot(x24_proj(1,:),x24_proj(2,:),'.')

P2=P22;
P2n=P22n;
X=X2;
x1=x{1};
x2=x{2};
save('assigment5data.mat','P1', 'P2', 'P2n', 'X', 'x1', 'x2', 'K');
