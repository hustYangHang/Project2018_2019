clear all;clc;
data = importdata('D:\722Phone\P_10.txt');
% diff_time = data(data(:,1)==1,5);
% plot(diff_time);
dist = data(data(:,1)==3,2);
dist_rssi = data(data(:,1)==3,3);
dist_pdr = data(data(:,1)==3,4);
figure(1)
plot(dist,'r');
hold on;
plot(dist_rssi,'g');
hold on;
plot(dist_pdr,'b');
% p_predict = data(data(:,1)==1,2);
% p_update = data(data(:,1)==2,2);
% K = data(data(:,1)==2,4);
% figure(2)
% plot(p_predict,'r');
% hold on;
% plot(p_update,'g');
% figure(3)
% plot(K,'r');


% fingure_print_data = importdata('D:\722Phone\fingerprint_phone_0901_1.txt');
% ap_1 = fingure_print_data(:,1);
% ap_2 = fingure_print_data(:,2);
% plot(ap_1);
% hold on
% plot(ap_2);