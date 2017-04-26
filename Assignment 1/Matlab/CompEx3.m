load('compEx3.mat');
H1 = [sqrt(3) -1 1; 1 sqrt(3) 1; 0 0 2];    %Define all H matrices
H2 = [1 -1 1; 1 1 0; 0 0 1];
H3 = [1 1 0; 0 2 0; 0 0 1];
H4 = [sqrt(3) -1 1; 1 sqrt(3) 1; 0.25 0.5 2];

startpoints1 = [startpoints; ones(1,42)];   %Append ones to start/endpoint matrices
endpoints1 = [endpoints; ones(1,42)];

trans_start1 = pflat(H1*startpoints1);      %Transform start points
trans_start2 = pflat(H2*startpoints1);
trans_start3 = pflat(H3*startpoints1);
trans_start4 = pflat(H4*startpoints1);

trans_end1 = pflat(H1*endpoints1);          %And end points
trans_end2 = pflat(H2*endpoints1);
trans_end3 = pflat(H3*endpoints1);
trans_end4 = pflat(H4*endpoints1);

plot([trans_start1(1,:); trans_end1(1,:)], ...  %Plot everything
[trans_start1(2,:); trans_end1(2,:)],'b-');
axis equal;

figure(2);
plot([trans_start2(1,:); trans_end2(1,:)], ...
[trans_start2(2,:); trans_end2(2,:)],'b-');
axis equal;

figure(3);
plot([trans_start3(1,:); trans_end3(1,:)], ...
[trans_start3(2,:); trans_end3(2,:)],'b-');
axis equal;

figure(4);
plot([trans_start4(1,:); trans_end4(1,:)], ...
[trans_start4(2,:); trans_end4(2,:)],'b-');
axis equal;