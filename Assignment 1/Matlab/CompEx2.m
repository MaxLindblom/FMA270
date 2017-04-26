load('compEx2.mat');            %Read and scan all information
img = imread('compEx2.JPG');
imagesc(img);       
colormap gray;
hold on
plot(p1(1,:),p1(2,:),'*')       %Plot all the image pairs
plot(p2(1,:),p2(2,:),'*')
plot(p3(1,:),p3(2,:),'*')
l1 = null(transpose(p1));       %Calculate the null space (lines) for all image pairs
l2 = null(transpose(p2));
l3 = null(transpose(p3));
rital(l1,'-');                  %And plot them with rital
rital(l2,'-');
rital(l3,'-');
eq_sys= [transpose(l2);transpose(l3)];  %Set up an equation system for lines l2 and l3
inter = pflat(null(eq_sys));    %Caluclate and plot the intersection point (again, null space)
plot(inter(1,:),inter(2,:),'*')
d = abs((l1(1,:)*inter(1)) + (l1(2,:)*inter(2)) + l1(3,:))/sqrt(l1(1,:).^2 + l1(2,:).^2);
disp('Distance between l1 and intersection point:');    
disp(d);                        %Display the distance, computed using the given formula