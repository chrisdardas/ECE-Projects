clc;
clearvars;
close all;

lightair = readmatrix("lightair.dat");

x = lightair(:, 1); % Air density
y = lightair(:, 2); % Light speed
N = size(x, 1);
M = 1000; % number of bootstrap samples
alpha = 0.05;
lower_limit = M*alpha*0.5;
upper_limit = M*(1-alpha/2);

b0_values = zeros(M, 1);
b1_values = zeros(M, 1);

for i=1:M
    indices = unidrnd(N, N, 1);
    
    x_new = x(indices);
    y_new = y(indices);

    s_x = std(x_new);
    s_y = std(y_new);
    C = cov(x_new, y_new);
    s_xy = C(1, 2);
    b1_values(i) = s_xy / s_x^2;
    b0_values(i) = mean(y_new) - b1_values(i)*mean(x_new);
end

b0_values = sort(b0_values, 1);
b1_values = sort(b1_values, 1);

b0_ci(1) = b0_values(lower_limit);
b0_ci(2) = b0_values(upper_limit);

b1_ci(1) = b1_values(lower_limit);
b1_ci(2) = b1_values(upper_limit);

fprintf("95%% Confidence Interval for b0 is : [%.4f, %.4f]\n", b0_ci(1), b0_ci(2));
fprintf("95%% Confidence Interval for b1 is : [%.4f, %.4f]\n", b1_ci(1), b1_ci(2));
