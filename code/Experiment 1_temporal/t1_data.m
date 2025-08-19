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

data = csvread('T.LMM.csv',1,0)

lmmlabel = zeros(84, 2);
sub = 1:12;
dur = [500, 1000, 1500, 2000, 2500, 3000, 3500];

assert(numel(dur) == 7, '持续时间数组dur必须包含7个元素');


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
    
    lmmlabel(i,2)=dur(ceil(i/12));

end;


indx1=find(time>=425);
indx2=find(time<=475);
indx=intersect(indx1,indx2);

P3=mean(erp(:,indx,:),2);
P3Pz=squeeze(mean(P3([45 46 47],:,:),1));

lmmP3=[lmmlabel P3Pz];

lmmdata=[[1:3];lmmP3];


csvwrite('lmmd_P3.csv',lmmdata);