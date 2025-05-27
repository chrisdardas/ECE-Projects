clc;
clearvars;
close all;


rng(42);
data = readtable("TMS.xlsx");

mask = (data.TMS == 1);

EDduration = data.EDduration(mask); % y

Setup = data.Setup(mask);
Stimuli = data.Stimuli(mask);
Intensity = data.Intensity(mask);
Frequency = data.Frequency(mask);
Coilcode = data.CoilCode(mask);

Stimuli = str2double(Stimuli);
Intensity = str2double(Intensity);
Frequency = str2double(Frequency);
Coilcode = str2double(Coilcode);
n = size(Coilcode, 1);

xM = [ones(n, 1) Setup Stimuli Intensity Frequency Coilcode];
X = xM(:, 2:end);

[X_train, X_test, y_train, y_test] = Group47Exe7Func1(X, EDduration, 0.2);
train_size = size(X_train, 1);
test_size = size(X_test, 1);

% Stepwise Fit

[b_step, s_e, pval, finalmodel, stats] = stepwisefit(X_train, y_train);
y_step = stats.intercept + X_test(:, finalmodel) * b_step(finalmodel);

e_step = y_test - y_step;
k1 = sum(finalmodel);
MSE_step = mean(e_step.^2);
var_step = 1/(n-k1-1)*sum(e_step.^2);
R2_step = 1 - (sum(e_step.^2) / sum((y_test - mean(y_test)).^2));
adjR2_step = 1 - (n-1)/(n-k1-1)*(1 - R2_step);


% LASSO fit
l = 0:0.05:1;
adjR2_lasso = zeros(size(l,1), 1);
figure();
j = 1;
for i=0:0.05:1

    [bLASSOv, FitInfo] = lasso(X_train, y_train, "CV", 10, "Lambda", i);
    idxMinMSE = FitInfo.IndexMinMSE;
    b0 = FitInfo.Intercept(idxMinMSE);
    bLASSO = bLASSOv(:, idxMinMSE);
    mask3 = (bLASSO ~= 0);
    k2 = sum(mask3);
    
    y_lasso = b0 + X_train * bLASSO;
    
    e_lasso = y_train - y_lasso;
    var_lasso = 1/(n-k2-1)*sum(e_lasso.^2);
    R2_lasso = 1 - sum(e_lasso.^2) / sum((y_train - mean(y_train)).^2);
    adjR2_lasso(j) = 1 - (n-1)/(n-k2-1)*(1 - R2_lasso);
    j = j + 1;
end
figure();
plot(adjR2_lasso);
title("Values of adjR^2 in training");
xlabel("Index");
ylabel("adjR^2");

[~, max_idx] = max(adjR2_lasso);
lambda = l(max_idx);

[bLASSOv, FitInfo] = lasso(X_train, y_train, "CV", 10, "Lambda", l(max_idx));
idxMinMSE = FitInfo.IndexMinMSE;
b0 = FitInfo.Intercept(idxMinMSE);
bLASSO = bLASSOv(:, idxMinMSE);
mask3 = (bLASSO ~= 0);
k2 = sum(mask3);
    
y_lasso = b0 + X_test * bLASSO;

e_lasso = y_test - y_lasso;
R2_lasso = 1 - sum(e_lasso.^2) / sum((y_test - mean(y_test)).^2);
adjR2_LASSO = 1 - (n-1)/(n-k2-1)*(1 - R2_lasso);

MSE_lasso = mean(e_lasso.^2);

fprintf("MSE Stepwise Model: %.4f \t MSE LASSO Model: %.4f\n", MSE_step, MSE_lasso);
fprintf("adjR2 Stepwise Model : %.4f \t adjR2 LASSO Model : %.4f\n", adjR2_step, adjR2_LASSO);

% We can conclude that the LASSO model is  better than the
% stepwise model when we use the train dataset to fit both the models.
% This result is expected since the stepwise regression is prone to
% overfitting and therefore its performance is worse than the performance
% of the LASSO model which is more robust and generalizes better.