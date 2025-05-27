clc;
clearvars;
close all;


% x[n] = h*θ + w[n]
% w --> N(0, σ^2 = 4)
% θ --> Ν(4, σ^2 = 1)
% h = 0.5
% x = H*θ + w


measurments = 50; % measurments
experiments = 500 ;
h = 0.5;

H = h * ones(measurments, 1);

mean_w = 0;
var_w = 4;

mean_theta = 4;
var_theta = 1;

% Normal Distribution ( Correct Prior )
mse_mmse = zeros(measurments, 1);
mse_mle  = zeros(measurments, 1);

for n = 1:measurments
    mmse_errors = zeros(experiments, 1);
    mle_errors  = zeros(experiments, 1);
    
    for i = 1:experiments
        Theta = mean_theta + var_theta * randn();
        W = sqrt(var_w) * randn(n, 1);
        X_MMSE = h * Theta + W;
        X_MLE  = h * mean_theta + W;
        H = h * ones(n, 1);
        Theta_MMSE = mean_theta + var_theta*H'*inv(H*var_theta*H' + var_w * eye(n)) * (X_MMSE - H*mean_theta);
        Theta_MLE  = (1 / (h * n)) * sum(X_MLE);
        mmse_errors(i) = (Theta - Theta_MMSE)^2;
        mle_errors(i)  = (mean_theta - Theta_MLE)^2;
    end
    mse_mmse(n) = mean(mmse_errors);
    mse_mle(n)  = mean(mle_errors);
end

%2.3 sxediasmos toy mse kai gia tous 2 ektimites(MMSE, MLE)

%MMSE
nexttile
plot(1:measurments, mse_mmse, '-o')
xlabel('Number of Measurments')
ylabel('MSE')
title('MSE of MMSE (Gaussian Prior) ')
grid on
nexttile

%MLE
plot(1:measurments, mse_mle, 'r-o')
xlabel('Number of Measurments')
ylabel('MSE')
title('MSE of MLE')
grid on
figure();

% ======================================================================================
%2.4 ekteloume pali ta parapano gia ton MMSE antlontas tis times toy θ apo 
% Exponential Distribution

mse_mmse = zeros(measurments, 1);
for n = 1:measurments
    mmse_errors = zeros(experiments, 1);
    for i = 1:experiments
        Theta = exprnd(mean_theta); 
        X_MMSE = h * Theta + sqrt(var_w) * randn (n, 1);
        H = h * ones(n, 1);
        Theta_MMSE = mean_theta + var_theta*H'*inv(H*var_theta*H' + var_w * eye(n)) * (X_MMSE - H*mean_theta);
        mmse_errors(i) = (Theta - Theta_MMSE)^2;
    end
    mse_mmse(n) = mean(mmse_errors);
end

plot(mse_mmse, '-o')
xlabel('Number of Measurments')
ylabel('MSE')
title('MSE of MMSE (Exponential Prior) ')
grid on

figure()

%2.4 ekteloume pali ta parapano gia ton MMSE antlontas tis times toy θ apo
% Uniform Distribution
a = 0;%mean_theta - sqrt(3 * var_theta);
b = 8;%mean_theta + sqrt(3 * var_theta);


mse_mmse = zeros(measurments, 1);
for n = 1:measurments
    mmse_errors = zeros(experiments, 1);

    for i = 1:experiments
        Theta =  a + (b-a)*rand;
        X_MMSE = h * Theta + sqrt(var_w) * randn (n, 1);
        H = h * ones(n, 1);
        Theta_MMSE = mean_theta + var_theta*H'*inv(H*var_theta*H' + var_w * eye(n)) * (X_MMSE - H*mean_theta);
        mmse_errors(i) = (Theta - Theta_MMSE)^2;
    end
    mse_mmse(n) = mean(mmse_errors);
end

plot(mse_mmse, '-o')
xlabel('Number of Measurments')
ylabel('MSE')
title('MSE of MMSE (Uniform Prior)')
grid on
