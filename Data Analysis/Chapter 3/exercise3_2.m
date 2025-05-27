clc;
clearvars;
close all;

M = 100;
n = 1000;
lambda = 2;

mean_values = function3_1(M, n, lambda);

fprintf("λ: %d \t Mean Value: %g\n", lambda, mean_values);

M = 1000;
n = 1000;
lambda = 2;

mean_values = function3_1(M, n, lambda);

fprintf("λ: %d \t Mean Value: %g\n", lambda, mean_values);

M = 1000;
n = 10000;
lambda = 5;

mean_values = function3_1(M, n, lambda);

fprintf("λ: %d \t Mean Value: %f\n", lambda, mean_values);

M = 1000;
n = 1000;
for lambda=1:7
    mean_values = function3_1(M, n, lambda);
    fprintf("λ: %d \t Mean Value: %f\n", lambda, mean_values);
end
lambda = 2;
for M=100:100:1000
    mean_values = function3_1(M, n, lambda);
    fprintf("λ: %d \t Mean Value: %f\n", lambda, mean_values);
end