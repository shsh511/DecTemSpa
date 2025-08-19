eeglab;

subplot(1,3,[1 2]);

load('time.mat');

load('lmetTDEA.mat');
lmeERPtTDEA = lmeERP;
clear lmeERP;

load('lmetDDT.mat');
lmeERPtDDT = lmeERP;
clear lmeERP;

dAIC = lmeERPtDDT.AIC - lmeERPtTDEA.AIC;

elec = 1:65;
[x, y] = meshgrid(time, elec);

pcolor(x, y, dAIC);
shading interp;
caxis([-50 50]);

hold on;
fill([425 425 475 475], [1 62 62 1], 'k', 'facealpha', 0.05);
plot([0, 0], [1, 62], '--k', 'LineWidth', 1);

set(gca, 'ylim', [1, 62]);
set(gca, 'xlim', [-200, 698]);
set(gca, 'YDir', 'reverse');


subplot(1,3,3);

load('time.mat');
load('chanlocs.mat');

load('lmetTDEA.mat');
AIC_DDT = lmeERP.AIC;
clear lmeERP;

load('lmetDDT.mat');
AIC_TPD = lmeERP.AIC;
clear lmeERP;

dAIC = AIC_TPD - AIC_DDT;

indx1 = find(time >= 425);
indx2 = find(time <= 475);
indx = intersect(indx1, indx2);

mAIC = mean(dAIC(:, indx), 2);
topoplot(mAIC, chanlocs, 'style', 'both', 'electrodes', 'on');
caxis([-50 50]);

colorbar;
