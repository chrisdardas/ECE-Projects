clc;
close all;
clearvars;

n = 10; % number of observations in a sample
M = 100; % number of samples
B = 1000; % number of bootstrap samples
mu = 0;
sigma = 1;
alpha = 0.05;

X = mu + sigma * randn(n, M);
ci_param = zeros(2, M);
mean_values = mean(X, 1)';
std_values = std(X)';
t = tinv(1-alpha/2, n-1); % get the t value for (1-a)% CI with n-1 degrees of freedom

%------------------------ Question (a) -------------------------------
for i=1:M
    ci_param(1, i) = mean_values(i) - t * std_values(i) / sqrt(n);
    ci_param(2, i) = mean_values(i) + t * std_values(i) / sqrt(n);
    % [~, ~, ci_param(:, i)] = ttest(X(:, i), mu,"Alpha",alpha);
end

bootstrap_samples = zeros(n, M, B);
bootstrap_means = zeros(1, M, B);
ci_bootstrap = zeros(2, M);
lower_limit = fix((B + 1) * alpha * 0.5);
upper_limit = B + 1 - lower_limit;

for i=1:M
    for j=1:B
        idx = randi([1, 10], n, 1); % create 10 random indices
        bootstrap_samples(:, i, j) = X(idx, i); % create a bootstrap sample
        bootstrap_means(:, i, j) = mean(bootstrap_samples(:,i,j));
    end
    bootstrap_means(:, i, :)  = sort(bootstrap_means(:, i, :), 'ascend');
    ci_bootstrap(1, i) = bootstrap_means(:, i, lower_limit);
    ci_bootstrap(2, i) = bootstrap_means(:, i, upper_limit);
end



figure('Name', 'Histogram Of Confidence Intervals(Lower)');
histogram(ci_param(1, :))
hold on;
title('Histogram Of Lower Bound of CI');
xlabel('Lower Values');
ylabel('Count Of Frequencies');
histogram(ci_bootstrap(1, :),FaceColor="red")
legend('CI','Bootstrap CI');
hold off;



figure('Name', 'Histogram Of Confidence Intervals(Upper)');
histogram(ci_param(2, :));
hold on;
title('Histogram Of Upper Bound of CI');
xlabel('Upper Values');
ylabel('Count Of Frequencies');
histogram(ci_bootstrap(2, :),FaceColor='red');
legend('CI','Bootstrap CI');
hold off;

%------------------------ Question (b) -------------------------------

Y = X.^2;
ci_param = zeros(2, M);
mean_values = mean(Y, 1)';
std_values = std(Y)';
t = tinv(1-alpha/2, n-1); % get the t value for (1-a)% CI with n-1 degrees of freedom

for i=1:M
    ci_param(1, i) = mean_values(i) - t * std_values(i) / sqrt(n);
    ci_param(2, i) = mean_values(i) + t * std_values(i) / sqrt(n);
    % [~, ~, ci_param(:, i)] = ttest(X(:, i), mu,"Alpha",alpha);
end

bootstrap_samples = zeros(n, M, B);
bootstrap_means = zeros(1, M, B);
ci_bootstrap = zeros(2, M);
lower_limit = fix((B + 1) * alpha * 0.5);
upper_limit = B + 1 - lower_limit;

for i=1:M
    for j=1:B
        idx = randi([1, 10], n, 1); % create 10 random indices
        bootstrap_samples(:, i, j) = Y(idx, i); % create a bootstrap sample
        bootstrap_means(:, i, j) = mean(bootstrap_samples(:,i,j));
    end
    bootstrap_means(:, i, :)  = sort(bootstrap_means(:, i, :), 'ascend');
    ci_bootstrap(1, i) = bootstrap_means(:, i, lower_limit);
    ci_bootstrap(2, i) = bootstrap_means(:, i, upper_limit);
end



figure('Name', 'Histogram Of Confidence Intervals(Lower)');
histogram(ci_param(1, :))
hold on;
title('Histogram Of Lower Bound of CI');
xlabel('Lower Values');
ylabel('Count Of Frequencies');
histogram(ci_bootstrap(1, :),FaceColor="red");
legend('CI','Bootstrap CI');
hold off;



figure('Name', 'Histogram Of Confidence Intervals(Upper)');
histogram(ci_param(2, :));
hold on;
title('Histogram Of Upper Bound of CI');
xlabel('Upper Values');
ylabel('Count Of Frequencies');
histogram(ci_bootstrap(2, :),FaceColor='red');
legend('CI','Bootstrap CI');
hold off;






