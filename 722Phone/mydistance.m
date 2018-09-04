%%
%求出距离
function [dist]=mydistance(Mea,predict_label, test)
yt=predict_label;
slot=6;
%输入测试集的数据是test=1*2数据；
%yt是测试的label
%如果yt是第一类，则和1，2类相比较，如果是第九类，则和8，9均值相比，如果是中间的，则和yt-1,yt+1相比
if(yt==1)
   dis1=sqrt(abs(test(1,1)-Mea(yt,1))^2+abs(test(1,2)-Mea(yt,2))^2);
   dis2=sqrt(abs(test(1,1)-Mea(yt+1,1))^2+abs(test(1,2)-Mea(yt+1,2))^2);
   dist=(yt*slot)*(dis2/(dis1+dis2))+((yt+1)*slot)*(dis1/(dis1+dis2));
elseif(yt<=8&yt>=2)
       dis1=sqrt(abs(test(1,1)-Mea(yt,1))^2+abs(test(1,2)-Mea(yt,2))^2);
       dis2=sqrt(abs(test(1,1)-Mea(yt+1,1))^2+abs(test(1,2)-Mea(yt+1,2))^2);
       
       dis3=sqrt(abs(test(1,1)-Mea(yt,1))^2+abs(test(1,2)-Mea(yt,2))^2);
       dis4=sqrt(abs(test(1,1)-Mea(yt-1,1))^2+abs(test(1,2)-Mea(yt-1,2))^2);
       if((dis1+dis2)<=(dis3+dis4))
           dist=(yt*slot)*(dis2/(dis1+dis2))+((yt+1)*slot)*(dis1/(dis1+dis2));
       else
           dist=(yt*slot)*(dis4/(dis3+dis4))+((yt-1)*slot)*(dis3/(dis3+dis4));
       end
else
       dis1=sqrt(abs(test(1,1)-Mea(yt,1))^2+abs(test(1,2)-Mea(yt,2))^2);
       dis2=sqrt(abs(test(1,1)-Mea(yt-1,1))^2+abs(test(1,2)-Mea(yt-1,2))^2);
       dist=(yt*slot)*(dis2/(dis1+dis2))+((yt-1)*slot)*(dis1/(dis1+dis2));
end
