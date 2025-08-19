clear

load('./500.mat');
load('./1000.mat');
load('./1500.mat');
load('./2000.mat');
load('./2500.mat');
load('./3000.mat');
load('./3500.mat');
load('./time.mat');

d500 = AD500;
d1000 = AD1000;
d1500 = AD1500;
d2000 = AD2000;
d2500 = AD2500;
d3000 = AD3000;
d3500 = AD3500;

erp0=[d500;d1000;d1500;d2000;d2500;d3000;d3500];
erp=permute(erp0,[2 3 1]);

lmmData = csvread('T.LMM.csv',1,0)

n=0

% bUnifPE
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
save(strcat(savepath,'lmetTDEA.mat'),'lmeERP');
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
save(strcat(savepath,'lmetDDT.mat'),'lmeERP');
clear lmeERP;

