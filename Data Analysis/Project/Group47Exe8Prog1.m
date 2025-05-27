clc;
clearvars;
close all;

data = readtable("TMS.xlsx");

mask = (data.TMS == 1);

EDduration = data.EDduration(mask); % y

Setup = data.Setup(mask);
Stimuli = data.Stimuli(mask);
Intensity = data.Intensity(mask);
Frequency = data.Frequency(mask);
Coilcode = data.CoilCode(mask);
preTMS = data.preTMS(mask);
postTMS = data.postTMS(mask);

Stimuli = str2double(Stimuli);
Intensity = str2double(Intensity);
Frequency = str2double(Frequency);
Coilcode = str2double(Coilcode);
n = size(Coilcode, 1);

xM = [ones(n, 1) Setup Stimuli Intensity Frequency Coilcode preTMS];
X = xM(:, 2:end);
k = size(xM, 2) - 1;

b = regress(EDduration, xM);
y_est = xM * b;

e = EDduration - y_est;
var_e = 1/(n-k-1) * sum(e.^2);
MSE = sqrt(sum(e.^2));

adjR2 = 1 - (n-1)/(n-k-1)*(sum(e.^2) / sum((EDduration-mean(EDduration)).^2, 1));


% Stepwise Fit

[b_step, s_e, pval, finalmodel, stats] = stepwisefit(X, EDduration);
k1 = sum(finalmodel);
y_estimator_step = stats.intercept + X(:, finalmodel)*b_step(finalmodel);
e_step = EDduration - y_estimator_step;
var_step = 1/(n-k1-1)*sum(e_step.^2);
R2_step = 1 - sum(e_step.^2) / sum((EDduration - mean(EDduration)).^2);
adjR2_step = 1 - (n-1)/(n-k1-1)*(1 - R2_step);

% LASSO
l = 0:0.05:1;
adjR2_lasso = zeros(size(l,1), 1);
j = 1;
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
title("Values of adjR^2 in training");
xlabel("Index");
ylabel("adjR^2");

[adjR2_LASSO, max_idx] = max(adjR2_lasso);

[bLASSOv, FitInfo] = lasso(X, EDduration, "CV", 10, "Lambda", l(max_idx));
idxMinMSE = FitInfo.IndexMinMSE;
b0 = FitInfo.Intercept(idxMinMSE);
bLASSO = bLASSOv(:, idxMinMSE);
mask3 = (bLASSO ~= 0);
k2 = sum(mask3);
    
y_lasso = b0 + X * bLASSO;
    
e_lasso = EDduration - y_lasso;
var_lasso = 1/(n-k1-1)*sum(e_lasso.^2);



% PCR regression
X_center = X - repmat(mean(X), n, 1);
yc = EDduration - mean(EDduration);
[U, S, V] = svd(X_center, "econ");

eigenvalues = diag(S).^2/(n-1);
var_perc = 100 * cumsum(eigenvalues) / sum(eigenvalues);
figure("Name", "Expected Variance Percentage");
plot(1:size(eigenvalues), var_perc, 'r');
title("Explained Variance Percentage");
grid on;
xlabel("Index");
ylabel("Variance Percentage");

d = find(var_perc >= 90, 1); % Keep the 90 percent of variance
vector = zeros(size(X, 2), 1);
vector(1:d) = 1;

b_PCR = V * diag(vector) * inv(S) * U' * yc;
b_PCR = [mean(EDduration) - mean(X) * b_PCR; b_PCR];
yPCR = xM * b_PCR;

e_PCR = EDduration - yPCR;
R2_PCR = 1 - sum(e_PCR.^2) / sum((EDduration - mean(EDduration)).^2);
adjR2_PCR = 1 - (n-1)/(n-d-1)*(1 - R2_PCR);

fprintf("adjR2 Full Model : %.4f \t adjR2 Stepwise Model : %.4f \t adjR2 LASSO Model : %.4f \t adjR2 PCR Model: %.4f\n", adjR2, adjR2_step, adjR2_LASSO, adjR2_PCR);


figure();
plot(EDduration, 'blue')
hold on;
plot(y_est, 'red')
hold on;
plot(y_estimator_step, 'green')
hold on;
plot(y_lasso, "black")
hold on;
grid on;
plot(yPCR, "cyan")
legend('EDduration', 'Full', "Step", "LASSO", "PCR");
title("Regression Methods");
xlabel("Index");
ylabel("EDduration");
legend("EDduration", "Full Model", "Stepwise Model", "LASSO Model");
hold off;


% We see that the 3 models give better results in the metric of adjR2 in
% comparison to the exercise 6. Therefore, we can say that the variable
% preTMS improves the fit of our regression model. In other words
% EDduration is somewhat correlated with the preTMS variable. However, in
% the case of the PCR model we choose to keep we chose to keep 90% of the
% variance information. Judging by its adjR2 metric it performs much worse
% than the rest of the models.