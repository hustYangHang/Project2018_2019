clear all
close all
clc
n_count = 0;
y_count = 0;
csi_no_tx1 = importdata('csi_tx1_0816_no_2.txt');
csi_yes_tx1 = importdata('csi_tx1_0816_yes_125grid.txt');
csi_no_tx2 = importdata('csi_tx2_0816_no_2.txt');
csi_yes_tx2 = importdata('csi_tx2_0816_yes_125grid.txt');

[num1,~] = size(csi_no_tx1);
[num2,~] = size(csi_yes_tx1);
num = min(num1, num2);
num_packet = num/3;
for i = 1 : num_packet
%     csi_test = csi_temp(3*(i-1)+1:3*(i-1)+3,:);
    pearson_n_tx1(i,:) = corr(csi_no_tx1(3*(i-1)+1,:)',csi_no_tx1(3*(i-1)+2,:)','type','pearson');
    pearson_n_tx1(i,:) = pearson_n_tx1(i,:) + corr(csi_no_tx1(3*(i-1)+2,:)',csi_no_tx1(3*(i-1)+3,:)','type','Pearson');
    pearson_n_tx1(i,:) = pearson_n_tx1(i,:) + corr(csi_no_tx1(3*(i-1)+1,:)',csi_no_tx1(3*(i-1)+3,:)','type','Pearson');
    pearson_y_tx1(i,:) = corr(csi_yes_tx1(3*(i-1)+1,:)',csi_yes_tx1(3*(i-1)+2,:)','type','Pearson');
    pearson_y_tx1(i,:) = pearson_y_tx1(i,:) + corr(csi_yes_tx1(3*(i-1)+2,:)',csi_yes_tx1(3*(i-1)+3,:)','type','Pearson');
    pearson_y_tx1(i,:) = pearson_y_tx1(i,:) + corr(csi_yes_tx1(3*(i-1)+3,:)',csi_yes_tx1(3*(i-1)+1,:)','type','Pearson');  
    
    pearson_n_tx2(i,:) = corr(csi_no_tx2(3*(i-1)+1,:)',csi_no_tx2(3*(i-1)+2,:)','type','pearson');
    pearson_n_tx2(i,:) = pearson_n_tx2(i,:) + corr(csi_no_tx2(3*(i-1)+2,:)',csi_no_tx2(3*(i-1)+3,:)','type','Pearson');
    pearson_n_tx2(i,:) = pearson_n_tx2(i,:) + corr(csi_no_tx2(3*(i-1)+1,:)',csi_no_tx2(3*(i-1)+3,:)','type','Pearson');
    pearson_y_tx2(i,:) = corr(csi_yes_tx2(3*(i-1)+1,:)',csi_yes_tx2(3*(i-1)+2,:)','type','Pearson');
    pearson_y_tx2(i,:) = pearson_y_tx2(i,:) + corr(csi_yes_tx2(3*(i-1)+2,:)',csi_yes_tx2(3*(i-1)+3,:)','type','Pearson');
    pearson_y_tx2(i,:) = pearson_y_tx2(i,:) + corr(csi_yes_tx2(3*(i-1)+3,:)',csi_yes_tx2(3*(i-1)+1,:)','type','Pearson'); 
end
packet_length = 60;
% tabulate(floor(std_csi_testy))
for i = 1 : floor(num_packet/packet_length)
    std_n_tx1(i,:) = mad(pearson_n_tx1(packet_length*(i - 1) + 1:packet_length*i),1);
    std_y_tx1(i,:) = mad(pearson_y_tx1(packet_length*(i - 1) + 1:packet_length*i),1);
    std_n_tx2(i,:) = mad(pearson_n_tx2(packet_length*(i - 1) + 1:packet_length*i),1);
    std_y_tx2(i,:) = mad(pearson_y_tx2(packet_length*(i - 1) + 1:packet_length*i),1);
end
max_mad_n = max(std_n_tx1, std_n_tx2);
min_mad_n = min(std_n_tx1, std_n_tx2);
max_mad_y = max(std_y_tx1, std_y_tx2);
min_mad_y = min(std_y_tx1, std_y_tx2);
bound_n = min(std_n_tx2, (max_mad_n + min_mad_n)/2.0);
bound_y = min(std_y_tx2, (max_mad_y + min_mad_y)/2.0);
%bound_n = (max_mad_n + min_mad_n)/2.0;
%bound_y = (max_mad_y + min_mad_y)/2.0;
hold on
plot(bound_n,'r')
plot(bound_y,'b')

%accuracy = n_count/num_packet
