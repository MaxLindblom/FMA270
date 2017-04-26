F=[0 1 1;1 0 0;0 1 1];
P1=[1 0 0 0;0 1 0 0;0 0 1 0];
e2=null(transpose(F));
e2x=[0 1/sqrt(2) 0;-1/sqrt(2) 0 -1/sqrt(2);0 1/sqrt(2) 0];
P2=[e2x*F e2]
x1=[1;2;7];
x2=[7;2;1];
l1=P2*[x1;1]
l2=P2*[x2;1]
transpose(l1)*F*x1
transpose(l2)*F*x2
C2=null(P2)