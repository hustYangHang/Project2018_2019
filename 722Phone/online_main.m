clear;
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Build a TCP Server and wait for connection
port = 8090;
t = tcpip('0.0.0.0', port, 'NetworkRole', 'server');
t.InputBufferSize = 2048;
t.Timeout = 60;
fprintf('Waiting for connection on port %d\n',port);
fopen(t);
fprintf('Accept connection from %s\n',t.RemoteHost);
packet_index = 0;
endian_format = 1; % 0 denotes 'ieee-le' and 1 denotes 'ieee-be';
while 1
    % Read size and code from the received packets
    s = warning('error', 'instrument:fread:unsuccessfulRead');
    try
        field_len = fread(t, 1, 'uint16');
    catch
        warning(s);
        disp('Timeout, please restart the client and connect again.');
        break;
    end
    if field_len == 1905
        % deal with time stamp byte by byte to combine a uint64 number, which is not supported in
        % instrument fread 
        bytes = fread(t, 8, 'uint8');
        bytes = uint8(bytes);
        timestamp = read_timestamp(bytes);
        csi_matrix.timestamp = timestamp;
        fprintf('timestamp is %d\n',timestamp);

        % assemble uint16 number by little endian
        bytes = fread(t, 2, 'uint8');
        csi_len = convert_uint16(bytes, endian_format);     % it can only convert two bytes
        if csi_len == 0
            continue;
        end
        csi_matrix.csi_len = csi_len;
        fprintf('csi_len is %d\n',csi_len);

        bytes = fread(t, 2, 'uint8'); 
        tx_channel = convert_uint16(bytes, endian_format);
        csi_matrix.channel = tx_channel;
        fprintf('channel is %d\n',tx_channel);

        err_info = fread(t, 1,'uint8');
        csi_matrix.err_info = err_info;
        fprintf('err_info is %d\n',err_info);

        noise_floor = fread(t, 1, 'uint8');
        csi_matrix.noise_floor = noise_floor;
        fprintf('noise_floor is %d\n',noise_floor);

        Rate = fread(t, 1, 'uint8');
        csi_matrix.Rate = Rate;
        fprintf('rate is %x\n',Rate);


        bandWidth = fread(t, 1, 'uint8');
        csi_matrix.bandWidth = bandWidth;
        fprintf('bandWidth is %d\n',bandWidth);

        num_tones = fread(t, 1, 'uint8');
        csi_matrix.num_tones = num_tones;
        fprintf('num_tones is %d  ',num_tones);

        nr = fread(t, 1, 'uint8');
        csi_matrix.nr = nr;
        fprintf('nr is %d  ',nr);

        nc = fread(t, 1, 'uint8');
        csi_matrix.nc = nc;
        fprintf('nc is %d\n',nc);

        rssi = fread(t, 1, 'uint8');
        csi_matrix.rssi = rssi;
        fprintf('rssi is %d\n',rssi);

        rssi1 = fread(t, 1, 'uint8');
        csi_matrix.rssi1 = rssi1;
        fprintf('rssi1 is %d\n',rssi1);

        rssi2 = fread(t, 1, 'uint8');
        csi_matrix.rssi2 = rssi2;
        fprintf('rssi2 is %d\n',rssi2);

        rssi3 = fread(t, 1, 'uint8');
        csi_matrix.rssi3 = rssi3;
        fprintf('rssi3 is %d\n',rssi3);

        bytes = fread(t, 2, 'uint8');
        payload_len = convert_uint16(bytes, endian_format);
        payload_len = double(payload_len);
        csi_matrix.payload_len = payload_len;
        fprintf('payload length: %d\n',payload_len);	

        
        csi_len = double(csi_len);
        csi_buf = fread(t, csi_len, 'uint8');
        csi_buf = uint8(csi_buf);
        nr = int32(nr);
        nc = int32(nc);
        num_tones = int32(num_tones);
        csi = read_csi(csi_buf, nr, nc, num_tones);
        csi_matrix.csi = csi;    
        
        if payload_len > 0
            data_buf = fread(t, payload_len, 'uint8');	    
            csi_matrix.payload = uint8(data_buf);
        else
            csi_matrix.payload = 0;
        end
        
        packet_index = packet_index + 1;
        fprintf('payload index: %d\n',packet_index);	

        
        flushinput(t);
    else
        flushinput(t);
        continue;
    end
    fprintf('\n\nRunning packet %d\n', packet_index)
    csi_entry = csi_matrix.csi;
    
    count = 1;
    nc = csi_matrix.nc;
    nr = csi_matrix.nr;
    
    fid = fopen('csi_tx1_0816_no_2.txt','a');

    csi_tx1 = abs(squeeze(csi_entry(:,1,:)));
    [b1,b2] = size(csi_tx1);
    for i=1:b1
        for j=1:b2
            fprintf(fid,'%d \t ',csi_tx1(i,j));    
        end
        fprintf(fid,'\r\n');  % 
    end
    
    fclose(fid);
    
    fid = fopen('csi_tx2_0816_no_2.txt','a');
 
    csi_tx2 = abs(squeeze(csi_entry(:,2,:)));   
    [b1,b2] = size(csi_tx2);
    for i=1:b1
        for j=1:b2
            fprintf(fid,'%d \t ',csi_tx2(i,j));    
        end
        fprintf(fid,'\r\n');  % 换行
    end
    fclose(fid);
    
%   [coeff,score,latent] = pca(csi_tx2);    
    csi_plot(csi_entry, nc, nr);
    
%     count = count + 1;
%     fprintf('count: %d\n',count);	

    flushinput(t);
end

fprintf('Done Running!\n')