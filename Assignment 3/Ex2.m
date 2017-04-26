clear all
P1=[1 0 0 0;0 1 0 0;0 0 1 0];
P2=[1 1 1 2;0 2 0 2;0 0 1 0];
A=P2([1 2 3],[1 2 3])
C1=pflat(null(P1))
C2=pflat(null(P2))
e1=P1*C2
e2=P2*C1
e2x=[0 0 2;0 0 -2;-2 2 0];
F=e2x*A
detF=det(F)
e2tF=transpose(e2)*F
Fe1=F*e1