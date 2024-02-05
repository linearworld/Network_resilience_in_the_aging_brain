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
