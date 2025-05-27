clc;
close all;
clearvars;

n = 10; % number of X observations
m = 12; % number of Y observations
M = 100; % number of samples
B = 1000; % number of bootstrap samples
mu = 0;
sigma = 1;
alpha = 0.05;

X = mu + sigma*randn(n, M);
Y = mu + sigma*randn(m, M);

xbar = mean(X)';
ybar = mean(Y)';

lower_limit = (B + 1) * alpha * 0.5;
upper_limit = (B + 1) * (1 - alpha/2);

Z(1:n, :) = X;
Z(n+1:n+m, :) = Y;

[h_values, p_values] = ttest2(X, Y,"Alpha",alpha); % performs the ttest on the 
% hypothesis of equal mean values 

bootstrap_samples = zeros(n+m, M, B);
permutation_samples = zeros(n+m, M, B);
bootstrap_means = zeros(1, B+1);
permutation_means = zeros(1, B+1);
h_permute = zeros(M, 1);
h_bootstrap = zeros(M, 1);

for i=1:M
    bootstrap_means(1,1) = xbar(i) - ybar(i);
    permutation_means(1, 1) = xbar(i) - ybar(i);
    for j=1:B
        permutation_samples(:, i, j) = randsample(Z(:,i), n+m, false); % without replacement
        bootstrap_samples(:, i, j) = randsample(Z(:, i), n+m, true); % with replacement

        permutation_means(1, j+1) = mean(permutation_samples(1:n, i, j)) - mean(permutation_samples(n+1:n+m, i, j));
        bootstrap_means(1, j+1) = mean(bootstrap_samples(1:n, i, j)) - mean(bootstrap_samples(n+1:n+m, i, j));
    end

    permutation_means = sort(permutation_means, 2);
    bootstrap_means = sort(bootstrap_means, 2);

    r1 = find(permutation_means == (xbar(i) -ybar(i)));
    r2 = find(bootstrap_means == (xbar(i) -ybar(i)));

    if r1 == (B+1)
        r1 = ceil((B+1)/2);
    elseif length(r1) >= 2
        r1 = r1(unirnd(length(r1)));
    end

    if r2 == (B+1)
        r2 = ceil((B+1)/2);
    elseif length(r2) >= 2
        r2 = r2(unirnd(length(r2)));
    end

    if r1 >= lower_limit && r1 <= upper_limit
        h_permute(i,1) = 0;
    else
        h_permute(i,1) = 1;
    end

    if r2 >= lower_limit && r2 <= upper_limit
        h_bootstrap(i,1) = 0;
    else
        h_bootstrap(i,1) = 1;
    end
end

prob_parametric  = 1 - sum(h_values, 2) / M;
prob_bootstrap   = 1 - sum(h_bootstrap, 1) / M;
prob_permutation = 1 - sum(h_permute, 1) / M;

fprintf("The real mean value is with probability %.2f in the 95%% confidence interval(Parametric)\n", prob_parametric);
fprintf("The real mean value is with probability %.2f in the 95%% confidence interval(Bootstrap)\n", prob_bootstrap);
fprintf("The real mean value is with probability %.2f in the 95%% confidence interval(Permutation)\n", prob_permutation);










