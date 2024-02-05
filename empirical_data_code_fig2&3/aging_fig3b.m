figure;hold on
subplot(2,1,1)
hold on
[f,xi] = ksdensity(w2wpro.ave.Ef(loc631));
plot(xi,f,'-','LineWidth',3,'Color',[0.333 0.627 0.984])
[f,xi] = ksdensity(w4wpro.ave.Ef(loc631));
plot(xi,f,'--','LineWidth',3,'Color',[0.333 0.627 0.984])
legend({'T1','T2'})
xlim([0 1.4])
ylabel('Degeneration Group');
subplot(2,1,2)
hold on
[f,xi] = ksdensity(w2wpro.ave.Ef(loc632));
plot(xi,-f,'-','LineWidth',3,'Color',[1 0.380 0])
[f,xi] = ksdensity(w4wpro.ave.Ef(loc632));
plot(xi,-f,'--','LineWidth',3,'Color',[1 0.380 0])
legend({'T1','T2'})
xlim([0 1.4])
xlabel('Efficiency')
ylabel('Adaption Group');