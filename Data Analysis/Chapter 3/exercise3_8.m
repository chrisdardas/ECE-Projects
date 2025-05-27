clc;
close all;
clearvars;

n = 10; % number of observations in a sample
M = 100; % number of samples
B = 1000; % number of bootstrap samples
mu = 0;
sigma = 1;
alpha = 0.05;

%------------------------ Question (a) -------------------------------
X = mu + sigma * randn(n, M);
ci_params = zeros(2, M);
var_values  = var(X)';
x_1 = chi2inv(1-alpha/2, n-1); % For Lower Bound
x_2 = chi2inv(alpha/2, n-1); % For Upper Bound

for i=1:M
    ci_params(1, i) = (n - 1) * var_values(i) / x_1;
    ci_params(2, i) = (n - 1) * var_values(i) / x_2;
end

bootstrap_samples = zeros(n, M, B);
bootstrap_std = zeros(1, M, B);
ci_bootstrap = zeros(2, M);
lower_limit = fix((B + 1) * alpha * 0.5);
upper_limit = B + 1 - lower_limit;

for i=1:M
    for j=1:B
        idx = randi([1, 10], n, 1);
        bootstrap_samples(:, i, j) = X(idx, i);
        bootstrap_std(1, i, j) = std(bootstrap_samples(:, i, j));
    end
    bootstrap_std(1, i, :) = sort(bootstrap_std(1, i, :));
    ci_bootstrap(1, i) = bootstrap_std(:, i, lower_limit);
    ci_bootstrap(2, i) = bootstrap_std(:, i, upper_limit);
end

figure('Name', 'Histogram Of Confidence Intervals(Lower)');
histogram(sqrt(ci_params(1, :)))
hold on;
title('Histogram Of Lower Bound of CI');
xlabel('Lower Values');
ylabel('Count Of Frequencies');
histogram(ci_bootstrap(1, :),FaceColor="red");
legend('CI','Bootstrap CI');
hold off;



figure('Name', 'Histogram Of Confidence Intervals(Upper)');
histogram(sqrt(ci_params(2, :)));
hold on;
title('Histogram Of Upper Bound of CI');
xlabel('Upper Values');
ylabel('Count Of Frequencies');
histogram(ci_bootstrap(2, :),FaceColor='red');
legend('CI','Bootstrap CI');
hold off;

%------------------------ Question (b) -------------------------------

Y = X.^2;
ci_params = zeros(2, M);
std_values  = std(Y)';
var_values  = var(Y)';
x_1 = chi2inv(1-alpha/2, n-1); % For Lower Bound
x_2 = chi2inv(alpha/2, n-1); % For Upper Bound

for i=1:M
    ci_params(1, i) = (n - 1) * var_values(i) / x_1;
    ci_params(2, i) = (n - 1) * var_values(i) / x_2;
end

bootstrap_samples = zeros(n, M, B);
bootstrap_std = zeros(1, M, B);
ci_bootstrap = zeros(2, M);
lower_limit = fix((B + 1) * alpha * 0.5);
upper_limit = B + 1 - lower_limit;

for i=1:M
    for j=1:B
        idx = randi([1, 10], n, 1);
        bootstrap_samples(:, i, j) = Y(idx, i);
        bootstrap_std(1, i, j) = std(bootstrap_samples(:, i, j));
    end
    bootstrap_std(1, i, :) = sort(bootstrap_std(1, i, :), 'ascend');
    ci_bootstrap(1, i) = bootstrap_std(:, i, lower_limit);
    ci_bootstrap(2, i) = bootstrap_std(:, i, upper_limit);
end



figure('Name', 'Histogram Of Confidence Intervals(Lower)');
histogram(sqrt(ci_params(1, :)))
hold on;
title('Histogram Of Lower Bound of CI');
xlabel('Lower Values');
ylabel('Count Of Frequencies');
histogram(ci_bootstrap(1, :),FaceColor="red");
legend('CI','Bootstrap CI');
hold off;



figure('Name', 'Histogram Of Confidence Intervals(Upper)');
histogram(sqrt(ci_params(2, :)));
hold on;
title('Histogram Of Upper Bound of CI');
xlabel('Upper Values');
ylabel('Count Of Frequencies');
histogram(ci_bootstrap(2, :),FaceColor='red');
legend('CI','Bootstrap CI');
hold off;






