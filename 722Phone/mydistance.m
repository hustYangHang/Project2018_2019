%%
%�������
function [dist]=mydistance(Mea,predict_label, test)
yt=predict_label;
slot=6;
%������Լ���������test=1*2���ݣ�
%yt�ǲ��Ե�label
%���yt�ǵ�һ�࣬���1��2����Ƚϣ�����ǵھ��࣬���8��9��ֵ��ȣ�������м�ģ����yt-1,yt+1���
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
