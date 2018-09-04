%% kf predict
function [P,cur_t] = kf_predict(t,cur_t,P)
    dt = t - cur_t;
    cur_t = t;
    F = 1;
    Q = 10;
    G = 1;
    P = (1 + dt * F) * P * (1 + dt * F) + (dt * G) * Q * (dt * G);
%     disp('dt: P_predict:')
%     dt
%     P