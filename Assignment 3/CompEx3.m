clear all
load('compEx1data.mat')
load('compEx3data.mat')
im2=imread('kronan2.JPG');

x1=x{1};
x2=x{2};
x1n=K\x1;                    %Normalize the points
x2n=K\x2;

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

det(E)
plot(diag(x2n'*E*x1n));             %Computes and plots all the epipolar constraints ( should be roughly 0)

F=inv(K)'*E*inv(K);                           %Calculate F matrix
l=F*x{1};                            %Calculate epipolar lines
l=l./sqrt(repmat(l(1,:).^2 + l(2,:).^2,[3 1]));

figure(2)                           %Plot image
imagesc(im2)
hold on
axis equal
p=randperm(n(2),20);
for i=1:20
    plot(x{2}(1,p(i)),x{2}(2,p(i)),'*')
    rital(l(:,p(i)),'-');
end

figure(3)
hist(abs(sum(l.*x{2})),100);        %Plot histogram

E=E./E(3,3)