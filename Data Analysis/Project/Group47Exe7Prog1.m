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

% We created our own dataset train-test split function
[X_train, X_test, y_train, y_test] = Group47Exe7Func1(X, EDduration, 0.2);
train_size = size(X_train, 1);
test_size = size(X_test, 1);

% Full model

b = regress(y_train, [ones(train_size, 1) X_train]);

y_full_test = [ones(test_size, 1) X_test] * b;

e = y_test - y_full_test;

MSE_full = mean(e.^2);

% Stepwise model
% We keep only the 1st and 4th column as a result of the previous exercise
X_train_step = [X_train(:, 1) X_train(:, 4)];
X_test_step  = [X_test(:, 1) X_test(:, 4)];
b_step = regress(y_train, [ones(train_size, 1) X_train_step]);

y_step = [ones(test_size,1) X_test_step] * b_step;


e_step = y_test - y_step;

MSE_step = mean(e_step.^2);


% LASSO model
% We keep all the columns except column 3 as result of the previous
% exercise
X_train_LASSO = [X_train(:, 1) X_train(:, 2) X_train(:, 4) X_train(:, 5)];
X_test_LASSO  = [X_test(:, 1) X_test(:, 2) X_test(:, 4) X_test(:, 5)];
lambda = 0.05;

[bLASSOv, FitInfo] = lasso(X_train_LASSO, y_train, "CV", 10, "Lambda",lambda);
idxMinMSE = FitInfo.IndexMinMSE;
b0_lasso = FitInfo.Intercept(idxMinMSE);
bLASSO = bLASSOv(:, idxMinMSE);

y_LASSO = b0_lasso + X_test_LASSO * bLASSO;

eLASSO = y_test - y_LASSO;

MSE_LASSO = mean(eLASSO.^2);

fprintf("MSE Full Model: %.4f \t MSE Stepwise Model: %.4f \t MSE LASSO Model: %.4f\n", MSE_full, MSE_step, MSE_LASSO);

% We can see that the stepwise model outperforms the other two which is
% expected since the stepwise model is prone to overfitting the data.
% When we use a train subset of the dataset the overfitting is reduced.


