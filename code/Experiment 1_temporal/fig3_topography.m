clear

load('./500.mat');
load('./1000.mat');
load('./1500.mat');
load('./2000.mat');
load('./2500.mat');
load('./3000.mat');
load('./3500.mat');
load('./time.mat');
load('./chanlocs.mat');



durations = [500, 1000, 1500, 2000, 2500, 3000, 3500]; 
num_durations = length(durations);

data_vars = {AD500, AD1000, AD1500, AD2000, AD2500, AD3000, AD3500}; 

time_windows = {357:370}; 

caxis_range = [-5, 5]; 

figure;

for i = 1:num_durations 
    subplot(1, 7, i); 
    averp_duration = mean(cat(1, data_vars{i}), 1);
    taverp_duration = mean(averp_duration(:, :, time_windows{1}), 3); 
    topoplot(taverp_duration, chanlocs, 'style', 'both', 'electrodes', 'on');
    caxis(caxis_range);
    title([num2str(durations(i)), 'ms'], 'fontsize', 10);
end

