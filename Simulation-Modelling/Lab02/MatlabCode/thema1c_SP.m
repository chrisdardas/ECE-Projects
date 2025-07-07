clc;
clearvars;
close all;

m = 1.315;
b = 0.225;
k = 0.725;

u = @(t) 2.5 * sin(t);
h = @(t) 0.25 * sin(40*pi*t);
tspan = [0 20];
x0 = [0; 0; 0; 0; -0.5; -0.5; 0.2];
options = odeset('MaxStep',1e-3);

A = [0 1; -k/m -b/m];
B = [0; 1/m];
Am = - 5 * eye(2);
G = 0.75 * [1; 1];

[t, x] = ode45(@(t, x)series_parallel_noise(t, x, u, A, B, Am, G, h), tspan, x0, options);

mhat = 1./ x(:, 7);
khat = - mhat .* x(:, 5);
bhat = - mhat .* x(:, 6);

figure();
plot(t, mhat, 'Color', [0, 0.4470, 0.7410], 'LineWidth', 1.5); 
hold on;
plot(t, khat, 'Color', [0.8500, 0.3250, 0.0980], 'LineWidth', 1.5); 
plot(t, bhat, 'Color', [0.4940, 0.1840, 0.5560], 'LineWidth', 1.5); 

yline(m, '--', 'LineWidth', 2, 'Color', [0.9290, 0.6940, 0.1250]); 
yline(k, '--', 'LineWidth', 2, 'Color', [0.3010, 0.7450, 0.9330]); 
yline(b, '--', 'LineWidth', 2, 'Color', [0.4660, 0.6740, 0.1880]); 

grid on;
title('Estimated and Real Parameters', 'Interpreter', 'latex', 'FontSize', 16);
xlabel('$t\ (\mathrm{s})$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('Value', 'Interpreter', 'latex', 'FontSize', 14);
legend({'$\hat{m}$', '$\hat{k}$', '$\hat{b}$', '$m$', '$k$', '$b$'}, 'Interpreter', 'latex', 'FontSize', 12);
hold off;


figure();
plot(t, x(:, 1), 'Color', [0, 0.4470, 0.7410], 'LineWidth', 1.5); 
hold on;
plot(t, x(:, 3), 'Color', [0.8500, 0.3250, 0.0980], 'LineWidth', 1.5); 
hold off;
grid on;
title('Position vs. Estimated Position', 'Interpreter', 'latex', 'FontSize', 16);
xlabel('$t\ (\mathrm{s})$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('Position (m)', 'Interpreter', 'latex', 'FontSize', 14);
legend({'Real', 'Estimated'}, 'Interpreter', 'latex', 'FontSize', 12);

% Plot position error
e = x(:, 1) - x(:, 3);
figure();
plot(t, e, 'Color', [0.4940, 0.1840, 0.5560], 'LineWidth', 1.5);
grid on;
title('Position Error', 'Interpreter', 'latex', 'FontSize', 16);
xlabel('$t\ (\mathrm{s})$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('Error (m)', 'Interpreter', 'latex', 'FontSize', 14);

h0_values = [0.5, 1, 2, 4, 8, 16, 32, 64, 128]; % Amplitude of disturbance
e_m = zeros(length(h0_values), 1);
e_k = zeros(length(h0_values), 1);
e_b = zeros(length(h0_values), 1);
i = 1;

for h0 = h0_values
    h = @(t) h0 * sin(40 * pi * t);
    [t, x] = ode45(@(t, x)parallel_noise(t, x, u, A, B, G, h), tspan, x0, options);
    mhat = 1./ x(:, 7);
    khat = - mhat .* x(:, 5);
    bhat = - mhat .* x(:, 6);

    e_m(i) = mean(abs(m - mhat));
    e_k(i) = mean(abs(k - khat));
    e_b(i) = mean(abs(b - bhat));
    i = i + 1;
end

figure();
plot(h0_values, e_m, 'Color', [0, 0.4470, 0.7410], 'LineWidth', 1.5);
grid on;
title('Mean Error in Mass Estimation', 'Interpreter', 'latex', 'FontSize', 16);
xlabel('Amplitude of Disturbance $h_0$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('Mean Error', 'Interpreter', 'latex', 'FontSize', 14);
legend({'$e_m$'}, 'Interpreter', 'latex', 'FontSize', 12);

figure();
plot(h0_values, e_k, 'Color', [0.8500, 0.3250, 0.0980], 'LineWidth', 1.5); 
grid on;
title('Mean Error in Stiffness Estimation', 'Interpreter', 'latex', 'FontSize', 16);
xlabel('Amplitude of Disturbance $h_0$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('Mean Error', 'Interpreter', 'latex', 'FontSize', 14);
legend({'$e_k$'}, 'Interpreter', 'latex', 'FontSize', 12);

figure();
plot(h0_values, e_b, 'Color', [0.4940, 0.1840, 0.5560], 'LineWidth', 1.5); 
grid on;
title('Mean Error in Damping Estimation', 'Interpreter', 'latex', 'FontSize', 16);
xlabel('Amplitude of Disturbance $h_0$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('Mean Error', 'Interpreter', 'latex', 'FontSize', 14);
legend({'$e_b$'}, 'Interpreter', 'latex', 'FontSize', 12);
