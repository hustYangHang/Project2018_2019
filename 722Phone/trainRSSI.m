clear all
close all
clc


count = 0
j = 0
rssi_temp = importdata('traindata08135m.txt');
train_data =rssi_temp(:,1:2);
train_label = rssi_temp(:,3);
for i = 1:10
    for j = 1:70
        if train_label(j,:) == i
           count = count+1;
        end
        j= j+1;
    end
    aver0813(i,:) = mean(rssi_temp(count,:))
end


% rssi_temp = [rssi_temp,7*ones(length(rssi_temp),1)];
dlmwrite('train1.txt',rssi_temp,'delimiter',' ','newline','pc');
% mean_rssi_temp = round(mean(rssi_temp))

% for i = 1 :length(rssi_temp)
%     rssi_temp(i,:) = [rssi_temp(i,:),6]
% end