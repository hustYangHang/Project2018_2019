train = importdata('traindata0818_2.txt');
x1 = train(:,1);
x2 = train(:,2);
y = train(:,3);
figure;
plot(x1);
hold on;
plot(x2);
%gscatter(x1,x2,y,'brkrkbrkbrkb','o*+phodhs');
figure
a=smooth(x1,30);
b=smooth(x2,30);
plot(a);
hold on;
plot (b);
