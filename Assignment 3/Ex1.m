clear all
P2=[1 1 0 0; 0 2 0 2; 0 0 1 0];
A=[1 1 0; 0 2 0; 0 0 1];
e2=[0;2;0];
e2x=[0 -e2(3) e2(2);e2(3) 0 -e2(1);-e2(2) e2(1) 0]
F=e2x*A
x=[1;1;1];
x1=[1;0;1];
x2=[2;1;1];
x3=[2;2;1];
syms lambda;
epx=lambda*A*x+e2
epx=lambda*A*x1+e2
epx=lambda*A*x2+e2
epx=lambda*A*x3+e2
l=F*x
x1'*l
x2'*l
x3'*l