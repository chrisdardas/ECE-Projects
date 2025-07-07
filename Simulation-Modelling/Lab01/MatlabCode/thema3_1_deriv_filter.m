clc;
clearvars;
close all;

rng(33); % for reproducibility 108
x = load("x_samples.mat").x_samples;
u = load("u_samples.mat").u_samples;
Ts = 0.1;
t = 0:Ts:20;
g = 9.81;
n = 0 + 0.1*randn(size(x, 1), 1);

x1_noisy = x(:, 1) + n;
x2_noisy = x(:, 2) + n;
u_noisy = u + n;

qdotdot = gradient(x(:, 2)) / Ts;
qdotdot_noisy = gradient(x2_noisy) / Ts;


Z_1 = tf([-1 0], [1 2 1]);
Z_2 = tf(-1, [1 2 1]);
Z_3 = tf(1, [1 2 1]);

zeta_1 = lsim(Z_1, x1_noisy, t);
zeta_2 = lsim(Z_2, x1_noisy, t);
zeta_3 = lsim(Z_3, u_noisy, t);
lambda = [2; 1; 0];

sum_delta = 0;
sum_response_delta = 0;
sum_zeta = 0;
sum_response_zeta = 0;
for i=1:size(x, 1)
    delta = [-x2_noisy(i); -x1_noisy(i); u_noisy(i)];
    zeta = [zeta_1(i); zeta_2(i); zeta_3(i)];
    sum_delta = sum_delta + delta * delta';
    sum_zeta  = sum_zeta  + zeta * zeta';
    sum_response_delta = sum_response_delta + qdotdot_noisy(i) * delta;
    sum_response_zeta = sum_response_zeta + x1_noisy(i) * zeta;
end

theta_hat_delta = sum_delta \ sum_response_delta;
theta_lambda  = sum_zeta \ sum_response_zeta;

% Calculating the values which were identified by the Least Squares method
Lhat_delta = g / theta_hat_delta(2);
mhat_delta = 1 / (theta_hat_delta(3) * Lhat_delta^2);
chat_delta = theta_hat_delta(1) * mhat_delta * Lhat_delta^2;
fprintf("With Knowledge L: %.4f, m: %.4f, c: %.4f\n", Lhat_delta, mhat_delta, chat_delta);
tspan = [0 20];
x0 = [0 0];
options = odeset('MaxStep', 1e-3);
A0 = 4;
omega = 2;
u=@(t)A0*sin(omega*t);

[~, xhat_delta] = ode45(@(t, xhat_delta)pendulum(t, xhat_delta, mhat_delta, Lhat_delta, chat_delta, u), tspan, x0, options);

theta_hat = theta_lambda + lambda;
Lhat_zeta = g / theta_hat(2);
mhat_zeta = 1 / (theta_hat(3) * Lhat_zeta^2);
chat_zeta = theta_hat(1) * mhat_zeta * Lhat_zeta^2;

fprintf("Without Knowledge L: %.4f, m: %.4f, c: %.4f\n", Lhat_zeta, mhat_zeta, chat_zeta);
[~, xhat_zeta] = ode45(@(t, xhat_zeta)pendulum(t, xhat_zeta, mhat_zeta, Lhat_zeta, chat_zeta, u), tspan, x0, options);

m = 0.75;
L = 1.25;
c = 0.15;
[t, xreal] = ode45(@(t, xreal)pendulum(t, xreal, m, L, c, u), tspan, x0, options);

figure('Name', "Angle of Pendulum");
ax = gca;
x_limits = get(ax, 'XLim');
y_limits = get(ax, 'YLim');
x_pos = x_limits(2) - 0.05 * (x_limits(2) - x_limits(1));
y_pos = y_limits(2) + 0.75;
plot(t, xreal(:, 1), "Color", "blue");
hold on
plot(t, xhat_delta(:, 1), "Color", "green");
hold off;
grid on;
title("Angle of Pendulum ($\dot{q}$ is known)", "Interpreter", "latex", "FontSize", 15, "FontWeight", "bold");
ylabel("$Angle$[rad]", "Interpreter","latex", "FontSize", 15, "FontWeight","bold");
xlabel("t[sec]", "Interpreter","latex", "FontSize", 15, "FontWeight", "bold");
txt = sprintf('$\\hat{L}$: %.4f \\quad $\\hat{m}$: %.4f \\quad $\\hat{c}$: %.4f', Lhat_delta, mhat_delta, chat_delta);
text(x_pos, y_pos, txt, 'FontSize', 15, 'Color', 'black', 'FontWeight', 'bold', 'Interpreter', 'latex');
leg1 = legend("$q(t)$", "$\hat{q}(t)$");
set(leg1, "Interpreter", "latex");
set(leg1, "Fontsize", 17);
set(leg1, "FontWeight", "bold");

eq_delta = xreal(:, 1) - xhat_delta(:, 1);
figure("Name", "Position Error");
plot(t, eq_delta, "Color", "red");
grid on;
title("Position Error($\dot{q}$ is known)", "Interpreter", "latex", "FontSize", 15, "FontWeight", "bold");
ylabel("$e_q$[rad]", "Interpreter","latex", "FontSize", 15, "FontWeight", "bold");
xlabel("t[sec]", "Interpreter","latex", "FontSize", 15, "FontWeight", "bold");

figure('Name', "Angle of Pendulum");
ax = gca;
x_limits = get(ax, 'XLim');
y_limits = get(ax, 'YLim');
x_pos = x_limits(2) - 0.05 * (x_limits(2) - x_limits(1));
y_pos = -(y_limits(2) + 0.75);
plot(t, xreal(:, 1), "Color", "blue");
hold on
plot(t, xhat_zeta(:, 1), "Color", "green");
hold off;
grid on;
title("Angle of Pendulum ($\dot{q}$ is NOT known)", "Interpreter", "latex", "FontSize", 15, "FontWeight", "bold");
ylabel("$Angle$[rad]", "Interpreter","latex", "FontSize", 15, "FontWeight","bold");
xlabel("t[sec]", "Interpreter","latex", "FontSize", 15, "FontWeight", "bold");
txt = sprintf('$\\hat{L}$: %.4f \\quad $\\hat{m}$: %.4f \\quad $\\hat{c}$: %.4f', Lhat_zeta, mhat_zeta, chat_zeta);
text(x_pos, y_pos, txt, 'FontSize', 15, 'Color', 'black', 'FontWeight', 'bold', 'Interpreter', 'latex');
leg1 = legend("$q(t)$", "$\hat{q}(t)$");
set(leg1, "Interpreter", "latex");
set(leg1, "Fontsize", 17);
set(leg1, "FontWeight", "bold");

eq_zeta = xreal(:, 1) - xhat_zeta(:, 1);
figure("Name", "Position Error");
plot(t, eq_zeta, "Color", "red");
grid on;
title("Position Error($\dot{q}$ is NOT known)", "Interpreter", "latex", "FontSize", 15, "FontWeight", "bold");
ylabel("$e_q$[rad]", "Interpreter","latex", "FontSize", 15, "FontWeight", "bold");
xlabel("t[sec]", "Interpreter","latex", "FontSize", 15, "FontWeight", "bold");