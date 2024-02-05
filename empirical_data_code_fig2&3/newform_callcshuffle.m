% 函数3
% 功能：打乱两个时间序列sequencedata1，sequencedata2，调用函数2，计算打乱后时间序列的c，cshuffle，W，Wshuffle
% 输入：需要打乱的两个时间序列
% 输出：这两个时间序列打乱后计算得到的c序列
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function cshuffle_s=newform_callcshuffle(sequencedata1,sequencedata2)
l=length(sequencedata1);
 
y=sequencedata1;
A=randperm(l);
daluani=y(A);
 
y=sequencedata2;
A=randperm(l);
move=y(A);
 
cshuffle_s=newform_callcsec(daluani,move);

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
