coefficient=polyfit(-A01,E1(loc),1);  
y1=polyval(coefficient,-A01);
subplot(1,2,1)
plot(-A01,E1(loc),'o',-A01,y1,'-')
xlabel('Atrophy0,1')
ylabel('E1')

coefficient=polyfit(-A12(loc),E1(loc),1); 
y2=polyval(coefficient,-A12(loc));
subplot(1,2,2)
plot(-A12(loc),E1(loc),'o',-A12(loc),y2,'-')
xlabel('Atrophy1,2')
ylabel('E1')
