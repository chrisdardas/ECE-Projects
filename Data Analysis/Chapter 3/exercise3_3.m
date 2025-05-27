clc;
clearvars;
close all;

lambda = 1 / 15;
a = 0.05;
M = 1000;
n = 5;


x = exprnd(1/lambda, n, M);

h1 = ttest(x, 1/lambda, 'Alpha',a);
counter = sum(h1, 2);
prob = 1 - counter / M;
fprintf("The real mean value is with probability %.4f in the 95%% confidence interval\n", prob);

n = 100;


x = exprnd(1/lambda, n, M);

h2 = ttest(x, 1/lambda, 'Alpha',a);
counter = sum(h2, 2);
prob = 1 - counter / M;
fprintf("The real mean value is with probability %.4f in the 95%% confidence interval\n", prob);