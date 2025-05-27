clc;
clearvars;
close all;

n = 1:1:1000;
len = length(n);
exp_value = zeros(len, 1);
inv_exp_value = zeros(len, 1);

for i=1:len
    X = 1 + (2 - 1) .* rand(n(i), 1); % create samples from a specific Uniform Distribution
    exp_value(i, 1) = 1 / mean(X);
    inv_exp_value(i, 1) = mean(1 ./ X);
end
figure;
plot(n, exp_value, 'b');
title('Uniform [1, 2]')
hold on;
plot(n, inv_exp_value, 'r');
legend('1/E[X]', 'E[1/X]')

% Uniform [0, 1]

for i=1:len
    X = rand(n(i), 1); 
    exp_value(i, 1) = 1 / mean(X);
    inv_exp_value(i, 1) = mean(1 ./ X);
end

figure;
plot(n, exp_value, 'b');
title('Uniform [0, 1]')
hold on;
plot(n, inv_exp_value, 'r');
legend('1/E[X]', 'E[1/X]')

% Uniform [-1, 1]

for i=1:len
    X = -1 + (1 - (-1)) .* rand(n(i), 1); 
    exp_value(i, 1) = 1 / mean(X);
    inv_exp_value(i, 1) = mean(1 ./ X);
end

figure;
plot(n, exp_value, 'b');
title('Uniform [-1, 1]')
hold on;
plot(n, inv_exp_value, 'r');
legend('1/E[X]', 'E[1/X]')
