clear
clc

load('preLoadData.mat')
load('efficiency_group_data.mat')
ind1=class_70==1;
ind2=class_70==2;

coefficient=polyfit(-A12(ind1),E1(ind1),1);  
y1=polyval(coefficient,-A12(ind1));
plot(-A12(ind1),E1(ind1),'bo',-A12(ind1),y1,'-','Color',[0.333 0.627 0.984])
shuchu1=[-A12(ind1),y1];
hold on
coefficient=polyfit(-A12(ind2),E1(ind2),1); 
y1=polyval(coefficient,-A12(ind2));
plot(-A12(ind2),E1(ind2),'ro',-A12(ind2),y1,'-','Color',[1 0.380 0])
shuchu2=[-A12(ind2),y1];
coefficient=polyfit(-A12,E1,1); 
y1=polyval(coefficient,-A12);
plot(-A12,y1,'k-.')
xlabel('Atrophy1,2')
ylabel('E1')
shuchu3=[-A12,y1];
