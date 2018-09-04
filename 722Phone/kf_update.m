%% kf_update
function [dist,P,dx,K] = kf_update(dist_rssi,dist_pdr,P)
RSSI_cov = 0.1;
% y = dist_rssi - dist_pdr;
y = dist_pdr - dist_rssi;
H = 1;
S = H * P * H + RSSI_cov;
K = P * H * (1.0 / S);
% K = RSSI_cov * H * (1.0 / S);
P = (1 - K * H) * P;
dx = K * y;
% dist = dist_pdr + dx;
dist = dist_rssi + dx;
['updata dx:',num2str(dx)]
