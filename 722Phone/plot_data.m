train = importdata('fingerprint_phone_0823.txt');
X1=train(:,1);
X2=train(:,2);
figure(1);
hold on;
plot(X1);
plot(X2);
