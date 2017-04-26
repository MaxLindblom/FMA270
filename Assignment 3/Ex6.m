clear all
U=[1/sqrt(2) -1/sqrt(2) 0;1/sqrt(2) 1/sqrt(2) 0;0 0 1];
V=[1 0 0;0 0 -1;0 1 0];
disp('chec detUVT, should be 1')
det(U*V')
P1=[1 0 0 0;0 1 0 0;0 0 1 0];
E=U*diag([1 1 0])*V'
disp('check epipolar constraint, should be 0')
y1=[0;0;1];
y2=[1;1;1];
y2'*E*y1
u3=U(:,3);
W=[0 -1 0;1 0 0;0 0 1];
syms s;
Xs=[0;0;1;s]
P1*Xs
P21Xs=[U*W*V' u3]*Xs
P22Xs=[U*W*V' -u3]*Xs
P23Xs=[U*W'*V' u3]*Xs
P24Xs=[U*W'*V' -u3]*Xs

P21=[U*W*V' u3];
P22=[U*W*V' -u3];
P23=[U*W'*V' u3];
P24=[U*W'*V' -u3];

P=cell(1,4);

P{1}=P21;
P{2}=P22;
P{3}=P23;
P{4}=P24;
P{5}=P1;

%plot3(0,0,1,'*');
hold on
plotcams(P);