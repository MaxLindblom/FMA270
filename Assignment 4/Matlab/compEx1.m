clear all
close all
load('compEx1data.mat');
im1=imread('house1.jpg');
im2=imread('house2.jpg');

X=pflat(X);

meanX=mean(X,2);                            %Construct means and standard deviations
Xtilde=(X-repmat(meanX,[1 size(X,2)]));
M=Xtilde(1:3,:)*Xtilde(1:3,:)';             %Construct M matrix
[V,D]=eig(M);
d=diag(D);
[m,i]=min(d);                               %Get smallest eigenvalue
t=V(:,i);                                   
d=-(t(1)*meanX(1)+t(2)*meanX(2)+t(3)*meanX(3)); %Calculate d-value for the plane
sol=[t(1);t(2);t(3);d];                      %Construct plane
sol=sol./norm(sol(1:3));
eRMS=sqrt(sum((sol'*X).^2)/size(X,2))       %Calculate RMS

bestPlane=sol;
bestRMS=eRMS;
CS=[];
bestInliers=abs(bestPlane'*X)<=0.1;

for i=1:5                                   %5 RANSAC iterations (although only 3 are necessary)
    randind=randperm(size(X,2),3);
    plane=null(X(:,randind)');              %Construct plane from 3 random points
    plane=plane./norm(plane(1:3));
    RMS=sqrt(sum((plane'*X).^2)/size(X,2)); 
    inliers=abs(plane'*X)<=0.1;
    if size(X(:,inliers),2)>size(X(:,bestInliers),2)
        bestPlane=plane;
        bestInliers=inliers;
        CS=X(:,bestInliers);
        bestRMS=RMS;
    end
end
bestRMS
CS_size=size(CS,2)
CSflat=pflat(CS);
hist(abs(bestPlane'*X),100);               %Plot consensus set histogram


meanCS=mean(CS,2);                          %Same as beginning of the exercise, but now with consensus set
CStilde=(CS-repmat(meanCS,[1 size(CS,2)]));
M=CStilde(1:3,:)*CStilde(1:3,:)';
[V,D]=eig(M);
d=diag(D);
[m,i]=min(d);
t=V(:,i);
d=-(t(1)*meanCS(1)+t(2)*meanCS(2)+t(3)*meanCS(3));
sol=[t(1);t(2);t(3);d];
sol=sol./norm(sol(1:3));
CSflat2=pflat(CS);
RMSfinal=sqrt(sum((sol'*CSflat2).^2)/size(CSflat2,2))

figure(2)
hist(abs(sol'*X),100);

figure(3)                                   %Plot images and projections
subplot(1,2,1)
axis equal
hold on
imagesc(im1);
x1_proj=pflat(P{1}*CS);
plot(x1_proj(1,:),x1_proj(2,:),'*');

subplot(1,2,2)
x2_proj=pflat(P{2}*CS);
axis equal
hold on
imagesc(im2);
plot(x2_proj(1,:),x2_proj(2,:),'*');

P1n=inv(K)*P{1};                            %Normalize cameras
P2n=inv(K)*P{2};

Pi=bestPlane./bestPlane(4,1);
U=CS;

Hn=[P2n(1:3,1:3)-P2n(1:3,4)*Pi(1:3)'];        %Compute homography

H=K*Hn*inv(K)

figure(3)                                   %Plot sample points
subplot(1,2,1)
plot(x(1,:),x(2,:),'*')

subplot(1,2,2)                              %Plot sample points transformed with H
Htran=pflat(H*x);
plot(Htran(1,:),Htran(2,:),'*')

