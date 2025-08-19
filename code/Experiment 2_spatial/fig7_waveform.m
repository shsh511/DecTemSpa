clear

load('./7°.mat');
load('./14°.mat');
load('./21°.mat');
load('./28°.mat');
load('./35°.mat');
load('./42°.mat');
load('./49°.mat');
load('./time.mat');

cor=[45,46,47];
timebase=201:251;
timeP3=201:426;

L7=AL7(:,:,timeP3);
L14=AL14(:,:,timeP3);
L21=AL21(:,:,timeP3);
L28=AL28(:,:,timeP3);
L35=AL35(:,:,timeP3);
L42=AL42(:,:,timeP3);
L49=AL49(:,:,timeP3);

dataAL7=squeeze(mean(mean(L7(:,cor,:),2),1)); 
dataAL14=squeeze(mean(mean(L14(:,cor,:),2),1));
dataAL21=squeeze(mean(mean(L21(:,cor,:),2),1));
dataAL28=squeeze(mean(mean(L28(:,cor,:),2),1));
dataAL35=squeeze(mean(mean(L35(:,cor,:),2),1));
dataAL42=squeeze(mean(mean(L42(:,cor,:),2),1));
dataAL49=squeeze(mean(mean(L49(:,cor,:),2),1));


figure(1)
plot(-200:4:700, dataAL7,'Color',[255 166 0]/255,'linewidth', 4); 
hold on
plot(-200:4:700, dataAL14,'Color',[255 118 74]/255,'linewidth', 4); 
hold on
plot(-200:4:700, dataAL21,'Color',[237 86 117]/255,'linewidth', 4); 
hold on
plot(-200:4:700, dataAL28,'Color',[188 80 144]/255,'linewidth', 4); 
hold on
plot(-200:4:700, dataAL35,'Color',[122 81 149]/255,'linewidth', 4); 
hold on
plot(-200:4:700, dataAL42,'Color',[55 76 128]/255,'linewidth', 4); 
hold on
plot(-200:4:700, dataAL49,'Color',[0 63 92]/255,'linewidth', 4); 
hold on


set(gca,'YDir','reverse'); 
plot([0, 0],[-3 12],'--k');
plot([-200, 700],[0,0],'--k');
x_P3 = [360, 410, 410, 360];  
y_P3 = [5,5, 11,11];   
fill(x_P3, y_P3, [0.7 0.7 0.7], 'FaceAlpha', 0.3);
axis([-200 700 -3 12]);  
xlabel('Time (ms)','fontsize',16); 
ylabel('Amplitude (uV)','fontsize',16); 
xticks(-200:100:700);
legend('7°','14°','21°','28°','35°','42°','49°')
title('A','position',[-180,-8.5],'fontsize',20)