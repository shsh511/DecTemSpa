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

data = csvread('S.LMM.csv',1,0)

lmmlabel = zeros(84, 2);
sub = 1:12;
len = [7, 14, 21, 28, 35, 42, 49];

assert(numel(len) == 7, '持续空间数组len必须包含7个元素');

for i = 1:84
    lmmlabel(i, 1) = mod(i-1, 12) + 1;
end

for i=1:84;
    lmmlabel(i,1)=mod(i,12);
end;
for i=1:84;
    if lmmlabel(i,1)==0;
    lmmlabel(i,1)=12;
    end;
end;

for i=1:84;
    
    lmmlabel(i,2)=len(ceil(i/12));

end;


indx1=find(time>=360);
indx2=find(time<=410);
indx=intersect(indx1,indx2);

P3=mean(erp(:,indx,:),2);
P3Pz=squeeze(mean(P3([45 46 47],:,:),1));

lmmP3=[lmmlabel P3Pz];

lmmdata=[[1:3];lmmP3];

csvwrite('lmmd_P3.csv',lmmdata);

clear indx1 indx2 indx lmmdata;
