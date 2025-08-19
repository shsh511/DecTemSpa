function predictLme4()
clear
    x = [7 14 21 28 35 42 49]; 
    sizX=size(x);
    
    
    clERP = csvread('S.LMM.csv',1,0);
    predClsP3 = csvread('S.P3.sTDEA.predict.csv',1,0); 
    
for isub=1:12   
for i=1:sizX(2)
        indx1 = find(clERP(:,6) == x(i));


mErpP3(i,isub) = mean(clERP(indx1,5)); 
mpreClsP3(i,isub) = mean(predClsP3(indx1,1));

              
mmErpP3 = squeeze(mean(mErpP3,2));
seErpP3(i,1) = std(clERP(indx1,5),0,1)/sqrt(isub);
mmpreClsP3 = squeeze(mean(mpreClsP3,2));
sepreClsP3(i,1) = squeeze(std(mmpreClsP3,0,1)/sqrt(isub));

end
end
        

       subplot(1,1,1); 
errorbar(x(:),mmErpP3,seErpP3,'o','linewidth',1.5,'Color','k', 'MarkerSize',6,...
   'MarkerEdgeColor','k','MarkerFaceColor','none');

hold on


plt.m=mmpreClsP3';
plt.se=sepreClsP3';
plt.color=[0 135 108]/255;
plt.xrange=[0 55];
plt.yrange=[6 12];  
plt.x=x;
d_plotpic(plt);




function d_plotpic(plt);
m=plt.m;
se=plt.se;
color=plt.color;
xrange=plt.xrange;
yrange=plt.yrange;
x=plt.x

set(gca,'FontSize',12);
set(gca,'Fontname', 'Arial')
set(gca, 'ylim',yrange);    
set(gca, 'xlim',xrange);
xlabel('Probe spatial distance (°)','fontsize',16); 
ylabel('Amplitude (uV)','fontsize',16);  

y1=m-se;
y2=m+se;


[xx,yy]=fill2line(x,y1,y2);
h=fill(xx,yy,color,'EdgeColor',color,'FaceAlpha',0.3,'EdgeAlpha',0.3);
set(h,'edgecolor','white');
set(gca, 'ylim',yrange); 
set(gca, 'xlim',xrange); 

hold on;

plot(x,m,'-',...
                'LineWidth',1,...
                'Color',color)
            hold on;
hold on;


            
function [xx,yy]=fill2line(x,y1,y2)


sizX=size(x);
xx(1:sizX(2))=x;
xx(sizX(2)+1:sizX(2)*2)=x(1,sizX(2):-1:1);

yy(1:sizX(2))=y1;
yy(sizX(2)+1:sizX(2)*2)=y2(1,sizX(2):-1:1);