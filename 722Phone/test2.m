clear all
close all
clc
ip = [
-61 -29 10
-64 -32 10
-64 -32 10
-60 -29 10
-60 -15 10
-60 -15 10
-62 -27 10
-64 -38 10
-64 -38 10
-57 -38 10
-55 -33 10
-55 -33 10
-63 -28 10
-52 -33 10
-52 -33 10
-51 -30 10
-51 -30 10
-58 -52 10
-66 -29 10
-76 -28 10
-76 -28 10
-62 -39 10
-62 -39 10
-63 -37 10
-63 -30 10
-63 -30 10
-51 -42 10
-46 -43 10
-58 -34 10
-58 -34 10
-63 -21 10
-68 -24 10
-68 -24 10
-64 -37 10
-64 -37 10
-55 -38 10
-57 -40 10
-57 -40 10
-54 -40 10
-51 -32 10
-51 -32 10
-51 -27 10
-51 -33 10
-51 -33 10
-58 -34 10
-53 -35 10
-53 -35 10
-55 -28 10
-55 -23 10
-55 -23 10
-55 -30 10
-55 -39 10
-55 -39 10
-60 -42 10
-67 -32 10
-67 -32 10
-67 -40 10
-67 -40 10
-57 -31 10
-63 -32 10
-63 -32 10
-50 -24 10
-50 -33 10

]
ip_list  = round(mean(ip))
% % ip_list = ip_list + ip
% i = 1;
% isiplist = isempty(strfind(ip_list,ip))
% if isiplist == 1
%     ip_list = ip_list + ' ' + ip;
% end
% ip_list
% floor(strfind(ip_list,ip)/12) + 1
% a = isempty(strfind('str','t'))