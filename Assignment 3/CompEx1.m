clear all
load('compEx1data.mat');
im1=imread('kronan1.JPG');
im2=imread('kronan2.JPG');

mean1=mean(x{1}(1:2,:),2);          %Calculate means and standard deviations
mean2=mean(x{2}(1:2,:),2);
std1=std(x{1}(1:2,:),0,2);
std2=std(x{2}(1:2,:),0,2);
N1=[1/std1(1) 0 (1/-std1(1))*mean1(1);0 1/std1(2) (1/-std1(2))*mean1(2);0 0 1];     %Calculate N-matrices
N2=[1/std2(1) 0 (1/-std2(1))*mean2(1);0 1/std2(2) (1/-std2(2))*mean2(2);0 0 1];
x1n=N1*x{1};
x2n=N2*x{2};

n=size(x{1}(1,:));

for i=1:n(2)                        %Form M matrix
    xx=x2n(:,i)*x1n(:,i)';
    M(i,:)=xx(:)';
end

[U,S,V]=svd(M);                     %SVD of M matrix

v=V(:,end);                         %Form F estimation
Fn=reshape(v,[3,3]);


[U,S,V]=svd(Fn);
S(3,3)=0;
F=U*S*V';                           %Declare final F matrix

F=N2'*F*N1;                         %Normalize F matrix
save('Fmat.mat');
plot(diag(x2n'*Fn*x1n));            

l=F*x{1};                           %Calculate epipolar lines
l=l./sqrt(repmat(l(1,:).^2 + l(2,:).^2,[3 1]));

figure(2)                           %Plot image and epipolar lines
imagesc(im2)
hold on
axis equal
p=randperm(n(2),20);
for i=1:20
    plot(x{2}(1,p(i)),x{2}(2,p(i)),'*')
    rital(l(:,p(i)),'-');
end

figure(3)                           %Plot histogram
hist(abs(sum(l.*x{2})),100);

F=F./F(3,3)


