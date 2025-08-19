clear

load('./500.mat');
load('./1000.mat');
load('./1500.mat');
load('./2000.mat');
load('./2500.mat');
load('./3000.mat');
load('./3500.mat');
load('./time.mat');


cor=[45,46,47];
timebase=201:251;
timeP3=201:426;

D500=AD500(:,:,timeP3);
D1000=AD1000(:,:,timeP3);
D1500=AD1500(:,:,timeP3);
D2000=AD2000(:,:,timeP3);
D2500=AD2500(:,:,timeP3);
D3000=AD3000(:,:,timeP3);
D3500=AD3500(:,:,timeP3);

dataAD500=squeeze(mean(mean(D500(:,cor,:),2),1));
dataAD1000=squeeze(mean(mean(D1000(:,cor,:),2),1));
dataAD1500=squeeze(mean(mean(D1500(:,cor,:),2),1));
dataAD2000=squeeze(mean(mean(D2000(:,cor,:),2),1));
dataAD2500=squeeze(mean(mean(D2500(:,cor,:),2),1));
dataAD3000=squeeze(mean(mean(D3000(:,cor,:),2),1));
dataAD3500=squeeze(mean(mean(D3500(:,cor,:),2),1));



figure(1)
plot(-200:4:700, dataAD500,'Color',[255 166 0]/255,'linewidth', 4); 
hold on
plot(-200:4:700, dataAD1000,'Color',[255 118 74]/255,'linewidth', 4); 
hold on
plot(-200:4:700, dataAD1500,'Color',[237 86 117]/255,'linewidth', 4); 
hold on
plot(-200:4:700, dataAD2000,'Color',[188 80 144]/255,'linewidth', 4); 
hold on
plot(-200:4:700, dataAD2500,'Color',[122 81 149]/255,'linewidth', 4); 
hold on
plot(-200:4:700, dataAD3000,'Color',[55 76 128]/255,'linewidth', 4); 
hold on
plot(-200:4:700, dataAD3500,'Color',[0 63 92]/255,'linewidth', 4); 
hold on


set(gca,'YDir','reverse'); 
plot([0, 0],[-3 7],'--k');
plot([-200, 700],[0,0],'--k');
x_P3 = [425, 475, 475, 425];  
y_P3 = [-0.5, -0.5, 6.5, 6.5];   
fill(x_P3, y_P3, [0.7 0.7 0.7], 'FaceAlpha', 0.3);
axis([-200 700 -3 7]);  
xlabel('Time (ms)','fontsize',16); 
ylabel('Amplitude (uV)','fontsize',16); 
xticks(-200:100:700);
legend('500','1000','1500','2000','2500','3000','3500')
title('A','position',[-180,-8.5],'fontsize',20)

