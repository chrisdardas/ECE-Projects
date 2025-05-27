clc;
clearvars;
close all;

T = readtable('hospital.txt');
y = T.ManHours;
X = [T.Cases T.Eligible T.OpRooms];
n = size(X, 1);
k = size(X, 2);

% Full Regression Model
b = regress(y, [ones(n, 1) X]);
y_estimator = [ones(n,1) X] * b;

e = y - y_estimator;
se = sqrt(1/(n-k-1) * sum(e.^2));
e_star = e / se;
R2 = 1 - (sum(e.^2) / sum((y - mean(y_estimator)).^2));
adjR2 = 1 - (n-1)/(n-k-1) * (sum(e.^2) / sum((y - mean(y_estimator)).^2));

figure('Name', 'Diagnostic Plot');
hold on;
grid on;
scatter(y_estimator, e_star);
yline(2, LineWidth=2,Color='red');
yline(-2, LineWidth=2,Color='red');
title('Diagnostic Plot(Full Model)');
xlabel("Estimated y_i values");
ylabel('e_i^*');
txt = sprintf('R^2: %.8f  adjR^2: %.8f', R2, adjR2);
x_limits = xlim();
y_limits = ylim();
x_pos = x_limits(2) - 0.1 * range(x_limits); % Slightly inset from the right
y_pos = y_limits(2) - 0.1 * range(y_limits); % Slightly inset from the top
text(x_pos, y_pos, txt, 'FontSize', 10, 'Color', 'blue', 'HorizontalAlignment', 'right');
hold off;


% Stepwise Model

[b_step, s_e, pval, finalmodel, stats] = stepwisefit(X, y);
% b0 = stats.intercept;
% b_step(~finalmodel) = 0;
% b_step = [b0; b_step];
% yhat = [ones(n,1) X] * b_step;
k1 = sum(finalmodel);
y_estimator_step = stats.intercept + X(:, finalmodel)*b_step(finalmodel);
e_step = y - y_estimator_step;
se_step = sqrt(1/(n-k1-1) * sum(e_step.^2));
e_star_step = e_step / se_step;
R2_step = 1 - sum(e_step.^2, 1) / sum((y-mean(y_estimator_step)).^2, 1);
adjR2_step = 1 - (n-1) / (n-k1-1) * (sum(e_step.^2, 1) / sum((y-mean(y_estimator_step)).^2, 1));

figure('Name', 'Diagnostic Plot');
hold on;
grid on;
scatter(y_estimator_step, e_star_step);
yline(2, LineWidth=2,Color='red');
yline(-2, LineWidth=2,Color='red');
title('Diagnostic Plot(Stepwise Model)');
xlabel("Estimated y_i values");
ylabel('e_i^*');
txt = sprintf('R^2: %.8f  adjR^2: %.8f', R2_step, adjR2_step);
x_limits = xlim();
y_limits = ylim();
x_pos = x_limits(2) - 0.1 * range(x_limits); % Slightly inset from the right
y_pos = y_limits(2) - 0.1 * range(y_limits); % Slightly inset from the top
text(x_pos, y_pos, txt, 'FontSize', 10, 'Color', 'blue', 'HorizontalAlignment', 'right');
hold off;

xM = X(:, finalmodel);
for i=1:k1
    x = xM(:, i);
    b_values = regress(y,[ones(n,1) x]);
    yhatV = [ones(n,1) x] * b_values;
    ehatV = y - yhatV;
    se = sqrt(1/(n-2) * (sum(ehatV.^2)));
    ehat_star = ehatV / se;
    R2_val = 1 - (sum(ehatV.^2) / sum((y-mean(yhatV)).^2));
    adjR2_val = 1 - (n-1)/(n-2) * (sum(ehatV.^2) / sum((y-mean(yhatV)).^2));

    figure();
    nexttile;
    hold on;
    grid on;
    scatter(x, y);
    plot(x, yhatV,'r');
    title('Linear regression ');
    hold off;
    nexttile;
    hold on;
    grid on;
    scatter(yhatV, ehat_star);
    yline(2, LineWidth=2,Color='red');
    yline(-2, LineWidth=2,Color='red');
    title('Diagnostic Plot(Stepwise Model)');
    xlabel("Estimated y_i values");
    ylabel('e_i^*');
    txt = sprintf('R^2: %.8f  adjR^2: %.8f', R2_val, adjR2_val);
    x_limits = xlim();
    y_limits = ylim();
    x_pos = x_limits(2) - 0.1 * range(x_limits); % Slightly inset from the right
    y_pos = y_limits(2) - 0.1 * range(y_limits); % Slightly inset from the top
    text(x_pos, y_pos, txt, 'FontSize', 10, 'Color', 'blue', 'HorizontalAlignment', 'right');
    hold off;
end




