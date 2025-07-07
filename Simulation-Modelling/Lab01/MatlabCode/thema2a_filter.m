clc;
clearvars;
close all;

x = load("x_samples.mat").x_samples;
u = load("u_samples.mat").u_samples;
Ts = 0.1;
t = 0:Ts:20;
g = 9.81;

pole = 1;
Z_1 = tf(-1, [1 pole]);
Z_2 = tf(-1, [1 pole]);
Z_3 = tf(1, [1 pole]);

zeta_1 = lsim(Z_1, x(:, 2), t);
zeta_2 = lsim(Z_2, x(:, 1), t);
zeta_3 = lsim(Z_3, u, t);
lambda = [pole; 0; 0];

sum_zeta = 0;
sum_response = 0;
for i=1:size(x, 1)
    zeta = [zeta_1(i); zeta_2(i); zeta_3(i)];
    sum_zeta = sum_zeta + zeta*zeta';
    sum_response = sum_response + x(i, 2) * zeta;
end

theta_lambda = sum_zeta \ sum_response;
theta_hat = theta_lambda + lambda;
Lhat = g / theta_hat(2)
mhat = 1 / (theta_hat(3) * Lhat^2)
chat = theta_hat(1) * mhat * Lhat^2

tspan = [0 20];
x0 = [0 0];
options = odeset('MaxStep', 1e-3);
A0 = 4;
omega = 2;
u=@(t)A0*sin(omega*t);

[~, xhat] = ode45(@(t, xhat)pendulum(t, xhat, mhat, Lhat, chat, u), tspan, x0, options);
m = 0.75;
L = 1.25;
c = 0.15;
[t, xreal] = ode45(@(t, xreal)pendulum(t, xreal, m, L, c, u), tspan, x0, options);

figure('Name', "Angle of Pendulum");
plot(t, xreal(:, 1), "Color", "blue");
hold on
plot(t, xhat(:, 1), "Color", "green");
hold off;
grid on;
title("Angle of Pendulum");
ylabel("$Angle$[rad]", "Interpreter","latex", "FontSize", 15, "FontWeight","bold");
xlabel("t[sec]", "Interpreter","latex", "FontSize", 15, "FontWeight", "bold");
leg1 = legend("$q(t)$", "$\hat{q}(t)$");
set(leg1, "Interpreter", "latex");
set(leg1, "Fontsize", 17);
set(leg1, "FontWeight", "bold");

eq = xreal(:, 1) - xhat(:, 1);
figure("Name", "Position Error");
plot(t, eq, "Color", "red");
grid on;
title("Position Error");
ylabel("$e_q$[rad]", "Interpreter","latex", "FontSize", 15, "FontWeight", "bold");
xlabel("t[sec]", "Interpreter","latex", "FontSize", 15, "FontWeight", "bold");