% 函数2
% 功能：计算两个序列data1和data2的c序列，c序列就是其中一个时间序列data2错位移动后，和data1计算得到的相关性系数的序列
% 输入：两个时间序列
% 输出：c序列
%  c_s=newform_callcsec(data1, data2);

function  c_s=newform_callcsec(data1,data2)
l=fix(length(data1)/2);
move=data2;
c_s=zeros(l*2+1,1);
hang=1;
for k=-l:l
    temp=circshift(move,k,1);
    [r,~]=corrcoef(data1,temp);
    c_s(hang,1)=r(2,1);
    hang=hang+1;
end
