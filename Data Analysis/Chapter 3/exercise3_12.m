clc;
close all;
clearvars;

n = 10; % number of X observations
m = 12; % number of Y observations
M = 100; % number of samples
B = 1000; % number of bootstrap samples
alpha = 0.05;

muX = 0;
sigmaX = 1;

muY = 0;
sigmaY = 1;

X = muX + sigmaX * randn(n, M);
Y = muY + sigmaY * randn(m, M);

xbar = mean(X)';
varX = var(X)';
sX_bar = varX / n;

ybar = mean(Y)';
varY = var(Y)';
sY_bar = varY / m;

% floor of this expression to reduce the degrees of freedom and make it
% more strict
df = floor((sX_bar + sY_bar).^2  ./ (((sX_bar).^2 ./(n-1)) + ((sY_bar).^2 ./(m-1))));
t = tinv(1-alpha/2, df);
ci_parametric = zeros(M, 2);
h_parametric = zeros(M, 1);

for i=1:M
    ci_parametric(i, 1) = (xbar(i) - ybar(i)) - sqrt(sX_bar(i) + sY_bar(i)) * t(i);
    ci_parametric(i, 2) = (xbar(i) - ybar(i)) + sqrt(sX_bar(i) + sY_bar(i)) * t(i);

    if ci_parametric(i, 1) <= 0 && ci_parametric(i, 2) >= 0
        h_parametric(i) = 0;
    else
        h_parametric(i) = 1;
    end
end

Z(1:n, :) = X;
Z(n+1:n+m, :)= Y;
zbar = mean(Z)';

X_new = zeros(n, M);
Y_new = zeros(m, M);

for i=1:M
    X_new(:, i) = X(:, i) - xbar(i) + zbar(i);
    Y_new(:, i) = Y(:, i) - ybar(i) + zbar(i);
end

Z_new(1:n, :) = X_new;
Z_new(n+1:n+m, :) = Y_new;

bootstrap_samples_X = zeros(n, M, B);
bootstrap_samples_Y = zeros(m, M, B);

boostrap_means_X = zeros(1, B+1);
boostrap_means_Y = zeros(1, B+1);
h_bootstrap = zeros(1, M);
lower_limit = (B + 1) * alpha * 0.5;
upper_limit = (B + 1) * (1 - alpha / 2);

for i=1:M
    bootstrap_means_X(1, 1) = xbar(i);
    bootstrap_means_Y(1, 1) = ybar(i);
    for j=1:B
        samples = randsample(Z_new(:, i), n+m, true);
        bootstrap_samples_X(:, i, j) = samples(1:n);
        bootstrap_samples_Y(:, i, j) = samples(n+1:n+m);

        bootstrap_means_X(1, j+1) = mean(bootstrap_samples_X(:, i, j));
        bootstrap_means_Y(1, j+1) = mean(bootstrap_samples_Y(:, i, j));
    end
    bootstrap_diff = bootstrap_means_X - bootstrap_means_Y;
    bootstrap_diff = sort(bootstrap_diff);

    r = find(bootstrap_diff == (xbar(i) - ybar(i)));

    if r == (B + 1)
        r = ceil((B+1)/2);
    elseif length(r) >= 2
        r = r(unirnd(length(r)));
    end

    if r >= lower_limit && r <= upper_limit
        h_bootstrap(i) = 0;
    else
        h_bootstrap(i) = 1;
    end
end


prob_parametric = 1 - sum(h_parametric) / M;
prob_bootstrap  = 1 - sum(h_bootstrap) / M;

fprintf("The real mean value is with probability %.2f in the 95%% confidence interval(Parametric)\n", prob_parametric);
fprintf("The real mean value is with probability %.2f in the 95%% confidence interval(Bootstrap)\n", prob_bootstrap);

