x = 500:500:3500;
y_all = [
    0.0375	0.35	0.7125	0.9125	0.95	0.975	0.9875;
    0.0125	0.05	0.175	0.425	0.6125	0.8625	0.95;
    0	0.05	0.2625	0.4875	0.7375	0.875	0.9375;
    0.0625	0.1625	0.3875	0.775	0.8625	0.85	0.9125;
    0.05	0.075	0.1375	0.25	0.3	0.4375	0.525;
    0.025	0.0625	0.4	0.5375	0.725	0.8625	0.95;
    0.025	0.0375	0.275	0.6125	0.825	0.8875	0.95;
    0	0	0.0625	0.675	0.95	0.9875	1;
    0.0125	0	0.4875	0.85	1	1	1;
    0.0125	0.2	0.525	0.6625	0.8875	0.9375	0.9625;
    0	0.05	0.425	0.775	0.875	0.9625	0.95;
    0	0.025	0.2125	0.5375	0.725	0.9625	0.95;
];

y_mean = mean(y_all, 1);  
y_std = std(y_all, 0, 1); 
y_se = y_std / sqrt(size(y_all, 1)); 

modelFun = @(p, x) normcdf(x, p(1), p(2));
startingVals = [2000, 500]; 
coefEsts = nlinfit(x, y_mean, modelFun, startingVals); 


xgrid = linspace(min(x), max(x), 100);
figure;
plot(xgrid, modelFun(coefEsts, xgrid), 'Color', [0 135 108]/255, 'LineWidth', 2); 
hold on;
errorbar(x, y_mean, y_se, 'ko', 'LineWidth', 1.5, 'CapSize', 10); 
xlabel('Probe time interval (ms)');
ylabel('P(“Longer” responses)');

find_x_at_y_half = @(x) modelFun(coefEsts, x) - 0.5;
x_at_y_half = fzero(find_x_at_y_half, mean(x)); 

y_at_x_half = 0.5;
plot([0, x_at_y_half], [y_at_x_half, y_at_x_half], '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 1);

plot(x_at_y_half, 0.5, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 5); 

plot([x_at_y_half, x_at_y_half], [0, 0.5], 'k--', 'LineWidth', 1); 


xlim([0, 4000]);

box off