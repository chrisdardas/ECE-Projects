clc;
clearvars;
close all;

a11 = -2.15;
a12 =  0.25;
a21 = -0.75;
a22 = -2;

b1 = 0;
b2 = 1.5;

A = [a11 a12; a21 a22]; 
B = [b1; b2];
gamma1 = 10;
gamma2 = 5;

am1 = 0.3;
am2 = 0.3;
u = @(t) sin(2*t) + sin(5*t) + sin(7*t);
tspan = [0 100];
x0 = [-1; 0.25; -2; 0; 0; 0; 0; 3; 0; 0]; % [x1, x2, a11, a12, a21, a22, b1, b2, x1hat, x2hat]

options = odeset('MaxStep',1e-3);

% -3 <= a11 <= -1 && b2 >= 1 
[t, x] = ode45(@(t, x) series_parallel(t, x, u, A, B, gamma1, gamma2, am1, am2), tspan, x0, options);
% Extract
x_real = x(:,1:2);
x_hat  = x(:, 9:10);

% Plot states vs estimated states
figure();
subplot(2,1,1); 
plot(t, x_real(:,1), 'b', t, x_hat(:,1), 'r'); 
xlabel('$t\ (\mathrm{sec})$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('State $x_1$', 'Interpreter','latex', 'FontSize', 14);
legend('$x_1$','$\hat{x}_1$', 'Interpreter', 'latex', 'Fontsize', 14);
subplot(2,1,2); 
plot(t, x_real(:,2), 'b', t, x_hat(:,2), 'r'); 
xlabel('$t\ (\mathrm{sec})$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('State $x_2$', 'Interpreter','latex', 'FontSize', 14);
legend('$x_2$','$\hat{x}_2$', "Interpreter", 'latex', 'Fontsize', 14);
sgtitle('True vs Estimated States', 'interpreter', 'latex');


figure();
subplot(2, 1, 1);
plot(t, x_real(:, 1) - x_hat(:, 1), 'b', 'LineWidth', 1.5);
xlabel('$t\ (\mathrm{sec})$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('Error in $x_1$', 'Interpreter', 'latex');
title('Error in $x_1$', 'Interpreter', 'latex');
subplot(2, 1, 2);
plot(t, x_real(:, 2) - x_hat(:, 2), 'b', 'LineWidth', 1.5);
xlabel('$t\ (\mathrm{sec})$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('Error in $x_2$', 'Interpreter', 'latex');
title('Error in $x_2$', 'Interpreter', 'latex');


figure();
paramNames = {'$\alpha_{11}$', '$\alpha_{12}$', '$\alpha_{21}$', '$\alpha_{22}$', '$b_1$', '$b_2$'};
estCols    = [3, 4, 5, 6, 7, 8];
realVals   = [a11, a12, a21, a22, b1, b2];

for i = 1:6
    subplot(3,2,i);
    plot(t, x(:, estCols(i)), 'b', 'LineWidth', 1.5);
    hold on;
    plot(t, realVals(i)*ones(size(t)), '--r', 'LineWidth', 1.5);
    xlabel('$t\ (\mathrm{sec})$', 'Interpreter', 'latex', 'FontSize', 14);
    ylabel(paramNames{i}, 'Interpreter', 'latex', 'FontSize', 14);
    legend('Estimated','Real');
    title(['Comparison of ', paramNames{i}], 'Interpreter', 'latex', 'FontWeight','bold', 'FontSize', 14);
    hold off;
end