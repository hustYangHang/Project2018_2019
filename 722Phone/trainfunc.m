function [traindata,trainlabel,Mea]=trainfunc(train)
X= train;
a=X(:,1); b=X(:,2); c=X(:,3);
%统计原始数据label中每种数据的个数
%这里是分成两个为一组
n1=length(find(c<=2));
n2=length(find(c>=3&c<=4));
n3=length(find(c>=5&c<=6));
n4=length(find(c>=7&c<=8));
n5=length(find(c>=9&c<=10));
n6=length(find(c>=11&c<=12));
n7=length(find(c>=13&c<=14));
n8=length(find(c>=15&c<=16));
n9=length(find(c>=17&c<=18));


d2=n1+n2;
d3=n1+n2+n3;
d4=n1+n2+n3+n4;
d5=n1+n2+n3+n4+n5;
d6=n1+n2+n3+n4+n5+n6;
d7=n1+n2+n3+n4+n5+n6+n7;
d8=n1+n2+n3+n4+n5+n6+n7+n8;
d9=n1+n2+n3+n4+n5+n6+n7+n8+n9;
%%
%txt数据中设置一部分为训练集
N_1=0;
N_2=5;
T1=[a(1:n1-N_1);a(n1+1:d2-N_1);a(d2+1:d3-N_1);a(d3+1:d4-N_1);a(d4+1:d5-N_1);a(d5+1:d6-N_1); a(d6+1:d7-N_1);a(d7+1:d8-N_1);a(d8+1:d9-N_1)];
T2=[b(1:n1-N_1);b(n1+1:d2-N_1);b(d2+1:d3-N_1);b(d3+1:d4-N_1);b(d4+1:d5-N_1);b(d5+1:d6-N_1); b(d6+1:d7-N_1);b(d7+1:d8-N_1);b(d8+1:d9-N_1)];
tl =[ones(n1-N_1,1); 2*ones(n2-N_1,1); 3*ones(n3-N_1,1); 4*ones(n4-N_1,1); 5*ones(n5-N_1,1); 6*ones(n6-N_1,1); 7*ones(n7-N_1,1); 8*ones(n8-N_1,1); 9*ones(n9-N_1,1)];
a=T1;
b=T2;
c=tl;
%对数据smooth
N=30;
%统计label中每种数据的个数
n1=length(find(c==1));
n2=length(find(c==2));
n3=length(find(c==3));
n4=length(find(c==4));
n5=length(find(c==5));
n6=length(find(c==6));
n7=length(find(c==7));
n8=length(find(c==8));
n9=length(find(c==9));

d2=n1+n2;
d3=n1+n2+n3;
d4=n1+n2+n3+n4;
d5=n1+n2+n3+n4+n5;
d6=n1+n2+n3+n4+n5+n6;
d7=n1+n2+n3+n4+n5+n6+n7;
d8=n1+n2+n3+n4+n5+n6+n7+n8;
d9=n1+n2+n3+n4+n5+n6+n7+n8+n9;
%对数据smooth
m1=[smooth(a(1:n1),N); smooth(a(n1+1:d2),N);smooth(a(d2+1:d3),N);smooth(a(d3+1:d4),N);smooth(a(d4+1:d5),N);smooth(a(d5+1:d6),N);smooth(a(d6+1:d7),N);smooth(a(d7+1:d8),N);smooth(a(d8+1:d9),N)];
m2=[smooth(b(1:n1),N); smooth(b(n1+1:d2),N);smooth(b(d2+1:d3),N);smooth(b(d3+1:d4),N);smooth(b(d4+1:d5),N);smooth(b(d5+1:d6),N);smooth(b(d6+1:d7),N);smooth(b(d7+1:d8),N);smooth(b(d8+1:d9),N)];
traindata=[m1 m2];
trainlabel=c;
%%
%clssification
fea1=m1;
fea2=m2;


M=[];
N=[];

x1=sum(fea1(1:n1))/n1;y1=sum(fea2(1:n1))/n1;
x2=sum(fea1(n1+1:d2))/n2; y2=sum(fea2(n1+1:d2))/n2;
x3=sum(fea1(d2+1:d3))/n3; y3=sum(fea2(d2+1:d3))/n3;
x4=sum(fea1(d3+1:d4))/n4; y4=sum(fea2(d3+1:d4))/n4;
x5=sum(fea1(d4+1:d5))/n5; y5=sum(fea2(d4+1:d5))/n5;
x6=sum(fea1(d5+1:d6))/n6; y6=sum(fea2(d5+1:d6))/n6;
x7=sum(fea1(d6+1:d7))/n7; y7=sum(fea2(d6+1:d7))/n7;
x8=sum(fea1(d7+1:d8))/n8; y8=sum(fea2(d7+1:d8))/n8;
x9=sum(fea1(d8+1:d9))/n9; y9=sum(fea2(d8+1:d9))/n9;
M=[x1,x2,x3,x4,x5,x6,x7,x8,x9];N=[y1,y2,y3,y4,y5,y6,y7,y8,y9];

Mea=[M' N'];























