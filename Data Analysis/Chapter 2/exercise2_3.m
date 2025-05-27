clc;
clearvars;
close all;

mu = [5, 7];
% Covariance Matrix (positive semi-definite)
Covariance = [1 1.5; 1.5 3]; % Creating the Covariance Matrix so the variables are dependent
n = 1:5000;
s1 = zeros(length(n), 1);
s2 = zeros(length(n), 1);

for i=1:length(n)

    R = mvnrnd(mu, Covariance, n(i)); % Creating 
    X = R(:, 1); % extracting the first column
    Y = R(:, 2); % extracting the second column
    Z = X + Y;
    
    s1(i) = var(Z); % Calculating the variance of Var[X + Y]
    s2(i) = var(X) + var(Y); % Calculating the variance of Var[X] + Var[Y]
end

plot(n, s1, 'b');
hold on;
plot(n, s2, 'r');
title("Variances");
xlabel('Number Of Repetitions');
xlim([1, 5000]);
ylabel('Value Of Variance');
legend('Var[ X + Y ]', 'Var[X] + Var[Y]');
grid on;