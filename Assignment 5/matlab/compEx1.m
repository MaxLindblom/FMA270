clear all
close all
im1=load('kronan1.JPG');
im2=load('kronan2.JPG');
load('assignment5data.mat');    %Load data from assignment 3

%Set initial cameras and points
P={P1,P2};
U=X;
u={K\x1,K\x2};

%Set lambda and no. of iterations here
lambda=1;
iterations=65;
%Set lambda and no. of iterations here

%Run first iteration with original cameras and points
[err,res]=ComputeReprojectionError(P,U,u);
[r,J]=LinearizeReprojErr(P,U,u);
C=J'*J+lambda*speye(size(J,2));
c=J'*r;
deltav=-C\c;
[Pnew,Unew]=update_solution(deltav,P,U);

histogram(res);                 %Plot residual histogram before LM method

%Set up reprojection error plot
figure(2)
hold on
plot(1,err,'*');
errv=err;

%Perform iterations
for i=2:iterations
    [err,res]=ComputeReprojectionError(Pnew,Unew,u);
    [r,J]=LinearizeReprojErr(Pnew,Unew,u);
    C=J'*J+lambda*speye(size(J,2));
    c=J'*r;
    deltav=-C\c;
    [Pnew,Unew]=update_solution(deltav,Pnew,Unew);
    
    errv=[errv err];
    plot(i,err,'*');
end

plot(1:iterations,errv,'-');    %Plot lines between error points

%Plot residual histogram after LM method
figure(3)
histogram(res);
