clc;
clearvars;
close all;

rd_bar = pi/10;
phi0 = 10;
phi_inf = phi0 / 20;
lambda = 5;
a1 = 1.1325;
a2 = 0.725;
a3 = 0.225;
b = 1.175;
k1 = 20;
k2 = 15;
rho = pi ;

rd1 = @(t) rd_bar * (sin((pi*t) / 20)).^2;
A1 = 2;  A3 = 0.6;  A5 = 0.3; A7 = 0.15;
w0   = pi/20;
norm_factor = A1 - A3 + A5 - A7;  

rd2 = @(t) rd_bar * ( ...
       A1*sin(w0*t) ...
     + A3*sin(3*w0*t) ...
     + A5*sin(5*w0*t) ...
     + A7*sin(7*w0*t)) ...
   / norm_factor;

phi = @(t)(phi0 - phi_inf) * exp(-lambda * t) + phi_inf;
T = @(z) log((1+z)/(1-z));
tspan = [0 20];
x0 = [0; 0];
options = odeset('MaxStep', 1e-3);
[t, x] = ode45(@(t, x)recursive_controller(t, x, rd1, phi, T, a1, a2, a3, b, k1, k2, rho), tspan, x0, options);

figure();
plot(t, x(:, 1), 'b-', 'LineWidth', 1.5);
hold on;
plot(t, rd1(t), 'r--', 'LineWidth', 1.5);
grid on;
xlabel('$t \; [\mathrm{sec}]$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$x(t)$ and $r_d(t)$', 'Interpreter', 'latex', 'FontSize', 14);
title('Controller Tracking Simulation: $x(t)$ vs. $r_d(t)$', 'Interpreter', 'latex', 'FontSize', 14);
legend({'System Output $x(t)$', 'Reference Trajectory $r_d(t)$'}, 'Interpreter', 'latex', 'FontSize', 14, 'Location', 'best');

[t, x] = ode45(@(t, x)recursive_controller(t, x, rd2, phi, T, a1, a2, a3, b, k1, k2, rho), tspan, x0, options);

figure();
plot(t, x(:, 1), 'b-', 'LineWidth', 1.5);
hold on;
plot(t, rd2(t), 'r--', 'LineWidth', 1.5);
grid on;
xlabel('$t \; [\mathrm{sec}]$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$x(t)$ and $r_d(t)$', 'Interpreter', 'latex', 'FontSize', 14);
title('Controller Tracking Simulation: $x(t)$ vs. $r_d(t)$', 'Interpreter', 'latex', 'FontSize', 14);
legend({'System Output $x(t)$', 'Reference Trajectory $r_d(t)$'}, 'Interpreter', 'latex', 'FontSize', 14, 'Location', 'best');