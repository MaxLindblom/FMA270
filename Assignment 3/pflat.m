function [out_data]=pflat(data)
%PFLAT divides homogeneous coordinates by their last entry

last_coord = data(end,:);       %Extract the last coordinates

index = 1:length(data(1,:));
out_data = data;

for i = index                   %Iterate over all elements
    out_data(:,i)=data(:,i)./last_coord(i); %And divide by the last coordinate
end    

end
