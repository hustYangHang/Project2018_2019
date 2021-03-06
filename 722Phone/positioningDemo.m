function varargout = positioningDemo(varargin)
% POSITIONINGDEMO MATLAB code for positioningDemo.fig
%      POSITIONINGDEMO, by itself, creates a new POSITIONINGDEMO or raises the existing
%      singleton*.
%
%      H = POSITIONINGDEMO returns the handle to a new POSITIONINGDEMO or the handle to
%      the existing singleton*.
%
%      POSITIONINGDEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POSITIONINGDEMO.M with the given input arguments.
%
%      POSITIONINGDEMO('Property','Value',...) creates a new POSITIONINGDEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before positioningDemo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to positioningDemo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help positioningDemo

% Last Modified by GUIDE v2.5 08-Aug-2018 18:27:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @positioningDemo_OpeningFcn, ...
                   'gui_OutputFcn',  @positioningDemo_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
% --- Executes just before positioningDemo is made visible.
function positioningDemo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to positioningDemo (see VARARGIN)

% Choose default command line output for positioningDemo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes positioningDemo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = positioningDemo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag;
cur_t = 0;
P = 0.001;
flag = 1;
% train = importdata('fingerprint_phone_0823.txt');
% [train_data,train_label,Mea]=trainfunc(train);
% Nb=fitcnb(train_data,train_label);

% train_data =train(:,1:2);
% train_label = train(:,3);
% [train_data,PS]  = mapminmax(train_data');
% train_data = train_data';
% [test_data,PS]  = mapminmax('apply',test_data',PS);
% test_data = test_data';
% save('Nb.mat','Nb');
% save('Mea.mat','Mea');
count1=1;
% count2=1;
% count3=1;
% t1 = [];
% load('Nb.mat')
% echoudp('on',2048)
% 'LocalHost', '192.168.1.187',
packet = udp('0.0.0.10', 2048,'LocalPort', 2048, 'InputBufferSize',1024);
packet.Timeout = 10;
fopen(packet);
ip_list = string('');
rssi_buffer = zeros(20, 2); % sliding window. receive 5 RSSIs from 2 aps
% p_location_seq = zeros(20,1);
load('D:\722Phone\Nb.mat');
load('D:\722Phone\\Mea.mat');
p_predict_label = 1;
p_dist = 8;
dist_pdr = 0;
% dist_k1 = 3;
t1 = [];
p_pdr_label = 1;
first_packet = 1;
pdist_pdr_count = 0;
first_rssi_enable = 0;
ini_dist = 0;
pdr_count = 1;
save_file = 'D:\722Phone\P_12.txt';
while 1
%     pause(0.001);
    if flag == 0
        break;
    end
    s = warning('error', 'instrument:fread:unsuccessfulRead');
    try
         A = fread(packet, 1024);
    catch
        warning(s);
        disp('Timeout, please restart the client and connect again.');
        break;
    end
    data = native2unicode(A, 'UTF-8');
    str = data';
%     save_txt(str','D:\722Phone\data\received_data.txt');
    if (str(1) == '2')%PDR
         if first_packet == 1
             tic;
             t = 0;
             pdr_count = 3;
             first_packet = 0;
         else
             t = toc;
             if pdr_count >= 3
                 pdr_count = 1;
             end
             pdr_count = pdr_count +1;
         end
%         disp(['packet:' str]);
        dist_pdr = str2num(str(12:15));
        dist_pdr_count = str2num(str(4:8));
        if dist_pdr_count ~= pdist_pdr_count
           ['t:',num2str(t),'cur_t',num2str(cur_t),'t-cur_t',num2str(t-cur_t)]
           %% 此处
           save_txt([1 P t cur_t t-cur_t]',save_file);
           [P,cur_t] = kf_predict(t,cur_t,P);
           pdist_pdr_count = dist_pdr_count;
        end
%         disp(['update P:' num2str(P)]);
%         set(handles.edit14,'string',num2str(predict_label));%此处加上范围
%         pause(0.001);
%         set(handles.edit5,'string',[str(3:6) 'm']);
%         pause(0.001);
%         dist = str2num()
    elseif(str(1)=='1')%RSSI
        ip_start = strfind(str,'_');
        loc_start = strfind(str,'Location:');
        ip = str(ip_start(1)+1:ip_start(2)-1);
        loc_num = str2double(str(loc_start+9:ip_start(3)-1));
        if first_rssi_enable == 0
            ini_dist = loc_num*0.75;
%             first_rssi_enable = 1;
        end
        isiplist = isempty(strfind(ip_list,ip));
        if isiplist == 1
            ip_list = ip_list + ' ' + ip;
        end
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

        try
%             [test_data loc_num]
            rssi_buffer(1: end-1, :) = rssi_buffer(2: end, :);
            rssi_buffer(end, :) = test_data;
%             count1
            t1(count1,:)= [test_data,loc_num];
            count1 = count1+1;
        catch
%             disp('error t1!');
        end
        mean_test_data = mean(rssi_buffer, 1);
        %% 
        c_predict_label = Nb.predict(mean_test_data(1:end));       
        if abs(c_predict_label - p_predict_label) >= 3
               c_predict_label = p_predict_label+randi(3,1,1)-2; 
        end
        p_predict_label = c_predict_label;
        if c_predict_label <=0
           c_predict_label = 1;
        elseif c_predict_label >=12
            c_predict_label = 11;
        end
        if p_predict_label <=0
           p_predict_label = 1;
        elseif p_predict_label >= 12
            p_predict_label = 11;
        end
        c_dist = mydistance(Mea, c_predict_label, mean_test_data(1:end));
        if abs(c_dist - p_dist)>= 6
               c_dist = p_dist+6*(rand(1,1)-0.5);
        end
        if c_dist < 0
            c_dist = 6;
        end
		
        p_dist = c_dist;    
%% 
        dist_rssi = c_dist;
        if (abs(ini_dist-dist_rssi) < 5)&&(first_rssi_enable == 0)
            ini_dist = dist_rssi;
            first_rssi_enable = 1;
        end
%         dist = dist_pdr+ini_dist;
        ['P before update:',num2str(P)]
        [dist,P,dx,K] = kf_update(dist_rssi,dist_pdr,P);
        dist = dist+ini_dist;
        save_txt([2 P dx K]',save_file);
        save_txt([3 dist dist_rssi dist_pdr]',save_file);

        ['P update:',num2str(P)]
        disp(['dist update:' num2str(dist)]);
        disp(['dist_rssi update:' num2str(dist_rssi)]);
        disp(['dist_pdr update:' num2str(dist_pdr)]);
        %% 最初的卡尔曼滤波
%         p_k_deviation = sqrt(p_predict_deviation^2+q_noise^2);
%         Kk = p_k_deviation^2/(p_k_deviation^2 + q_noise^2);
%         dist_k =dist_rssi + Kk*(dist_pdr-dist_rssi);
%         disp(['dist pdr:' num2str(dist_pdr)])
%         dist = dist_k;
%         disp(['dist :' num2str(dist)])
%         p_predict_deviation = sqrt((1-Kk)*p_k_deviation^2);    
%         dist = dist_pdr
        if dist >= 66
            dist = 65;
        elseif dist <= 0
            dist = 0;
        end
       %% 放宽边界处的判定范围，防止在边界处停留导致label显示波动的情况
        predict_label = predict_label_form_dist(p_pdr_label,dist);
        p_pdr_label = predict_label;
%         p_pdr_label = predict_label;
%         if abs(dist-dist_k1) <= 6
%             predict_label = predict_label_form_dist(dist);
%         else
%             predict_label = predict_label_form_dist(dist_k1);
%         end
%         dist_k1 = dist;
        
        set(handles.edit1,'string',num2str(predict_label));
        pause(0.001);
        if pdr_count == 3
            set(handles.edit5,'string',string(num2str(dist)) + string('m'));
            pause(0.001);
            pdr_count = 1;
        end
        set(handles.edit6,'string','0m');
        pause(0.001);
        set(handles.edit7,'string',string(num2str(mean_test_data(1)))+'dbm');
        pause(0.001);
        set(handles.edit8,'string',string(num2str(mean_test_data(2)))+'dbm');
        pause(0.001);
%     elseif (str(1)=='3')%KF
%        disp(['packet:' str]);
%        %扩展Kalman滤波在目标跟踪中的应用	
%        %function EKF_For_TargetTracking	
% 	   dist_pdr = str2num(str(3:6));
%        dist_est_k = dist_pdr;
% 	   p_k_deviation = sqrt(p_predict_deviation^2+q_noise^2);
% 	   Kk = p_k_deviation^2/(p_k_deviation^2 + q_noise^2);
% 	   dist_k = dist_est_k + Kk*(dist_rssi-dist_est_k);
% 	   p_predict_deviation = sqrt(((1-Kk)*p_k_deviation^2));
    else
        disp('error packet!')
    end
    flushinput(packet);
end
% dlmwrite('fingerprint_phone_0903.txt',t1,'-append','delimiter',' ','newline','pc');
fclose(packet);
set(handles.edit1,'string','Position Label');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag;
flag = 0;


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
