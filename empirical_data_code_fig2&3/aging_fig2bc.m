coefficient=polyfit(-A01,E1(loc),1);  %用一次函数拟合曲线，想用几次函数拟合，就把n设成那个数
y1=polyval(coefficient,-A01);
%plot(x,y,'-',x,y1,'o')，这个地方原来'-'和'o'写反了，现已更正，可以得到正确的图形。
subplot(1,2,1)
plot(-A01,E1(loc),'o',-A01,y1,'-')
xlabel('Atrophy0,1')
ylabel('E1')

coefficient=polyfit(-A12(loc),E1(loc),1);  %用一次函数拟合曲线，想用几次函数拟合，就把n设成那个数
y2=polyval(coefficient,-A12(loc));
%plot(x,y,'-',x,y1,'o')，这个地方原来'-'和'o'写反了，现已更正，可以得到正确的图形。
subplot(1,2,2)
plot(-A12(loc),E1(loc),'o',-A12(loc),y2,'-')
xlabel('Atrophy1,2')
ylabel('E1')