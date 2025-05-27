clc;
close all;
clearvars;

% -------------------- Question (a) -------------------------

n = 10; % number of observations in a sample
M = 100; % number of samples
B = 1000; % number of Bootstrap samples

mu = 0;
mu_array = [0 0.5];
sigma = 1;
alpha = 0.05;

X = mu + sigma * randn(n, M);
x_bar = mean(X)';
lower_limit = (B + 1) * alpha * 0.5;
upper_limit = (B + 1) * (1 - alpha / 2);

X_new_1 = zeros(n, M);
X_new_2 = zeros(n, M);


for i=1:M
    X_new_1(:, i) = X(:, i) - x_bar(i) + mu_array(1);
    X_new_2(:, i) = X(:, i) - x_bar(i) + mu_array(2);
end


[h_values_1, p_values_1] = ttest(X, mu_array(1), "Alpha", alpha);
[h_values_2, p_values_2] = ttest(X, mu_array(2), "Alpha", alpha);

prob_1 = 1 - sum(h_values_1, 2) / M;
prob_2 = 1 - sum(h_values_2, 2) / M;

fprintf("The real mean value is with probability %.2f in the 95%% confidence interval\n", prob_1);
fprintf("The real mean value is with probability %.2f in the 95%% confidence interval\n", prob_2);

bootstrap_samples_1 = zeros(n, M, B);
bootstrap_samples_2 = zeros(n, M, B);

bootstrap_means_1 = zeros(1, B+1);
bootstrap_means_2 = zeros(1, B+1);

p_values_bootstrap_1 = zeros(M, 1);
p_values_bootstrap_2 = zeros(M, 1);

p_values_bootstrap_1_second = zeros(M, 1);
p_values_bootstrap_2_second = zeros(M, 1);

h_values_bootstrap_1 = zeros(M, 1);
h_values_bootstrap_2 = zeros(M, 1);

for i=1:M
    bootstrap_means_1(1, 1) = x_bar(i);
    bootstrap_means_2(1, 1) = x_bar(i);
    for j=1:B
        idX_1 = randi([1, n], n, 1);
        idX_2 = randi([1, n], n, 1);

        bootstrap_samples_1(:, i, j) = X_new_1(idX_1, i);
        bootstrap_samples_2(:, i, j) = X_new_2(idX_2, i);

        bootstrap_means_1(1, j+1) = mean(bootstrap_samples_1(:, i, j));
        bootstrap_means_2(1, j+1) = mean(bootstrap_samples_2(:, i, j));
    end

    bootstrap_means_1 = sort(bootstrap_means_1);
    bootstrap_means_2 = sort(bootstrap_means_2);

    r1 = find(bootstrap_means_1 == x_bar(i));
    r2 = find(bootstrap_means_2 == x_bar(i));

    p_values_bootstrap_1(i, 1) = (sum(abs(bootstrap_means_1 - mu_array(1)) >= abs(x_bar(i) - mu_array(1))) / (B + 1)); 
    p_values_bootstrap_2(i, 1) = (sum(abs(bootstrap_means_1 - mu_array(2)) >= abs(x_bar(i) - mu_array(2))) / (B + 1));

    if r1 == (B+1)
        r1 = ceil((B+1)/2);
    elseif length(r1) >= 2
        r1 = r1(unirnd(length(r1)));
    end

    if r1 > 0.5 * (B+1)
        p_values_bootstrap_1_second(i, 1) = 2*(1 - r1 / (B+1));
    else
        p_values_bootstrap_1_second(i, 1) = 2 * r1 / (B + 1);
    end

    if r2 > 0.5 * (B + 1)
        p_values_bootstrap_2_second(i, 1) = 2 * (1 - r2 / (B + 1));
    else
        p_values_bootstrap_2_second(i, 1) = 2 * r2/(B+1);
    end

    if r2 == (B+1)
        r2 = ceil((B+1)/2);
    elseif length(r2) >= 2
        r2 = r2(unirnd(length(r2)));
    end

    if r1 >= lower_limit && r1 <= upper_limit
        h_values_bootstrap_1(i, 1) = 0;
    else
        h_values_bootstrap_1(i, 1) = 1;
    end

    if r2 >= lower_limit && r2 <= upper_limit
        h_values_bootstrap_2(i, 1) = 0;
    else
        h_values_bootstrap_2(i, 1) = 1;
    end

end


prob_bootstrap_1 = 1 - sum(h_values_bootstrap_1, 1) / M;
prob_bootstrap_2 = 1 - sum(h_values_bootstrap_2, 1) / M;

fprintf("\nThe real mean value is with probability %.2f in the 95%% confidence interval(Bootstrap)\n", prob_bootstrap_1);
fprintf("The real mean value is with probability %.2f in the 95%% confidence interval(Bootstrap)\n", prob_bootstrap_2);

% -------------------- Question (b) -------------------------
mu_array_new = [2 5]; % since X~N(1,1) and X~N(2,1) the mean values for Y
% should be E[X^2] = 2 and E[X^2] = 5 respectively
Y = X.^2;
y_bar = mean(Y)';
Y_new_1 = zeros(n, M);
Y_new_2 = zeros(n, M);


for i=1:M
    Y_new_1(:, i) = Y(:, i) - y_bar(i) + mu_array_new(1);
    Y_new_2(:, i) = Y(:, i) - y_bar(i) + mu_array_new(2);
end


[h_values_1_y, p_values_1_y] = ttest(Y, mu_array_new(1), "Alpha", alpha);
[h_values_2_y, p_values_2_y] = ttest(Y, mu_array_new(2), "Alpha", alpha);

prob_1 = 1 - sum(h_values_1_y, 2) / M;
prob_2 = 1 - sum(h_values_2_y, 2) / M;

fprintf("\nThe real mean value is with probability %.2f in the 95%% confidence interval\n", prob_1);
fprintf("The real mean value is with probability %.2f in the 95%% confidence interval\n", prob_2);

bootstrap_samples_1 = zeros(n, M, B);
bootstrap_samples_2 = zeros(n, M, B);

bootstrap_means_1 = zeros(1, B+1);
bootstrap_means_2 = zeros(1, B+1);

p_values_bootstrap_1 = zeros(M, 1);
p_values_bootstrap_2 = zeros(M, 1);

h_values_bootstrap_1 = zeros(M, 1);
h_values_bootstrap_2 = zeros(M, 1);

for i=1:M
    bootstrap_means_1(1, 1) = y_bar(i);
    bootstrap_means_2(1, 1) = y_bar(i);
    for j=1:B
        idY_1 = randi([1, n], n, 1);
        idY_2 = randi([1, n], n, 1);

        bootstrap_samples_1(:, i, j) = Y_new_1(idY_1, i);
        bootstrap_samples_2(:, i, j) = Y_new_2(idY_2, i);

        bootstrap_means_1(1, j+1) = mean(bootstrap_samples_1(:, i, j));
        bootstrap_means_2(1, j+1) = mean(bootstrap_samples_2(:, i, j));
    end

    bootstrap_means_1 = sort(bootstrap_means_1);
    bootstrap_means_2 = sort(bootstrap_means_2);

    r1 = find(bootstrap_means_1 == y_bar(i));
    r2 = find(bootstrap_means_2 == y_bar(i));

    p_values_bootstrap_1(i, 1) = (sum(abs(bootstrap_means_1 - mu_array_new(1)) >= abs(y_bar(i) - mu_array_new(1))) / (B + 1)); 
    p_values_bootstrap_2(i, 1) = (sum(abs(bootstrap_means_1 - mu_array_new(2)) >= abs(y_bar(i) - mu_array_new(2))) / (B + 1));

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

    if r1 > 0.5 * (B+1)
        p_values_bootstrap_1_second(i, 1) = 2*(1 - r1 / (B+1));
    else
        p_values_bootstrap_1_second(i, 1) = 2 * r1 / (B + 1);
    end

    if r2 > 0.5 * (B + 1)
        p_values_bootstrap_2_second(i, 1) = 2 * (1 - r2 / (B + 1));
    else
        p_values_bootstrap_2_second(i, 1) = 2 * r2/(B+1);
    end

    if r1 >= lower_limit && r1 <= upper_limit
        h_values_bootstrap_1(i, 1) = 0;
    else
        h_values_bootstrap_1(i, 1) = 1;
    end

    if r2 >= lower_limit && r2 <= upper_limit
        h_values_bootstrap_2(i, 1) = 0;
    else
        h_values_bootstrap_2(i, 1) = 1;
    end

end


prob_bootstrap_1 = 1 - sum(h_values_bootstrap_1, 1) / M;
prob_bootstrap_2 = 1 - sum(h_values_bootstrap_2, 1) / M;

fprintf("\nThe real mean value is with probability %.2f in the 95%% confidence interval(Bootstrap)\n", prob_bootstrap_1);
fprintf("The real mean value is with probability %.2f in the 95%% confidence interval(Bootstrap)\n", prob_bootstrap_2);

