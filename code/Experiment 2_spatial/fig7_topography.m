clear

load('./7°.mat');
load('./14°.mat');
load('./21°.mat');
load('./28°.mat');
load('./35°.mat');
load('./42°.mat');
load('./49°.mat');
load('./time.mat');
load('./chanlocs.mat');

durations = [7, 14, 21, 28, 35, 42, 49]; 
num_durations = length(durations);

data_vars = {AL7, AL14, AL21, AL28, AL35, AL42, AL49};

time_windows = {341:353}; 

caxis_range = [-10, 10]; 

figure;

for i = 1:num_durations 
    subplot(1, 7, i); 

    averp_duration = mean(cat(1, data_vars{i}), 1);
    taverp_duration = mean(averp_duration(:, :, time_windows{1}), 3);
    topoplot(taverp_duration, chanlocs, 'style', 'both', 'electrodes', 'on');
    caxis(caxis_range);
    title([num2str(durations(i)), '°'], 'fontsize', 10);
end
