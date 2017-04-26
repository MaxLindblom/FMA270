load('compEx1data.mat');

P1_prime=P;
for i = 1:length(P1_prime);
    P1_prime{i}=P{i}*T1;
end

P2_prime=P;
for i = 1:length(P1_prime);
    P2_prime{i}=P{i}*T2;
end

K1=rq(P1_prime{1});
K1 = K1./K1(3,3)
K2=rq(P2_prime{1});
K2 = K2./K2(3,3)