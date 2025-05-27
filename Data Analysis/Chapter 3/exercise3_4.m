clc;
clearvars;
close all;

x = [41 46 47 47 48 50 50 50 50 50 50 50 48 50 50 50 50 50 50 50 52 52 53 55 50 50 50 50 52 52 53 53 53 53 53 57 52 52 53 53 53 53 53 53 54 54 55 68];
a = 0.05;
sigma = 5;
mean_value = 52;
xbar = mean(x, 2);
z = (x - xbar).^2;
s_squared = 1/(length(x) - 1) * sum(z);

% -------------------- Question (a) -------------------------
[~, p, ci] = vartest(x, sigma^2, 'Alpha',a); % always gives us the confidence interval no matter the variance
fprintf("95%% Confidence Interval for Variance is : [%.3f, %.3f]\n", ci(1), ci(2));
fprintf("95%% Confidence Interval for Standard Deviation is : [%.3f, %.3f]\n", sqrt(ci(1)), sqrt(ci(2)));

% -------------------- Question (b) -------------------------
fprintf("p-Value is : %.3f\n", p); % Rejection of hypothesis since p < 0.05

% -------------------- Question (c) -------------------------
[h, p, ci] = ttest(x, mean_value, 'Alpha',a); % always gives us the confidence interval no matter the mean value
fprintf("Confidence Interval for the Mean Value is [%.3f, %.3f]\n", ci(1), ci(2));


% -------------------- Question (d) -------------------------
if h == 0
    fprintf("We can't reject the Hypothesis that Mean is 52kV  (p-Value = %.3f)\n", p);
else
    fprintf("The Hypothesis that Mean is 52kV (p-Value = %.3f) is rejected\n", p);
end

% -------------------- Question (e) -------------------------
[h, p] = chi2gof(x);
if h==1
    fprintf("p-Value is : %.4f so the Hypothesis is rejected\n", p);
else
    fprintf("p-Value is : %.4f so the Hypothesis is accepted\n", p);
end

