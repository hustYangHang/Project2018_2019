function varargout = Demo(varargin)
% DEMO MATLAB code for Demo.fig
%      DEMO, by itself, creates a new DEMO or raises the existing
%      singleton*.
%
%      H = DEMO ret urns the handle to a new DEMO or the handle to
%      the existing singleton*.
%
%      DEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMO.M with the given input arguments.
%
%      DEMO('Property','Value',...) creates a new DEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Demo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Demo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Demo

% Last Modified by GUIDE v2.5 27-Jul-2018 07:26:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Demo_OpeningFcn, ...
                   'gui_OutputFcn',  @Demo_OutputFcn, ...
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


% --- Executes just before Demo is made visible.
function Demo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Demo (see VARARGIN)

% Choose default command line output for Demo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Demo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Demo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag;
flag = 1;
num_packet = 60;
%ma = 0.18;
ma = 0.09;
port = 8090;
t = tcpip('0.0.0.0', port, 'NetworkRole', 'server');
t.InputBufferSize = 2048;
t.Timeout = 60;
fprintf('Waiting for connection on port %d\n',port);
fopen(t);
fprintf('Accept connection from %s\n',t.RemoteHost);
packet_index = 0;
endian_format = 1; % 0 denotes 'ieee-le' and 1 denotes 'ieee-be';
% tic
while 1
    % Read size and code from the received packets
    pause(0.001);
    if flag == 0
        break;
    end
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

        % assemble uint16 number by little endian
        bytes = fread(t, 2, 'uint8');
        csi_len = convert_uint16(bytes, endian_format);     % it can only convert two bytes
        if csi_len == 0
            continue;
        end
        csi_matrix.csi_len = csi_len;

        bytes = fread(t, 2, 'uint8'); 
        tx_channel = convert_uint16(bytes, endian_format);
        csi_matrix.channel = tx_channel;

        err_info = fread(t, 1,'uint8');
        csi_matrix.err_info = err_info;

        noise_floor = fread(t, 1, 'uint8');
        csi_matrix.noise_floor = noise_floor;

        Rate = fread(t, 1, 'uint8');
        csi_matrix.Rate = Rate;


        bandWidth = fread(t, 1, 'uint8');
        csi_matrix.bandWidth = bandWidth;

        num_tones = fread(t, 1, 'uint8');
        csi_matrix.num_tones = num_tones;

        nr = fread(t, 1, 'uint8');
        csi_matrix.nr = nr;

        nc = fread(t, 1, 'uint8');
        csi_matrix.nc = nc;

        rssi = fread(t, 1, 'uint8');
        csi_matrix.rssi = rssi;

        rssi1 = fread(t, 1, 'uint8');
        csi_matrix.rssi1 = rssi1;

        rssi2 = fread(t, 1, 'uint8');
        csi_matrix.rssi2 = rssi2;

        rssi3 = fread(t, 1, 'uint8');
        csi_matrix.rssi3 = rssi3;

        bytes = fread(t, 2, 'uint8');
        payload_len = convert_uint16(bytes, endian_format);
        payload_len = double(payload_len);
        csi_matrix.payload_len = payload_len;

        
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
        
        flushinput(t);
    else
        flushinput(t);
        continue;
    end
    fprintf('\n\nRunning packet %d\n', packet_index)
    csi_entry = csi_matrix.csi;

    nc = csi_matrix.nc;
    nr = csi_matrix.nr;
    
    csi_tx1 = abs(squeeze(csi_entry(:,1,:)));
    csi_tx2 = abs(squeeze(csi_entry(:,2,:)));   
    
    [pearson_csi_tx1(mod(packet_index,num_packet)+1,:), pearson_csi_tx2(mod(packet_index,num_packet)+1,:)]  = csi_pearson(csi_tx1, csi_tx2);
    
%%%%%%%%%count packets%%%%%%%%%%%%%%%%%%%%    
    if 	mod(packet_index,num_packet) == 0
        mad_pearson1 = mad(pearson_csi_tx1,1);
        mad_pearson2 = mad(pearson_csi_tx2,1);
        max_mad = max(mad_pearson1, mad_pearson2);
        min_mad = min(mad_pearson1, mad_pearson2);
        bound = min(mad_pearson2, (max_mad + min_mad)/2.0);
        if bound < ma
            set(handles.edit1,'string','无人');
            pause(0.001);
        else
            set(handles.edit1,'string','有人');
            pause(0.001);
        end
        
    end
   
    flushinput(t);
end
fclose(t);
fprintf('Done Running!\n');
set(handles.edit1,'string','开始监控');
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag;
flag = 0;
