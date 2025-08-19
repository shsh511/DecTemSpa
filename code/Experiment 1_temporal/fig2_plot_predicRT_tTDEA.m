function predictLme4()
clear
    x = [500 1000 1500 2000 2500 3000 3500]; 
    sizX=size(x);
    
    clERP = csvread('T.LMM.csv',1,0);
    predRT = csvread('T.RT.tTDEA.predict.csv',1,0); 
    
for isub=1:12   
for i=1:sizX(2)
        indx1 = find(clERP(:,6) == x(i));


mRT(i,isub) = mean(clERP(indx1,4)); 
mpreRT(i,isub) = mean(predRT(indx1,1));

               
mmRT = squeeze(mean(mRT,2));
seRT(i,1) = std(clERP(indx1,4),0,1)/sqrt(isub);
mmpreRT = squeeze(mean(mpreRT,2));
sepreRT(i,1) = squeeze(std(mmpreRT,0,1)/sqrt(isub));

end
end
     

       subplot(1,1,1); 
errorbar(x(:),mmRT,seRT,'o','linewidth',1.5,'Color','k', 'MarkerSize',6,...
   'MarkerEdgeColor','k','MarkerFaceColor','k');

hold on

plt.m=mmpreRT';
plt.se=sepreRT';
plt.color=[0 135 108]/255;
plt.xrange=[0 4000];
plt.yrange=[300 550];  
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
xlabel('Probe time interval (ms)','fontsize',16); 
ylabel('Reaction time (ms)','fontsize',16);  

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