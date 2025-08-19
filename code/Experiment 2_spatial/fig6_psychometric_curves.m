x = 7:7:49;
y_all = [
    0.0125	0.0625	0.575	0.8375	0.9375	0.975	1;
0	0.0125	0.4875	0.9375	0.9875	1	1;
0	0	0	0.025	0.55	0.975	1;
0	0	0.0625	0.175	0.7875	1	1;
0	0	0.05	0.5875	1	1	1;
0	0.0125	0.025	0.225	0.8	0.9	0.975;
0	0.025	0.0375	0.2125	0.75	0.95	0.9875;
0	0	0.0625	0.6375	0.925	1	1;
0.0125	0.2875	0.975	1	1	1	1;
0	0	0.0125	0.425	0.75	0.9125	0.9875;
0	0	0.0125	0.325	0.95	1	0.9875;
0.025	0.0375	0.0125	0.0875	0.2375	0.7375	1;

];

y_mean = mean(y_all, 1);  
y_std = std(y_all, 0, 1); 
y_se = y_std / sqrt(size(y_all, 1));


modelFun = @(p, x) normcdf(x, p(1), p(2));
startingVals = [28, 7];
coefEsts = nlinfit(x, y_mean, modelFun, startingVals); 


xgrid = linspace(min(x), max(x), 100);
figure;
plot(xgrid, modelFun(coefEsts, xgrid), 'Color', [0 135 108]/255, 'LineWidth', 2); 
hold on;
errorbar(x, y_mean, y_se, 'ko', 'LineWidth', 1.5, 'CapSize', 10);
xlabel('Probe spatial distance (°)');
ylabel('P(“Longer” responses)');

find_x_at_y_half = @(x) modelFun(coefEsts, x) - 0.5;
x_at_y_half = fzero(find_x_at_y_half, mean(x)); 

y_at_x_half = 0.5;
plot([min(x), x_at_y_half], [y_at_x_half, y_at_x_half], 'k--', 'LineWidth', 1); 


plot(x_at_y_half, 0.5, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 5); 


plot([x_at_y_half, x_at_y_half], [0, 0.5], 'k--', 'LineWidth', 1); 

box off