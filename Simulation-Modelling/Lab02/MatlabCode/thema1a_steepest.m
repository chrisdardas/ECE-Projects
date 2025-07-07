clc;
clearvars;
close all;

m = 1.315;
b = 0.225;
k = 0.725;
am = 1;
G1 = 5 * diag([2.5, 3.3, 2]);
G2 = 0.1 * eye(3); 

u1 = @(t) 2.5;
u2 = @(t) 2.5 * sin(t);
tspan = [0 20];
x0 = [0; 0; 0; 0; 0; 0.1; -0.1; 0.1; 0];
options = odeset('MaxStep',1e-3);
[t, x] = ode45(@(t, x)steepest_descent(t, x, u2, m, k, b, am, G2), tspan, x0, options);

mhat = 1./ x(:, 8);
khat = - mhat .* x(:, 7);
bhat = mhat .* (am - x(:, 6));

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
xlabel('$t\ (\mathrm{sec})$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('Value', 'Interpreter', 'latex', 'FontSize', 14);
legend({'$\hat{m}$', '$\hat{k}$', '$\hat{b}$', '$m$', '$k$', '$b$'}, 'Interpreter', 'latex', 'FontSize', 12);
hold off;


figure();
plot(t, x(:, 1), 'Color', [0, 0.4470, 0.7410], 'LineWidth', 1.5); 
hold on;
plot(t, x(:, 9), 'Color', [0.8500, 0.3250, 0.0980], 'LineWidth', 1.5);
hold off;
grid on;
title('Position vs. Estimated Position', 'Interpreter', 'latex', 'FontSize', 16);
xlabel('$t\ (\mathrm{sec})$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('Position (m)', 'Interpreter', 'latex', 'FontSize', 14);
legend({'Real', 'Estimated'}, 'Interpreter', 'latex', 'FontSize', 12);

% Plot position error
e = x(:, 1) - x(:, 9);
figure();
plot(t, e, 'Color', [0.4940, 0.1840, 0.5560], 'LineWidth', 1.5); 
grid on;
title('Position Error', 'Interpreter', 'latex', 'FontSize', 16);
xlabel('$t\ (\mathrm{sec})$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('Error (m)', 'Interpreter', 'latex', 'FontSize', 14);


