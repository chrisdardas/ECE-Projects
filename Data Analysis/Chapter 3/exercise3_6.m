clc;
close all;
clearvars;

mu = 0;
sigma = 1;
n = 10; % sample of n observations
B = 1000; % number of bootstrap samples consisting of n observations
X = mu + sigma * randn(n, 1);
mean_value = mean(X);

bootstrap_samples = zeros(n, B);
bootstrap_means = zeros(1, B);
%------------------------ Question (a) -------------------------------
for i=1:B
    idx = randi([1, 10], n, 1); % create 10 random indices 
    bootstrap_samples(:,i) = X(idx); % get the bootstrap observations 
    bootstrap_means(:,i) = mean(bootstrap_samples(:,i)); % calculate the mean values for every bootstrap sample
end

figure('Name', 'Bootstrap Histogram')
histogram(bootstrap_means');
hold on;
xline(mean_value,  Label='Mean Value', LineWidth=2,Color='red');
hold off;
title('Bootstrap Histogram');
xlabel('Mean Values');
ylabel('Count Of Frequencies');

%------------------------ Question (b) -------------------------------
sample_std_error = sqrt(var(X)) / sqrt(n); % se(xbar) = s/sqrt(n)
bootstrap_means = bootstrap_means';
theta_bar = 1/B * sum(bootstrap_means);
z = (bootstrap_means - theta_bar).^2;
bootstrap_std_error = sqrt(1/(B-1) * sum(z));

fprintf("Bootstrap estimation of se_B(x_bar) is : %.4f\n", bootstrap_std_error);
fprintf("Parametrical estimation of se(x_bar) is : %.4f\n", sample_std_error);

%------------------------ Question (c) -------------------------------
Y = exp(X);
bootstrap_samples = zeros(n, B);
bootstrap_means = zeros(1, B);
mean_value = mean(Y);

%------------------------ Question (a) -------------------------------
for i=1:B
    idx = randi([1, 10], 10, 1); % create 10 random indices 
    bootstrap_samples(:,i) = Y(idx); % get the bootstrap observations 
    bootstrap_means(:,i) = mean(bootstrap_samples(:,i)); % calculate the mean values for every bootstrap sample
end

figure('Name', 'Bootstrap Histogram')
histogram(bootstrap_means');
hold on;
xline(mean_value,  Label='Mean Value', LineWidth=2,Color='red');
hold off;
title('Bootstrap Histogram');
xlabel('Mean Values');
ylabel('Count Of Frequencies');

%------------------------ Question (b) -------------------------------
sample_std_error = sqrt(var(Y)) / sqrt(n); % se(xbar) = s/sqrt(n)
bootstrap_means = bootstrap_means';
theta_bar = 1/B * sum(bootstrap_means);
z = (bootstrap_means - theta_bar).^2;
bootstrap_std_error = sqrt(1/(B-1) * sum(z));

fprintf("Bootstrap estimation of se_B(x_bar) is : %.4f\n", bootstrap_std_error);
fprintf("Parametrical estimation of se(x_bar) is : %.4f\n", sample_std_error);



