clc;
clearvars;
close all;
rng(42)
data = readtable("TMS.xlsx");

mask = (data.TMS == 1);

EDduration = data.EDduration(mask); % y

Setup = data.Setup(mask);
Stimuli = data.Stimuli(mask);
Intensity = data.Intensity(mask);
Spike = data.Spike(mask);
Frequency = data.Frequency(mask);
Coilcode = data.CoilCode(mask);

% To include Spike variable in the analysis we had to get rid of the empty
% values. That meant that a certain amount of information had to also be
% lost.
mask2 = cellfun(@(x) isequal(x, ''), Spike);
mask2 = ~mask2;

Setup = Setup(mask2);
Stimuli = Stimuli(mask2);
Intensity = Intensity(mask2);
Spike = Spike(mask2);
Frequency = Frequency(mask2);
Coilcode = Coilcode(mask2);

EDduration = EDduration(mask2);

% Convert Cell arrays to matlab matrices

Stimuli = str2double(Stimuli);
Intensity = str2double(Intensity);
Spike = str2double(Spike);
Frequency = str2double(Frequency);
Coilcode = str2double(Coilcode);
n = size(Coilcode, 1);

xM = [ones(n, 1) Setup Stimuli Intensity Spike Frequency Coilcode];
X = xM(:, 2:end);
k = size(xM, 2) - 1;

b = regress(EDduration, xM);
y_est = xM * b;

e = EDduration - y_est;
var_e = 1/(n-k-1) * sum(e.^2);
MSE = mean(e.^2);

adjR2 = 1 - (n-1)/(n-k-1)*(sum(e.^2) / sum((EDduration-mean(EDduration)).^2, 1));


% Stepwise Fit

[b_step, s_e, pval, finalmodel, stats] = stepwisefit(X, EDduration);
k1 = sum(finalmodel);
y_estimator_step = stats.intercept + X(:, finalmodel)*b_step(finalmodel);
e_step = EDduration - y_estimator_step;
var_step = 1/(n-k1-1)*sum(e_step.^2);
R2_step = 1 - sum(e_step.^2) / sum((EDduration - mean(y_estimator_step)).^2);
adjR2_step = 1 - (n-1)/(n-k1-1)*(1 - R2_step);

% LASSO
l = 0:0.05:1;
adjR2_lasso = zeros(size(l,1), 1);

j = 1;
% We perform an analysis in order to find the lambda that best fits the
% data with the LASSO model and we choose the LASSO model with the greatest
% adjR2.
for i=0:0.05:1

    [bLASSOv, FitInfo] = lasso(X, EDduration, "CV", 10, "Lambda", i);
    idxMinMSE = FitInfo.IndexMinMSE;
    b0 = FitInfo.Intercept(idxMinMSE);
    bLASSO = bLASSOv(:, idxMinMSE);
    mask3 = (bLASSO ~= 0);
    k2 = sum(mask3);
    
    y_lasso = b0 + X * bLASSO;
    
    e_lasso = EDduration - y_lasso;
    var_lasso = 1/(n-k1-1)*sum(e_lasso.^2);
    R2_lasso = 1 - sum(e_lasso.^2) / sum((EDduration - mean(EDduration)).^2);
    adjR2_lasso(j) = 1 - (n-1)/(n-k2-1)*(1 - R2_lasso);
    j = j + 1;
end

figure();
plot(adjR2_lasso);
ylabel("adjR2");
title("Adjusted R2 coefficient of LASSO for different Lambdas");

[adjR2_LASSO, max_idx] = max(adjR2_lasso);

[bLASSOv, FitInfo] = lasso(X, EDduration, "CV", 10, "Lambda", l(max_idx));
idxMinMSE = FitInfo.IndexMinMSE;
b0 = FitInfo.Intercept(idxMinMSE);
bLASSO = bLASSOv(:, idxMinMSE);
mask3 = (bLASSO ~= 0);
k2 = sum(mask3);
    
y_lasso = b0 + X * bLASSO;
    
e_lasso = EDduration - y_lasso;
var_lasso = 1/(n-k2-1)*sum(e_lasso.^2);

fprintf("Analysis of EDduration with TMS: \n");
fprintf("Variance of Full Model : %.4f \t Variance of Stepwise Model : %.4f \t Variance of LASSO Model : %.4f\n", var_e, var_step, var_lasso);
fprintf("adjR2 of Full Model : %.4f \t adjR2 of Stepwise Model : %.4f \t adjR2 of LASSO Model : %.4f\n", adjR2, adjR2_step, adjR2_LASSO);

figure('Name', 'Diagnostic Plot');
subplot(1, 3, 1);
scatter(EDduration, e/sqrt(var_e));
hold on;
grid on;
title('Diagnostic Plot for Full Model');
yline(2, LineWidth=2,Color='red');
yline(-2, LineWidth=2,Color='red');
xlabel('Estimated y values');
ylabel('e^*');
hold off;

subplot(1, 3, 2);
scatter(EDduration, e_step/sqrt(var_step));
hold on;
grid on;
title('Diagnostic Plot for Stepwise Model');
yline(2, LineWidth=2,Color='red');
yline(-2, LineWidth=2,Color='red');
xlabel('Estimated y values');
ylabel('e^*');
hold off;

subplot(1, 3, 3);
scatter(EDduration, e_lasso/sqrt(var_lasso));
hold on;
grid on;
title('Diagnostic Plot for LASSO Model');
yline(2, LineWidth=2,Color='red');
yline(-2, LineWidth=2,Color='red');
xlabel('Estimated y values');
ylabel('e^*');
hold off;

% From the diagnostic plots for each model we can see that the regression
% depends on another independent variable which means that we need more
% variables for our regression model.

figure();
plot(EDduration, 'blue')
hold on;
plot(y_est, 'red')
hold on;
plot(y_estimator_step, 'green')
hold on;
grid on;
plot(y_lasso, "black")
title("Regression Methods");
xlabel("Index");
ylabel("EDduration");
legend("EDduration", "Full Model", "Stepwise Model", "LASSO Model");
hold off;

% It is clear that the LASSO model outperforms the other two models(Full
% Model and Stepwise Model) since its variance of MSE is lower and its
% adjusted R^2 coefficient is greater than the other two models