global flag;
flag = 1;
% train = importdata('fingerprint_phone_0823.txt');
% [train_data,train_label,Mea]=trainfunc(train);
% Nb=fitcnb(train_data,train_label);
% save('Nb.mat','Nb');
% save('Mea.mat','Mea');

count1=1;
count2=1;
count3=1;
t1 = [];

% 'LocalHost', '192.168.1.187',
packet = udp('0.0.0.0', 2048,'LocalPort', 2048, 'InputBufferSize',1024);
% packet = udp('');
packet.Timeout = 10;
fopen(packet);
ip_list  = string('');

rssi_buffer = zeros(20, 2); % sliding window. receive 5 RSSIs from 2 aps
p_location_seq = zeros(20,1);
load('Nb.mat');
load('Mea.mat');
COUNT_ONUMBER = 0;
for j = 1:20
    try
        A = fread(packet, 1024);
        data = native2unicode(A, 'UTF-8');
        str = data'
        ip_start = strfind(str,'_');
        loc_start = strfind(str,'Location:');
        ip = str(ip_start(1)+1:ip_start(2)-1);
        loc_num = str2double(str(loc_start+9:ip_start(3)-1));
        isiplist = isempty(strfind(ip_list,ip));
        if isiplist == 1
            ip_list = ip_list + ' ' + ip;
        end
        ip_list
        user_flag = floor(strfind(ip_list,ip)/12) + 1;
    %     try
        if user_flag == 1
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
            for i = 1:length(index_start)
                temp = str(index_start(i):index_end(i));
                symbol_index = strfind(temp,':');
                RSSI(i, 1) = str2double(temp(4:symbol_index(1) - 1));
                RSSI(i, 2) = str2double(temp(symbol_index(end) + 1:end - 1));
            end 
            test_data = zeros(1, length(RSSI(:, 1)));
            for i = 1:length(RSSI(:, 1))
                test_data(uint8(RSSI(i, 1)) + 1) = RSSI(i,2);
            end
            % sliding windows
            rssi_buffer(1: end-1, :) = rssi_buffer(2: end, :);
            rssi_buffer(end, :) = test_data;
            p_location_seq(j,1) = Nb.predict(rssi_buffer(end,:)); 
        end
        COUNT_ONUMBER = COUNT_ONUMBER + 1;
        COUNT_ONUMBER
    catch
        disp('Timeout, please restart the client and connect again!');
        continue;
    end
end
smooth_rssi = mean(rssi_buffer, 1);
p_predict_label = mode(p_location_seq);
p_dist = mydistance(Mea, p_predict_label, smooth_rssi);
while 1
    pause(0.001);
    if flag == 0
        break;
    end
    s = warning('error', 'instrument:fread:unsuccessfulRead');
    try
        A = fread(packet, 1024);
        COUNT_ONUMBER = COUNT_ONUMBER + 1;
        COUNT_ONUMBER
    catch
        warning(s);
        disp('Timeout, please restart the client and connect again.');
        break;
    end
    data = native2unicode(A, 'UTF-8');
    str = data'
    ip_start = strfind(str,'_');
    loc_start = strfind(str,'Location:');
    ip = str(ip_start(1)+1:ip_start(2)-1);
    loc_num = str2double(str(loc_start+9:ip_start(3)-1));
    isiplist = isempty(strfind(ip_list,ip));
    if isiplist == 1
        ip_list = ip_list + ' ' + ip;
    end
    ip_list
    user_flag = floor(strfind(ip_list,ip)/12) + 1;
%     try
    if user_flag == 1
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
        for i = 1:length(index_start)
            temp = str(index_start(i):index_end(i));
            symbol_index = strfind(temp,':');
            RSSI(i, 1) = str2double(temp(4:symbol_index(1) - 1));
            RSSI(i, 2) = str2double(temp(symbol_index(end) + 1:end - 1));
        end 
        test_data = zeros(1, length(RSSI(:, 1)));
        for i = 1:length(RSSI(:, 1))
            test_data(uint8(RSSI(i, 1)) + 1) = RSSI(i,2);
        end
        % sliding windows
        rssi_buffer(1: end-1, :) = rssi_buffer(2: end, :);
        rssi_buffer(end, :) = test_data;
        test_data
        rssi_buffer
        mean_test_data = mean(rssi_buffer, 1);
        mean_test_data
        
        % display rssi
%         set(handles.edit7,'string',string(num2str(mean_test_data(1))) + string('dbm'));
%         pause(0.001);
%         set(handles.edit8,'string',string(num2str(mean_test_data(2))) + string('dbm'));
%         pause(0.001);
        t1(count1,:)= [test_data,loc_num]
        count1 = count1+1

        c_predict_label = Nb.predict(mean_test_data(1:end));
                
        c_dist=mydistance(Mea, c_predict_label, mean_test_data);
        ['test location']
        [p_predict_label c_predict_label]
        if abs(c_predict_label - p_predict_label) >= 3
               c_predict_label = p_predict_label+randi(3,1,1)-2; 
               [p_predict_label c_predict_label]
%                pause(1000)
        end
        p_predict_label = c_predict_label;
        if c_predict_label <=0
           c_predict_label = 1;
        elseif c_predict_label >=10
            c_predict_label = 9;
        end
        if p_predict_label <=0
           p_predict_label = 1;
        elseif p_predict_label >= 10
            p_predict_label = 9;
        end
        c_dist = mydistance(Mea, c_predict_label, mean_test_data(1:end));
        if abs(c_dist - p_dist)>= 6
               c_dist = p_dist+6*(rand(1,1)-0.5);
        end
        if c_dist < 0
            c_dist = 6;
        end
        p_dist = c_dist;
        predict_label = c_predict_label;
        dist = c_dist;
        
        flushinput(packet);
%         dlmwrite('test_distance_m.txt',dist,'-append','delimiter',' ','newline','pc');
        fwrite(packet,dist,'double');
        
    elseif user_flag == 2   
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
        for i = 1:length(index_start)
            temp = str(index_start(i):index_end(i));
            symbol_index = strfind(temp,':');
            RSSI(i, 1) = str2double(temp(4:symbol_index(1) - 1));
            RSSI(i, 2) = str2double(temp(symbol_index(end) + 1:end - 1));
        end 
        test_data = zeros(1, length(RSSI(:, 1)));
        for i = 1:length(RSSI(:, 1))
            test_data(uint8(RSSI(i, 1)) + 1) = RSSI(i,2);
        end
        
        count2 = count2+1;
        predict_label = Nb.predict(test_data(1:end));
        flushinput(packet);
    else
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
        for i = 1:length(index_start)
            temp = str(index_start(i):index_end(i));
            symbol_index = strfind(temp,':');
            RSSI(i, 1) = str2double(temp(4:symbol_index(1) - 1));
            RSSI(i, 2) = str2double(temp(symbol_index(end) + 1:end - 1));
        end 
        test_data = zeros(1, length(RSSI(:, 1)));
        for i = 1:length(RSSI(:, 1))
            test_data(uint8(RSSI(i, 1)) + 1) = RSSI(i,2);
        end     
    %   t3(count3,:)= test_data
        count3 = count3+1;
        predict_label = Nb.predict(test_data(1:end));
        flushinput(packet);
    end
%     catch
%         disp('Please check the network connection');
%         continue;
%     end
end
% dlmwrite('fingerprint_phone_0828_1.txt',t1,'-append','delimiter',' ','newline','pc');
fclose(packet);


