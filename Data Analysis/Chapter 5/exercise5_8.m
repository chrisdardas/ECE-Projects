clc;
clearvars;
close all;

T = readtable("physical.txt");
y = T.Mass;
X = [T.Fore T.Bicep T.Chest T.Neck T.Shoulder T.Waist T.Height T.Calf T.Thigh T.Head];
n = size(X, 1);
k = size(X, 2);


% Model with all the parameters
b = regress(y, [ones(n,1) X]);

y_estimator = [ones(n,1) X] * b;
e = y - y_estimator;
se = sqrt((1/(n-k-1))*sum(e.^2, 1));
e_star = e / se;
R2 = 1 - sum(e.^2, 1) / sum((y-mean(y_estimator)).^2, 1);
adjR2 = 1 - (n-1) / (n-k-1) * (sum(e.^2, 1) / sum((y-mean(y_estimator)).^2, 1));

figure('Name', 'Diagnostic Plot');
scatter(y_estimator, e_star);
hold on;
yline(2, LineWidth=2,Color='red');
yline(-2, LineWidth=2,Color='red');
xlabel('Estimated y values');
ylabel('e^*');
txt = sprintf('R^2: %.8f  adjR^2: %.8f', R2, adjR2);
x_pos = min(y_estimator) + 0.1 * range(y_estimator); % Set X position for the text
y_pos = max(e_star) - 0.1 * range(e_star); % Set Y position for the text
text(x_pos, y_pos, txt, 'FontSize', 10, 'Color', 'blue');
hold off;

% Stepwise model

[b_step, s_e, pval, finalmodel, stats, nextstep, history] = stepwisefit(X, y);

y_estimator_step = stats.intercept + X(:,finalmodel) * b_step(finalmodel);
e_step = y - y_estimator_step;
se_step = sqrt((1/(n-k-1))*sum(e_step.^2, 1));
e_star_step = e_step / se_step;
R2_step = 1 - sum(e_step.^2, 1) / sum((y-mean(y_estimator_step)).^2, 1);
adjR2_step = 1 - (n-1) / (n-k-1) * (sum(e_step.^2, 1) / sum((y-mean(y_estimator_step)).^2, 1));

figure('Name', 'Diagnostic Plot');
scatter(y_estimator_step, e_star_step);
hold on;
yline(2, LineWidth=2,Color='red');
yline(-2, LineWidth=2,Color='red');
xlabel('Estimated y values');
ylabel('e^*');
txt = sprintf('R^2: %.8f  adjR^2: %.8f', R2_step, adjR2_step);
x_pos = min(y_estimator_step) + 0.1 * range(y_estimator_step); % Set X position for the text
y_pos = max(e_star_step) - 0.1 * range(e_star_step); % Set Y position for the text
text(x_pos, y_pos, txt, 'FontSize', 10, 'Color', 'blue');
hold off;


