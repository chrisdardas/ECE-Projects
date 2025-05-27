clc;
clearvars;
close all;

temperatures = readmatrix("tempThes59_97.dat");
rain = readmatrix("rainThes59_97.dat");

months = size(temperatures, 2);
n = size(temperatures, 1);
p_values = zeros(months, 1);
alpha = 0.05;
L = 1000;
r = zeros(months, 1);
corr_percentage = zeros(months, 1);
t_crit = zeros(L+1, 1);
lower_limit = L*alpha*0.5;
upper_limit = L*(1-alpha/2);

% Parametric Check For Null Hypothesis

for i=1:months
    X = temperatures(:, i);
    Y = rain(:, i);

    % std_x = std(X);
    % std_y = std(Y);
    % covariance = cov(X, Y);
    % r_2(i) = covariance(1, 2) / (std_x * std_y);

    [R, P] = corrcoef(X, Y);
    r(i) = R(1, 2) ;
    tc = r(i)*sqrt((n-2) / (1 - r(i)^2));
    p_values(i) = 2*(1-tcdf(abs(tc), n-2));
    if p_values(i) < alpha
        fprintf("The Null Hypothesis(H0) for month %d is rejected(Parametric).\n", i);
    end
    t_crit(1) = tc;
    for j=1:L
        indices = randperm(n);
        X_new = X(indices);
        R_new = corrcoef(X_new, Y);
        r_new = R_new(1, 2);
        t_crit(j+1) = r_new*sqrt((n-2) / (1 - r_new^2)); 
    end
    t_crit = sort(t_crit, 1);

    if (tc < t_crit(lower_limit) || tc > t_crit(upper_limit))
        fprintf("The Null Hypothesis(H0) for month %d is rejected(Randomized).\n", i);
    end

    corr_percentage(i) = (r(i)^2) * 100;
end

