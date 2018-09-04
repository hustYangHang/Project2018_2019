clear all
clc
close all
%%%%%%%±´Ò¶Ë¹
load('Nb.mat')
% train = importdata('traindata.txt');
% train_data =train(:,1:2);
% train_label = train(:,3);
% Nb=fitcnb(train_data,train_label);
% save('Nb.mat','Nb');
str = 'Location:1_AP_1:HUST_WIRELESS_RSSI:-56;AP_2:eduroam-ruijie_RSSI:-66;360wifi_RSSI:-80;';
index_start = strfind(str,'AP_');
index_end = index_start;
RSSI = zeros(length(index_start), 2);
index_temp = strfind(str,';');
count = 1;
for i = 1:length(index_temp)
    if count > length(index_start)
        break;
    end
    if index_temp(i) > index_start(count)
        index_end(count) = index_temp(i);
        count = count + 1;
    end
end
loc = str2double(str(10:index_start(1) - 2));
for i = 1:length(index_start)
    temp = str(index_start(i):index_end(i));
    symbol_index = strfind(temp,':');
    RSSI(i, 1) = str2double(temp(4:symbol_index(1) - 1));
    RSSI(i, 2) = str2double(temp(symbol_index(end) + 1:end - 1));
end
test_data = [(RSSI(:,2))',loc];
predict_label=Nb.predict(test_data(1:end-1))