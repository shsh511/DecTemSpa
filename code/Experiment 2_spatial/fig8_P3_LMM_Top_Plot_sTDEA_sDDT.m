eeglab;

subplot(1,3,[1 2]);

load('time.mat');
load('lmesTDEA.mat');
lmeERPsTDEA = lmeERP;
clear lmeERP;

load('lmesDDT.mat');
lmeERPsDDT = lmeERP;
clear lmeERP;

dAIC = lmeERPsTDEA.AIC - lmeERPsDDT.AIC;

elec = 1:65;
[x, y] = meshgrid(time, elec);

pcolor(x, y, dAIC);
shading interp;
caxis([-20 20]);

hold on;
fill([360 360 410 410], [1 62 62 1], 'k', 'facealpha', 0.05);
plot([0, 0], [1, 62], '--k', 'LineWidth', 1);

set(gca, 'ylim', [1, 62]);
set(gca, 'xlim', [-200, 698]);
set(gca, 'YDir', 'reverse');


subplot(1,3,3);

load('time.mat');
load('chanlocs.mat');

load('lmesTDEA.mat');
AIC_sTDEA= lmeERP.AIC;
clear lmeERP;

load('lmesDDT.mat');
AIC_sDDT = lmeERP.AIC;
clear lmeERP;

dAIC = AIC_sTDEA - AIC_sDDT;

indx1 = find(time >= 360);
indx2 = find(time <= 410);
indx = intersect(indx1, indx2);

mAIC = mean(dAIC(:, indx), 2);
topoplot(mAIC, chanlocs, 'style', 'both', 'electrodes', 'on');
caxis([-20 20]);
 
colorbar;
