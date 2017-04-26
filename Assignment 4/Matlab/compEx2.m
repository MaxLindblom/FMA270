clear all
close all

A=imread('a.jpg');                          %Read images
B=imread('b.jpg');

imagesc(A);
figure(2)
imagesc(B);

[fA,dA]=vl_sift(single(rgb2gray(A)));
[fB,dB]=vl_sift(single(rgb2gray(B)));
matches=vl_ubcmatch(dA,dB);                 %Compute matches
xA=fA(1:2,matches(1,:));
xB=fB(1:2,matches(2,:));


n=size(matches)                             %Print size of matches, and feature sets
SIFTfeaturesA=size(fA)
SIFTfeaturesB=size(fB)

bestH=eye(3);
xA1=xA;
xB1=xB;
xA1(3,:)=1;
xB1(3,:)=1;
bestInliers=0;
for i=1:50                                  %Perform RANSAC iterations
    randind=randperm(size(matches,2),4);    
    vi=xA1(1:3,randind);                          
    ui=xB1(1:3,randind);
    M=zeros(12,13);                         
    for k=1:4                               %Calculate M matrix for 4 points
        vk=vi(1:3,k);
        uk=ui(1:3,k);
        M((3*k)-2,1:3)=vk';
        M((3*k)-1,4:6)=vk';
        M((3*k),7:9)=vk';
        M((3*k)-2:(3*k),9+k)=-uk;
    end
    [U,S,V]=svd(M);                         
    v=V(:,end);                             %Extract last column of V as solution
    H=reshape(v(1:9,1),[3 3]);              %Reshape first 9 values to get H
    H=H';                             
    HfA=pflat(H*xA1);
    inliers=0;
    for k=1:size(matches,2)
        if norm(abs(HfA(:,k)-xB1(:,k)))<=5
            inliers=inliers+1;              %Count inliers
        end
    end
    if inliers>=bestInliers                 %Best solution depends on amount of inliers
        bestH=H;
        bestInliers=inliers;
    end
end
bestInliers

tform=maketform('projective', bestH');      %Calculate panorama image
transfbounds=findbounds(tform,[1 1; size(A ,2) size(A,1)]);
xdata=[min([transfbounds(:,1); 1]) max([transfbounds(:,1); size(B,2)])];
ydata=[min([transfbounds(:,2); 1]) max([transfbounds(:,2); size(B,1)])];
[newA]=imtransform(A,tform,'xdata',xdata,'ydata',ydata);
tform2=maketform('projective',eye(3));
[newB]=imtransform(B,tform2,'xdata',xdata,'ydata',ydata);
newAB=newB;
newAB(newB<newA)=newA(newB<newA);

figure(3)                                   %Plot the panorama
imagesc(newAB);