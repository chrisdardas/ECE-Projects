clc;
close all;
clearvars;

M = 100; % number of samples 
n = 10; % number of X observations in a sample
m = 12; % number of Y observations in a sample
B = 1000; % number of bootstrap samples
mu = 0; % mean value of the Gaussian
sigma = 1; % standard deviation of the Gaussian
alpha = 0.05;

X = mu + sigma * randn(n, M);
Y = mu + sigma * randn(m, M);

% -------------------- Question (a) -------------------------
% i) Parametric Approach
x_bar = mean(X)';
y_bar = mean(Y)';
varX = var(X)';
varY = var(Y)';

sp_squared = ( (n-1)*varX + (m-1)*varY ) / (n + m - 2);
t = tinv(1 - alpha/2, n+m-2);

ci_parametric(:, 1) = (x_bar - y_bar) - t * sqrt(sp_squared) * sqrt(1/n + 1/m);
ci_parametric(:, 2) = (x_bar - y_bar) + t * sqrt(sp_squared) * sqrt(1/n + 1/m);

% figure('Name','CI Lower Bound(Parametric)');
% histogram(ci_parametric(:, 1));
% title('CI Lower Bound (Parametric)');
% xlabel('Lower Values');
% ylabel('Count of Frequencies');
% 
% figure('Name','CI Upper Bound(Parametric)');
% histogram(ci_parametric(:, 2));
% title('CI Upper Bound (Parametric)');
% xlabel('Upper Values');
% ylabel('Count of Frequencies');

% ii) Bootstrap Approach
bootstrap_samples_X = zeros(n, M, B);
bootstrap_samples_Y = zeros(m, M, B);

bootstrap_mean_X = zeros(1, B);
bootstrap_mean_Y = zeros(1, B);
lower = fix((B + 1) * alpha * 0.5);
upper = B + 1 - lower;

ci_bootstrap = zeros(M, 2);

for i=1:M
    for j=1:B
        idX = randi([1 n], n, 1);
        idY = randi([1 m], m, 1);
        bootstrap_samples_X(:, i, j) = X(idX, i);
        bootstrap_samples_Y(:, i, j) = Y(idY, i);

        bootstrap_mean_X(:, j) = mean(bootstrap_samples_X(:, i, j));
        bootstrap_mean_Y(:, j) = mean(bootstrap_samples_Y(:, i, j));
    end
    bootstrap_diff = bootstrap_mean_X - bootstrap_mean_Y;
    bootstrap_diff = sort(bootstrap_diff);
    ci_bootstrap(i, 1) = bootstrap_diff(1, lower);
    ci_bootstrap(i, 2) = bootstrap_diff(1, upper);
end

parametric_percentage = 0;
bootstrap_percentage = 0;

for i=1:M
    if ( ci_parametric(i, 1) <= 0 && ci_parametric(i, 2) >= 0 ) 
        parametric_percentage = parametric_percentage + 1;
    end

    if ( ci_bootstrap(i, 1) <= 0 && ci_bootstrap(i, 2) >= 0 )
        bootstrap_percentage = bootstrap_percentage + 1;
    end
end
fprintf("Parametric Percentage : %.2f\n", parametric_percentage);
fprintf("Bootstrap Percentage : %.2f\n", bootstrap_percentage);

% figure('Name','CI Lower Bound(Bootstrap)');
% histogram(ci_bootstrap(:, 1));
% title('CI Lower Bound (Bootstrap)');
% xlabel('Lower Values');
% ylabel('Count of Frequencies');
% 
% figure('Name','CI Upper Bound(Bootstrap)');
% histogram(ci_bootstrap(:, 2));
% title('CI Upper Bound (Bootstrap)');
% xlabel('Upper Values');
% ylabel('Count of Frequencies');

figure('Name','CI Lower Bounds')
histogram(ci_parametric(:,1));
hold on;
histogram(ci_bootstrap(:, 1), FaceColor="red");
hold off;
title('Lower Bounds for Mean Value Difference');
xlabel('Mean Value Differences');
ylabel('Count of Frequencies');
legend('Parametric', 'Bootstrap');

figure('Name','CI Upper Bounds')
histogram(ci_parametric(:, 2));
hold on;
histogram(ci_bootstrap(:, 2), FaceColor='red');
hold off;
title('Upper Bounds for Mean Value Difference');
xlabel('Mean Value Differences');
ylabel('Count of Frequencies');
legend('Parametric', 'Bootstrap');


% -------------------- Question (b) -------------------------
X_2 = X.^2;
Y_2 = Y.^2;

xbar = mean(X_2)';
ybar = mean(Y_2)';
var_X = var(X_2)';
var_Y = var(Y_2)';

sp_squared_2 = ((n-1)*var_X + (n-1)*var_Y)  / (n + m - 2);
t_2 = tinv(1-alpha/2, n+n-2);

ci_parametric_2(:, 1) = (xbar - ybar) - t_2 * sqrt(sp_squared_2) * sqrt(1/n + 1/m); 
ci_parametric_2(:, 2) = (xbar - ybar) + t_2 * sqrt(sp_squared_2) * sqrt(1/n + 1/m);

bootstrap_samples_X_2 = zeros(n, M, B);
bootstrap_samples_Y_2 = zeros(m, M, B);

bootstrap_mean_X_2 = zeros(1, B);
bootstrap_mean_Y_2 = zeros(1, B);

bootstrap_diff_2 = zeros(1, B);
ci_bootstrap_2 = zeros(M, 2);

for i=1:M
    for j=1:B
        idX = randi([1, n], n, 1);
        idY = randi([1, m], m, 1);

        bootstrap_samples_X_2(:, i, j) = X_2(idX, i);
        bootstrap_samples_Y_2(:, i, j) = Y_2(idY, i);

        bootstrap_mean_X_2(1, j) = mean(bootstrap_samples_X_2(:, i, j));
        bootstrap_mean_Y_2(1, j) = mean(bootstrap_samples_Y_2(:, i, j));
    end
    bootstrap_diff_2 = bootstrap_mean_X_2 - bootstrap_mean_Y_2;

    bootstrap_diff_2 = sort(bootstrap_diff_2);
    ci_bootstrap_2(i, 1) = bootstrap_diff_2(1, lower);
    ci_bootstrap_2(i, 2) = bootstrap_diff_2(1, upper);
end

parametric_percentage_2 = 0;
bootstrap_percentage_2 = 0;

for i=1:M
    if ( ci_parametric_2(i, 1) <= 0 && ci_parametric_2(i, 2) >= 0 ) 
        parametric_percentage_2 = parametric_percentage_2 + 1;
    end

    if ( ci_bootstrap_2(i, 1) <= 0 && ci_bootstrap_2(i, 2) >= 0 )
        bootstrap_percentage_2 = bootstrap_percentage_2 + 1;
    end
end
fprintf("\nParametric Percentage : %.2f\n", parametric_percentage_2);
fprintf("Bootstrap Percentage : %.2f\n", bootstrap_percentage_2);

figure('Name','CI Lower Bounds (Y = X^2)')
histogram(ci_parametric_2(:,1));
hold on;
histogram(ci_bootstrap_2(:, 1), FaceColor="red");
hold off;
title('Lower Bounds for Mean Value Difference (Y = X^2)');
xlabel('Mean Value Differences');
ylabel('Count of Frequencies');
legend('Parametric', 'Bootstrap');

figure('Name','CI Upper Bounds (Y = X^2)')
histogram(ci_parametric_2(:, 2));
hold on;
histogram(ci_bootstrap_2(:, 2), FaceColor='red');
hold off;
title('Upper Bounds for Mean Value Difference (Y = X^2)');
xlabel('Mean Value Differences');
ylabel('Count of Frequencies');
legend('Parametric', 'Bootstrap');

% -------------------- Question (c) -------------------------
% i) Parametric Approach
mu_y = 0.5;
X_3 = mu + sigma * randn(n, M);
Y_3 = mu_y + sigma * randn(m, M);
x_bar_3 = mean(X_3)';
y_bar_3 = mean(Y_3)';
varX_3 = var(X_3)';
varY_3 = var(Y_3)';

sp_squared = ( (n-1)*varX_3 + (m-1)*varY_3 ) / (n + m - 2);
t = tinv(1 - alpha/2, n+m-2);

ci_parametric_3(:, 1) = (x_bar_3 - y_bar_3) - t * sqrt(sp_squared) * sqrt(1/n + 1/m);
ci_parametric_3(:, 2) = (x_bar_3 - y_bar_3) + t * sqrt(sp_squared) * sqrt(1/n + 1/m);

% ii) Bootstrap Approach
bootstrap_samples_X_3 = zeros(n, M, B);
bootstrap_samples_Y_3 = zeros(m, M, B);

bootstrap_mean_X_3 = zeros(1, B);
bootstrap_mean_Y_3 = zeros(1, B);

ci_bootstrap_3 = zeros(M, 2);

for i=1:M
    for j=1:B
        idX = randi([1 n], n, 1);
        idY = randi([1 m], m, 1);
        bootstrap_samples_X_3(:, i, j) = X_3(idX, i);
        bootstrap_samples_Y_3(:, i, j) = Y_3(idY, i);

        bootstrap_mean_X_3(:, j) = mean(bootstrap_samples_X_3(:, i, j));
        bootstrap_mean_Y_3(:, j) = mean(bootstrap_samples_Y_3(:, i, j));
    end
    bootstrap_diff_3 = bootstrap_mean_X_3 - bootstrap_mean_Y_3;
    bootstrap_diff_3 = sort(bootstrap_diff_3);
    ci_bootstrap_3(i, 1) = bootstrap_diff_3(1, lower);
    ci_bootstrap_3(i, 2) = bootstrap_diff_3(1, upper);
end

parametric_percentage_3 = 0;
bootstrap_percentage_3 = 0;

for i=1:M
    if ( ci_parametric_3(i, 1) <= 0 && ci_parametric_3(i, 2) >= 0 ) 
        parametric_percentage_3 = parametric_percentage_3 + 1;
    end

    if ( ci_bootstrap_3(i, 1) <= 0 && ci_bootstrap_3(i, 2) >= 0 )
        bootstrap_percentage_3 = bootstrap_percentage_3 + 1;
    end
end
fprintf("\nParametric Percentage : %.2f\n", parametric_percentage_3);
fprintf("Bootstrap Percentage : %.2f\n", bootstrap_percentage_3);


figure('Name','CI Lower Bounds (Y~N(0.2, 1))')
histogram(ci_parametric_3(:,1));
hold on;
histogram(ci_bootstrap_3(:, 1), FaceColor="red");
hold off;
title('Lower Bounds for Mean Value Difference(Y~N(0.2, 1))');
xlabel('Mean Value Differences');
ylabel('Count of Frequencies');
legend('Parametric', 'Bootstrap');

figure('Name','CI Upper Bounds')
histogram(ci_parametric_3(:, 2));
hold on;
histogram(ci_bootstrap_3(:, 2), FaceColor='red');
hold off;
title('Upper Bounds for Mean Value Difference(Y~N(0.2, 1))');
xlabel('Mean Value Differences');
ylabel('Count of Frequencies');
legend('Parametric', 'Bootstrap');


% ii) Parametric Approach
mu_y = 0.2;
X_4 = mu + sigma * randn(n, M);
Y_4 = mu_y + sigma * randn(m, M);
x_bar_4 = mean(X_4)';
y_bar_4 = mean(Y_4)';
varX_4 = var(X_4)';
varY_4 = var(Y_4)';

sp_squared = ( (n-1)*varX_4 + (m-1)*varY_4 ) / (n + m - 2);
t = tinv(1 - alpha/2, n+m-2);

ci_parametric_4(:, 1) = (x_bar_4 - y_bar_4) - t * sqrt(sp_squared) * sqrt(1/n + 1/m);
ci_parametric_4(:, 2) = (x_bar_4 - y_bar_4) + t * sqrt(sp_squared) * sqrt(1/n + 1/m);

% ii) Bootstrap Approach
bootstrap_samples_X_4 = zeros(n, M, B);
bootstrap_samples_Y_4 = zeros(m, M, B);

bootstrap_mean_X_4 = zeros(1, B);
bootstrap_mean_Y_4 = zeros(1, B);

ci_bootstrap_4 = zeros(M, 2);

for i=1:M
    for j=1:B
        idX = randi([1 n], n, 1);
        idY = randi([1 m], m, 1);
        bootstrap_samples_X_4(:, i, j) = X_4(idX, i);
        bootstrap_samples_Y_4(:, i, j) = Y_4(idY, i);

        bootstrap_mean_X_4(:, j) = mean(bootstrap_samples_X_4(:, i, j));
        bootstrap_mean_Y_4(:, j) = mean(bootstrap_samples_Y_4(:, i, j));
    end
    bootstrap_diff_4 = bootstrap_mean_X_4 - bootstrap_mean_Y_4;
    bootstrap_diff_4 = sort(bootstrap_diff_4);
    ci_bootstrap_4(i, 1) = bootstrap_diff_4(1, lower);
    ci_bootstrap_4(i, 2) = bootstrap_diff_4(1, upper);
end

parametric_percentage_4 = 0;
bootstrap_percentage_4 = 0;

for i=1:M
    if ( ci_parametric_4(i, 1) <= 0 && ci_parametric_4(i, 2) >= 0 ) 
        parametric_percentage_3 = parametric_percentage_3 + 1;
    end

    if ( ci_bootstrap_4(i, 1) <= 0 && ci_bootstrap_4(i, 2) >= 0 )
        bootstrap_percentage_3 = bootstrap_percentage_3 + 1;
    end
end
fprintf("\nParametric Percentage : %.2f\n", parametric_percentage_4);
fprintf("Bootstrap Percentage : %.2f\n", bootstrap_percentage_4);


figure('Name','CI Lower Bounds (Y~N(0.2, 1))')
histogram(ci_parametric_4(:,1));
hold on;
histogram(ci_bootstrap_4(:, 1), FaceColor="red");
hold off;
title('Lower Bounds for Mean Value Difference(Y~N(0.2, 1))');
xlabel('Mean Value Differences');
ylabel('Count of Frequencies');
legend('Parametric', 'Bootstrap');

figure('Name','CI Upper Bounds')
histogram(ci_parametric_4(:, 2));
hold on;
histogram(ci_bootstrap_4(:, 2), FaceColor='red');
hold off;
title('Upper Bounds for Mean Value Difference(Y~N(0.2, 1))');
xlabel('Mean Value Differences');
ylabel('Count of Frequencies');
legend('Parametric', 'Bootstrap');





