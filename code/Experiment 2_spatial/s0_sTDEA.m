% Constants
fs       = 0.0005;
n_trials = 10000;
min_dur  = 7;
max_dur  = 49;
thr      = 28;
noise    = 0.2;
rate     = 1;
ac_ticks = [0, 1];
x_fac    = 0.03;
yx_fac   = 0.8333;
y_fac    = x_fac / yx_fac;
F_WIDTH  = 17.4;
F_HEIGHT = 17.4;
T_SIZE   = 10;
A_SIZE   = 10;
tr_color = [255, 179, 128] / 255;
FIG_DIR  = fullfile('/mnt', 'DataAyeletNew', 'Experiments', 'Temporal Bisection', 'Figures');

% Simulate clock traces
[t, traces] = simulate_trace(rate, noise, n_trials, max_dur, fs);

% Threshold traces
thr_hit = traces >= thr;
truncated_traces = traces;
for i = 1:n_trials
        ind = find(thr_hit(i, :), 1, 'first');
    if ~isempty(ind)
        thr_hit(i, ind:end) = 1;
    end
end
truncated_traces(thr_hit) = thr;
diff_traces = thr - truncated_traces;
toi = t >= min_dur;

% Calculate neurometric curve
erp = mean(diff_traces);

% Choose trace to plot - One that crosses the thr at the expected time
thr_time = round((thr / rate) / fs);
[~, ind] = min(abs(traces(:, thr_time) - thr));
trace    = traces(ind, :);

% Prepare figure
fig = figure('Units', 'centimeters', 'Position', [0, 0, F_WIDTH, F_HEIGHT], 'DefaultTextFontSize', T_SIZE, 'DefaultAxesFontSize', A_SIZE, 'DefaultLineLineWidth', 1.5);
ax_dist = axes(fig, 'OuterPosition', [0.025, 0.5, 0.55, 0.5]);
ax_erp  = axes(fig, 'OuterPosition', [0.625, 0.5, 0.375, 0.5]);
ax_pf   = axes(fig, 'OuterPosition', [0.625, 0  , 0.375, 0.5]);

% Plot 1: Threshold distance distributions
dur = linspace(min_dur, 1.6, 4);
erps = thr - erp(ismembertol(t, dur, mean(diff(t))/5));
plot_distribs(t, dur, sqrt(dur) * noise, dur, thr, erps, trace, tr_color, ax_dist)
yticks(ax_dist, ac_ticks);

% Plot 2: ERP function
plot(ax_erp, t(toi), erp(toi), 'LineWidth', 2);
xlabel(ax_erp, 'Stimulus duration (s)');
ylabel(ax_erp, 'ERP (AU)');
ax_erp.Box = 'off';
xl = [min_dur, max_dur];
yl = [0, max(erp(toi))];
xlim(ax_erp, xl + range(xl)*[-x_fac, x_fac]);
ylim(ax_erp, yl + range(yl)*[-y_fac, y_fac]);

% Plot 3 bottom: Accumulator mean and variability
pos    = ax_dist.Position;
pos(2) = pos(2) - ax_dist.OuterPosition(2);
pos(4) = pos(4) / 2;
ax_acc = axes(fig, 'Position', pos);
mean_trace = mean(traces);
thr_ind    = mean_trace <= thr;
mean_sub   = mean_trace(thr_ind);
t_sub      = t(thr_ind);
er_up = icdf('InverseGaussian', 0.975, t_sub(2:end), (t_sub(2:end)/noise).^2);
er_dn = icdf('InverseGaussian', 0.025, t_sub(2:end), (t_sub(2:end)/noise).^2);
hold(ax_acc, 'on');
plot(ax_acc, t_sub, mean_sub, 'Color', 'b');
patch(ax_acc, [er_up, fliplr(er_dn)], [t_sub(2:end), fliplr(t_sub(2:end))], 'b', 'EdgeColor' ,'none', 'FaceAlpha', 0.3);
xlim(ax_acc, [0, max_dur]);
ylim(ax_acc, [0, thr]);
yticks(ax_acc, ac_ticks);
xlabel(ax_acc, 'Time (s)');
ylabel(ax_acc, {'Evidence', '(AU)'});

% Plot 3 top: Threshold crossing times
pos = ax_acc.Position; pos(2) = pos(2) + pos(4);
ax_invg = axes(fig, 'Position', pos);
hold(ax_invg, 'on');
y = pdf('InverseGaussian', t, thr, (thr/noise)^2);
plot(ax_invg, t, y, 'r');
ax_invg.Box = 'off';
ax_invg.XAxis.Color = 'none';
line(ax_invg, [t(1), t(end)], [0, 0], 'color', 'k', 'LineWidth', 2);
xlim(ax_invg, [0, max_dur]);
yticks(ax_invg, [1, 2]);
ylabel(ax_invg, {'Probability', 'to reach', 'threshold'});

% Plot 4: Psychometric function
plot(ax_pf, t(toi), cdf('InverseGaussian', t(toi), thr, (thr/noise)^2));
xlabel(ax_pf, 'Stimulus duration (s)');
ylabel(ax_pf, 'P("long")');
ax_pf.Box = 'off';
xl = [min_dur, max_dur];
yl = [0, 1];
xlim(ax_pf, xl + range(xl)*[-x_fac, x_fac]);
ylim(ax_pf, yl + range(yl)*[-y_fac, y_fac]);


% set(findobj(ax, 'Type', 'Line'), 'LineWidth', 2)

filename = fullfile(FIG_DIR, 'model figure.svg');
print_figure(fig, [], filename);
%%

function [t, traces] = simulate_trace(rate, c, n_trials, dur, fs)

t  = 0:fs:dur;
n_samples = length(t);

% DDM implementation
traces = zeros(n_trials, n_samples);
for i = 2:n_samples
    traces(:, i) = traces(:, i-1) + rate*fs + normrnd(0, c*sqrt(fs), n_trials, 1);
end

end

function plot_distribs(t, mu, sigma, dur, thr, erps, trace, tr_color, ax)
hold(ax, 'on');

% Add trace
plot(ax, t, trace, 'Color', tr_color);

thr_ind = t >= thr;
t_lo    = [t(1), t(~thr_ind), t(find(~thr_ind, 1, 'last'))];

for i = 1:length(dur)
    pdf_tmp = normpdf(t, mu(i), sigma(i)) / 8;
    
    y_tmp = [0, pdf_tmp(~thr_ind), 0] + dur(i);
    patch(ax, y_tmp, t_lo, 'b', 'EdgeColor' ,'none', 'FaceAlpha', 0.3);
    line(ax, [dur(i), dur(i)], [erps(i), thr], 'Color', 'r');
end

xlabel(ax, 'Time (s)');
ylabel(ax, 'Accumulated evidence (AU)');
axis(ax, [0, max(t), 0, 2.5]);
line(ax, ax.XLim, [thr, thr], 'Color', 'k')

end