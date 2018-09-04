clear all;
clc;
flag = 0;
packet = udp('0.0.0.0', 2048,'LocalPort', 2048, 'InputBufferSize',1024);
packet.Timeout = 10;
fopen(packet);
packet1 = udp('255.255.255.255', 4096,'LocalPort', 4096, 'InputBufferSize',1024);
packet1.Timeout = 10;
fopen(packet1);
ip_list  = string('');
while 1
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
% 		flag = str(1:2);
		if (flag == 0)% 如果接受到flag 0 
		data_trans = str(2:14)	%电脑接受数据，处理并发送数据
        try
            fwrite(packet1,data_trans,'uchar');
            disp('Send success!')
        catch
            disp('Timeout1')
        end
		elseif(flag == 1)%如果接受到flag 1
		disp(str)	%电脑接受数据并进行显视
		else
			disp('packet error!')	
		end
	catch
		disp('Timeout!')
    end
end
% fclose(packet1);
fclose(packet);