% 函数1
% 功能：计算两个序列的c，cshuffle，W，Wshuffle
% 输入：两个节点的时间序列
% cW=newform_callmaplineonetime(temp(:,m),temp(:,n));
% temp的不同列是不同节点的时间序列
% cW是1行4列的数组
% 调用函数2计算c序列，调用函数3打乱两个序列
% 由得到的c序列计算W，Wshuffle

function cW=newform_callmaplineonetime(data1,data2)
l=fix(length(data1)/2);
c_s=newform_callcsec(data1,data2);
rest=[c_s(1:l,1);c_s(l+2:end)];
c=c_s(l+1,1);
W=(c-mean(rest))/std(rest);
 
cshuffle_s=newform_callcshuffle(data1,data2);
rest_shuffle=[cshuffle_s(1:l,1);cshuffle_s(l+2:end)];
cshuffle=cshuffle_s(l+1,1);
Wshuffle=(cshuffle-mean(rest_shuffle))/std(rest_shuffle);
cW=[c,cshuffle,W,Wshuffle];
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end