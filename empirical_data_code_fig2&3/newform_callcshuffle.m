% ����3
% ���ܣ���������ʱ������sequencedata1��sequencedata2�����ú���2��������Һ�ʱ�����е�c��cshuffle��W��Wshuffle
% ���룺��Ҫ���ҵ�����ʱ������
% �����������ʱ�����д��Һ����õ���c����
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
