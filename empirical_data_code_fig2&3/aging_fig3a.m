ZA01=zscore(-A01);
ZA12=zscore(-A12(loc));
ZE1=zscore(E1(loc));
ZE12=zscore((E2(loc)-E1(loc))./E1(loc));

ind1=class_70(loc)==1;
ind2=class_70(loc)==2;
ZA01_1=mean(ZA01(ind1));
ZA12_1=mean(ZA12(ind1));
ZE1_1=mean(ZE1(ind1));
ZA01_2=mean(ZA01(ind2));
ZA12_2=mean(ZA12(ind2));
ZE1_2=mean(ZE1(ind2));

ZA01_11=std(ZA01(ind1))/sqrt(length(ZA01(ind1)));
ZA12_11=std(ZA12(ind1))/sqrt(length(ZA12(ind1)));
ZE1_11=std(ZE1(ind1))/sqrt(length(ZE1(ind1)));
ZA01_22=std(ZA01(ind2))/sqrt(length(ZA01(ind2)));
ZA12_22=std(ZA12(ind2))/sqrt(length(ZA12(ind2)));
ZE1_22=std(ZE1(ind2))/sqrt(length(ZE1(ind2)));

errorbar([1 2 3],[ZA01_1 ZE1_1 ZA12_1],[ZA01_11 ZE1_11 ZA12_11])
hold on
errorbar([1 2 3],[ZA01_2 ZE1_2 ZA12_2],[ZA01_22 ZE1_22 ZA12_22])

shuchu=[[ZA01_1 ZE1_1 ZA12_1]' [ZA01_11 ZE1_11 ZA12_11]' [ZA01_2 ZE1_2 ZA12_2]' [ZA01_22 ZE1_22 ZA12_22]'];

shuchu1=[ZA01(ind1) ZE1(ind1) ZE12(ind1)];
shuchu2=[ZA01(ind2) ZE1(ind2) ZE12(ind2)];
shuchu1=[[1:3]' shuchu1'];
shuchu2=[[1:3]' shuchu2'];
figure
plot(shuchu1(:,1),shuchu1(:,2:end),'-o','Color',[0.333 0.627 0.984],'LineWidth',2)
hold on
plot(shuchu2(:,1),shuchu2(:,2:end),'-o','Color',[1 0.380 0],'LineWidth',2)
set(gca,'LineWidth',2)
set(gca,'XLim',[0.5 3.5])