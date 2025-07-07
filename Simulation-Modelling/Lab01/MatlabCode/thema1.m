clc;
clearvars;
close all;

A0 = 4;
omega = 2;
m = 0.75;
L = 1.25;
c = 0.15;
u=@(t)A0*sin(omega*t);

x0 = [0 0];
tspan = [0 20];
options = odeset('MaxStep', 1e-3);
[t, x] = ode45(@(t, x)pendulum(t, x, m, L, c, u), tspan, x0, options);

figure('Name', "Angle of Pendulum");
plot(t, x(:, 1), "Color", "blue");
grid on;
title("Angle of Pendulum");
ylabel("$q(t)$[rad]", "Interpreter","latex", "FontSize", 17, "FontWeight","bold");
xlabel("t[sec]", "Interpreter","latex", "FontSize", 17, "FontWeight", "bold");

figure("Name", "Speed of Pendulum");
plot(t, x(:, 2), "Color", "red");
grid on;
title("Speed of Pendulum");
ylabel("$\dot{q}(t)$[rad/sec]", "Interpreter","latex", "FontSize", 17, "FontWeight","bold");
xlabel("t[sec]", "Interpreter","latex", "FontSize", 17, "FontWeight", "bold");

Ts = 0.1;
time_vector = (0:Ts:20)';

x_samples = interp1(t, x, time_vector); % to get the values at the specific time we need
u_samples = u(time_vector);
save("x_samples.mat", "x_samples");
save("u_samples.mat", "u_samples");