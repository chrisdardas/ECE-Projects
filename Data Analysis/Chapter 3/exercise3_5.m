clc;
clearvars;
close all;

M = readmatrix('eruption.dat');

sigma_1989_w = 10;
sigma_1989_d = 1;
mu_w = 75;
mu_d = 2.5;
a = 0.05;

% -------------------- Question (a) -------------------------
[h, p, ci] = vartest(M(:, 1), sigma_1989_w^2, 'Alpha', a);
fprintf("95%% Confidence Interval for Standard Deviation is (1989): [%.3f, %.3f]\n", sqrt(ci(1)), sqrt(ci(2)));
if h==1
    fprintf("p-Value is : %.6f so the Hypothesis is rejected\n", p);
else
    fprintf("p-Value is : %.6f so the Hypothesis is accepted\n", p);
end

[h, p, ci] = vartest(M(:, 2), sigma_1989_d^2, 'Alpha', a);
fprintf("95%% Confidence Interval for Standard Deviation is : [%.3f, %.3f]\n", sqrt(ci(1)), sqrt(ci(2)));
if h==1
    fprintf("p-Value is : %.6f so the Hypothesis is rejected\n", p);
else
    fprintf("p-Value is : %.6f so the Hypothesis is accepted\n", p);
end

[h, p, ci] = vartest(M(:, 3), sigma_1989_w^2, 'Alpha', a);
fprintf("95%% Confidence Interval for Standard Deviation is (2006): [%.3f, %.3f]\n", sqrt(ci(1)), sqrt(ci(2)));
if h==1
    fprintf("p-Value is : %.6f so the Hypothesis is rejected\n", p);
else
    fprintf("p-Value is : %.6f so the Hypothesis is accepted\n", p);
end

% -------------------- Question (b) -------------------------
[h, p, ci] = ttest(M(:, 1), mu_w, 'Alpha', a);
fprintf("95%% Confidence Interval for Mean  Value(waiting) is (1989): [%.3f, %.3f]\n", ci(1), ci(2));
if h==1
    fprintf("p-Value is : %.6f so the Hypothesis is rejected\n", p);
else
    fprintf("p-Value is : %.6f so the Hypothesis is accepted\n", p);
end

[h, p, ci] = ttest(M(:, 2), mu_d, 'Alpha', a);
fprintf("95%% Confidence Interval for Mean Value(duration) is : [%.3f, %.3f]\n", ci(1), ci(2));
if h==1
    fprintf("p-Value is : %.6f so the Hypothesis is rejected\n", p);
else
    fprintf("p-Value is : %.6f so the Hypothesis is accepted\n", p);
end

[h, p, ci] = ttest(M(:, 3), mu_w, 'Alpha', a);
fprintf("95%% Confidence Interval for Mean Value(waiting) is (2006): [%.3f, %.3f]\n", ci(1), ci(2));
if h==1
    fprintf("p-Value is : %.6f so the Hypothesis is rejected\n", p);
else
    fprintf("p-Value is : %.6f so the Hypothesis is accepted\n", p);
end
% -------------------- Question (c) -------------------------
fprintf("\n");
[h, p] = chi2gof(M(:, 1));
if h==1
    fprintf("p-Value is : %.6f so the Hypothesis is rejected(1989)\n", p);
else
    fprintf("p-Value is : %.6f so the Hypothesis is accepted(1989)\n", p);
end

[h, p] = chi2gof(M(:, 2));
if h==1
    fprintf("p-Value is : %.6f so the Hypothesis is rejected(1989)\n", p);
else
    fprintf("p-Value is : %.6f so the Hypothesis is accepted(1989)\n", p);
end

[h, p] = chi2gof(M(:, 3));
if h==1
    fprintf("p-Value is : %.6f so the Hypothesis is rejected(2006)\n", p);
else
    fprintf("p-Value is : %.6f so the Hypothesis is accepted(2006)\n", p);
end

% -------------------- Checking the claim -------------------------
waiting_time = M(:, 1);
duration_time = M(:, 2);

less_than = duration_time < 2.5 ;
greater_than  = ~less_than;


wait_65 = waiting_time(less_than);
wait_91 = waiting_time(greater_than);

[~, p, ci] = ttest(wait_65, 65, 'Alpha',a);
fprintf("Confidence Interval for Mean Value 65 is : [%.3f, %.3f]\n", ci(1), ci(2));
fprintf("The p-Value is : %.4f\n", p);

[~, p, ci] = ttest(wait_91, 91, 'Alpha', a);
fprintf("Confidence Interval for Mean Value 91 is : [%.3f, %.3f]\n", ci(1), ci(2));
fprintf("The p-Value is : %.4f\n", p);

[~, p, ci] = vartest(waiting_time, 10^2, 'Alpha',a);
fprintf("Confidence Interval for Standard Deviation is : [%.3f, %.3f]\n", sqrt(ci(1)), sqrt(ci(2)));
fprintf("The p-Value is : %.4f\n", p);


