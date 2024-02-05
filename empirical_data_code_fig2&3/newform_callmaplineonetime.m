

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
