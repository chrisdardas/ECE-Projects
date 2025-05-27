clc;
clearvars;
close all;


mu = 4;
sigma = 0.1;
% n = 1e8;
% x = normrnd(mu, sigma, n, 1) < 3.9 ;
% y = sum(x, 1) / n;

prob = normcdf(3.9, mu, sigma); % returns the probability of < 3.9
fprintf("The probability of the rod being destroyed is : %f \n", prob);
% 15% of the rods is being destroyed
result = norminv([0.01, 0.999], mu, sigma);
% prob2 = normcdf(3.767365, mu, sigma)

fprintf("The value for which only 1%% of rods is destroyed is : %f\n", result(1));
%prob = normcdf(3.7674, mu, sigma);


