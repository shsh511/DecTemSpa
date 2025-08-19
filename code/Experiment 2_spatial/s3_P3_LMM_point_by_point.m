clear

load('./7°.mat');
load('./14°.mat');
load('./21°.mat');
load('./28°.mat');
load('./35°.mat');
load('./42°.mat');
load('./49°.mat');
load('./time.mat');

l7 = AL7;
l14 = AL14;
l21 = AL21;
l28 = AL28;
l35 = AL35;
l42 = AL42;
l49 = AL49;

erp0=[l7;l14;l21;l28;l35;l42;l49];
erp=permute(erp0,[2 3 1]);

lmmData = csvread('S.LMM.csv',1,0)

n=0

n=n+1
for i=1:65;
    for j=1:875;
        temp=double(squeeze(erp(i,j,:)));
        tbl = table(lmmData(:,1),lmmData(:,2),temp,'VariableNames',{'sub','model','erp'});
        lme = fitlme(tbl,'erp~model+(1|sub)+(model-1|sub)');
        lmeERP.b(i,j)=lme.Coefficients{2,2};
        lmeERP.se(i,j)=lme.Coefficients{2,3};
        lmeERP.t(i,j)=lme.Coefficients{2,4};
        lmeERP.df(i,j)=lme.Coefficients{2,5};
        lmeERP.p(i,j)=lme.Coefficients{2,6};
        lmeERP.AIC(i,j)=lme.ModelCriterion{1,1};
        lmeERP.BIC(i,j)=lme.ModelCriterion{1,2};
    end;
end;

savepath='./';
save(strcat(savepath,'lmesTDEA.mat'),'lmeERP');
clear lmeERP;

n=n+1
for i=1:65;
    for j=1:875;
       temp=double(squeeze(erp(i,j,:)));
        tbl = table(lmmData(:,1),lmmData(:,3),temp,'VariableNames',{'sub','model','erp'});
        lme = fitlme(tbl,'erp~model+(1|sub)+(model-1|sub)');
        lmeERP.b(i,j)=lme.Coefficients{2,2};
        lmeERP.se(i,j)=lme.Coefficients{2,3};
        lmeERP.t(i,j)=lme.Coefficients{2,4};
        lmeERP.df(i,j)=lme.Coefficients{2,5};
        lmeERP.p(i,j)=lme.Coefficients{2,6};
        lmeERP.AIC(i,j)=lme.ModelCriterion{1,1};
        lmeERP.BIC(i,j)=lme.ModelCriterion{1,2};
    end;
end;

savepath='./';
save(strcat(savepath,'lmesDDT.mat'),'lmeERP');
clear lmeERP;
