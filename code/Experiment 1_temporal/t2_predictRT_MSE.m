clear;

clERP = csvread('T.LMM.csv',1,0);
PEtTDEA=csvread('T.RT.tTDEA.predict.csv',1,0);
PEtDDT=csvread('T.RT.tDDT.predict.csv',1,0);

RT=clERP(:,4);

SS1=(RT-PEtTDEA).^2;
SS2=(RT-PEtDDT).^2;

for isub=1:12;    
        indx = find(clERP(:,1) == isub);
        
        MSE(isub,1) = mean(SS1(indx,1));
        MSE(isub,2) = mean(SS2(indx,1));
end;


[h,p,ci,stats] = ttest(MSE(:,1),MSE(:,2))

mMSE=mean(MSE,1)
seMSE=std(MSE,0,1)/sqrt(12)

x1 = mMSE - 1.96*seMSE
x2 = mMSE + 1.96*seMSE


mean_diff = mean(MSE(:, 1)) - mean(MSE(:, 2)); 
sd_diff = std(MSE(:, 1) - MSE(:, 2));        
n = size(MSE, 1); 
cohen_d = mean_diff / sd_diff;


fprintf('results: t(%d) = %.3f, p = %.4f\n', stats.df, stats.tstat, p);
fprintf('Cohen’s d = %.3f\n', cohen_d);
