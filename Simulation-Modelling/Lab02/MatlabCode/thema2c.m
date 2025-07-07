clc;
clearvars;
close all;

rd_bar = pi / 10;
phi0 = 100;
phi_inf = phi0 / 100;
lambda = 5;
a1 = 1.1325;
a2 = 0.725;
a3 = 0.225;
b = 1.175;
k1 = 4.4;
k2 = 3.2;
G = 9.5 * [7, 3, 9.3, 5];
am = -0.4;
rho =  pi / 10 ;

A1 = 2;  A3 = 0.6;  A5 = 0.3; A7 = 0.15;
w0 = pi/20;
norm_factor = A1 - A3 + A5 - A7; 

rd = @(t) rd_bar * ( ...
       A1*sin(w0*t) ...
     + A3*sin(3*w0*t) ...
     + A5*sin(5*w0*t) ...
     + A7*sin(7*w0*t)) ...
   / norm_factor;

phi = @(t)(phi0 - phi_inf) * exp(-lambda * t) + phi_inf;
T = @(z) log((1+z)/(1-z));
d = @(t) 0.15 * sin(0.5*t);
tspan = [0 20];
x0 = [0; 0; 0; 0; 0; 0; 0; 0];
options = odeset('MaxStep', 1e-3);
[t, x] = ode45(@(t, x)recursive_controller_SP_distortion(t, x, rd, phi, T, a1, a2, a3, b, k1, k2, rho, am, G, d), tspan, x0, options);

figure();
plot(t, x(:, 1), 'b', 'LineWidth', 1.5);
hold on;
plot(t, x(:, 3), 'r--', 'LineWidth', 1.5);
xlabel('$\mathrm{Time}\,(sec)$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$\mathrm{Trajectory}$', 'Interpreter', 'latex', 'FontSize', 14);
title('$\mathrm{State\ }x_1\ \mathrm{and\ Estimated\ Trajectory}$', 'Interpreter', 'latex', 'FontSize', 16);
legend({'$r(t)$', '$\hat{r}(t)$'}, 'Interpreter', 'latex', 'Location', 'Best', 'FontSize', 12);
grid on;

figure();
plot(t, x(:,5), 'Color', [0 0.4470 0.7410], 'LineWidth', 1.5);
hold on;
plot(t, x(:,6), 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1.5);
plot(t, x(:,7), 'Color', [0.4660 0.6740 0.1880], 'LineWidth', 1.5);
plot(t, x(:,8), 'Color', [0.4940 0.1840 0.5560], 'LineWidth', 1.5);
yline(a1, '--', 'Color', 'r', 'LineWidth', 2);
yline(a2, '--', 'Color', 'g', 'LineWidth', 2);
yline(a3, '--', 'Color', 'b', 'LineWidth', 2);
yline(b,  '--', 'Color', 'k', 'LineWidth', 2);
xlabel('$\mathrm{Time}\,(sec)$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$\mathrm{Parameter\ Estimates}$', 'Interpreter', 'latex', 'FontSize', 14);
title('$\mathrm{Parameter\ Estimates\ vs\ True\ Values}$', 'Interpreter', 'latex', 'FontSize', 16);
legend({'$\hat{a}_1$', '$\hat{a}_2$', '$\hat{a}_3$', '$\hat{b}$', '$a_1$', '$a_2$', '$a_3$', '$b$'}, 'Interpreter', 'latex', 'Location', 'Best', 'FontSize', 12);
grid on;

figure();
plot(t, x(:, 1) - x(:, 3), 'g', 'LineWidth', 1.5);
xlabel('$\mathrm{Time}\,(s)$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$\mathrm{Error}\ e_1$', 'Interpreter', 'latex', 'FontSize', 14);
title('$\mathrm{Tracking\ Error}\ e_1$', 'Interpreter', 'latex', 'FontSize', 14);
legend({'$e_1$'}, 'Interpreter', 'latex', 'Location', 'Best', 'FontSize', 14);
grid on;






