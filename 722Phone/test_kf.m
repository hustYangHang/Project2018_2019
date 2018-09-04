clear all;
clc;
N = 60;
A = 100;
error_probability = 1e-2;
p_predict_deviation = 1;
q_noise = 0.001;

corr_data = zeros(N*A,1);
corr_data_observation = zeros(N*A,1);
for i = 1:N*A
    corr_data(i,1) = sin(i*2*pi/N)+error_probability*rand(1,1);
end
for i = 1:N*A
    corr_data_observation(i,1) = sin(i*2*pi/N)+error_probability*rand(1,1)*i/3;
end

dist_pdr(1,1) = corr_data(1,1);
dist_est_k(1,1) = dist_pdr(1,1);
dist_k(1,1) = dist_pdr(1,1);
for i = 2:N*A
    dist_est_k(i,1) = dist_k(i-1,1);
    p_k_deviation = sqrt(p_predict_deviation^2+q_noise^2);
    Kk = p_k_deviation^2/(p_k_deviation^2 + q_noise^2)
    dist_k(i,1) = Kk*(corr_data_observation(i,1)-dist_est_k(i,1));
%     dist_est_k(i,1) = dist_k(i,1);
    p_predict_deviation = sqrt((1-Kk)*p_k_deviation^2)
end
figure
plot(corr_data,'r');
hold on
plot(corr_data_observation,'g');
hold on
plot(dist_k,'b');