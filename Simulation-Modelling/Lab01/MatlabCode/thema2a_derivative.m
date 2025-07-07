clc;
clearvars;
close all;

x = load("x_samples.mat").x_samples;
u = load("u_samples.mat").u_samples;
Ts = 0.1;
g = 9.81;

y = gradient(x(:, 2)) / Ts ; % approximate qdotdot
x1 = x(:, 1);
x2 = x(:, 2);

sum_delta = 0;
sum_response = 0;
for i=1:size(y, 1)
    delta = [-x2(i); -x1(i); u(i)];
    sum_delta = sum_delta + delta * delta';
    sum_response = sum_response + y(i) * delta;
end
% phi = [ -x2, -x1, u ];
% theta_phi = (y'*phi)*inv(phi'*phi)

theta_hat = sum_delta \ sum_response;


% Calculating the values which were identified by the Least Squares method
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

