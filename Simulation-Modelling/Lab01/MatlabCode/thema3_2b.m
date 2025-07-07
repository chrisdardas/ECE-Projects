clc;
clearvars;
close all;

L_real = 1.25;
m_real = 0.75;
c_real = 0.25;
A0 = 4;
omega = 2;
g = 9.81;
u=@(t)A0*sin(omega*t);

x0 = [0 0];
tspan = [0 20];
options = odeset('MaxStep', 1e-3);
[t, x] = ode45(@(t, x)pendulum(t, x, m_real, L_real, c_real, u), tspan, x0, options);
poles = [2 1];
lambda = [poles(1); poles(2); 0];
Z_1 = tf([-1 0], [1 poles(1) poles(2)]);
Z_2 = tf(-1, [1 poles(1) poles(2)]);
Z_3 = tf(1, [1 poles(1) poles(2)]);

Ts = [0.01, 0.2, 0.5, 0.75, 1, 1.2];
e_L = zeros(size(Ts, 2), 1);
e_m = zeros(size(Ts, 2), 1);
e_c = zeros(size(Ts, 2), 1);
j = 1;
for time = Ts
    time_vector = (0:time:20)';
    x_samples = interp1(t, x, time_vector); % to get the values at the specific time we need
    u_samples = u(time_vector);
    
    zeta_1 = lsim(Z_1, x_samples(:, 1), time_vector);
    zeta_2 = lsim(Z_2, x_samples(:, 1), time_vector);
    zeta_3 = lsim(Z_3, u_samples, time_vector);

    sum_zeta = 0;
    sum_response = 0;
    for i=1:size(zeta_1, 1)
        zeta = [zeta_1(i); zeta_2(i); zeta_3(i)];
        sum_zeta = sum_zeta + zeta*zeta';
        sum_response = sum_response + x_samples(i, 1) * zeta;
    end

    theta_lambda = sum_zeta \ sum_response;
    theta_hat = theta_lambda + lambda;
    L_hat = g / theta_hat(2);
    m_hat = 1 / (theta_hat(3) * L_hat^2);
    c_hat = theta_hat(1) * m_hat * L_hat^2;

    e_L(j) = abs(L_real - L_hat);
    e_m(j) = abs(m_real - m_hat);
    e_c(j) = abs(c_real - c_hat);
    j = j + 1;
end

figure('Name', "L Error");
plot(Ts,e_L, "Color", "red");
grid on;
title("Error of Length");
xlabel("$T_s[sec]$", "Interpreter", "latex", "FontSize", 15, "FontWeight","bold");
ylabel("$e_L[m]$", "Interpreter","latex", "FontSize", 15, "FontWeight","bold")

figure('Name', "m Error");
plot(Ts,e_m, "Color", "blue");
grid on;
title("Error of mass");
xlabel("$T_s[sec]$", "Interpreter", "latex", "FontSize", 15, "FontWeight","bold");
ylabel("$e_m[kg]$", "Interpreter","latex", "FontSize", 15, "FontWeight","bold")

figure('Name', "c Error");
plot(Ts,e_c, "Color", "green");
grid on;
title("Error of c");
xlabel("$T_s[sec]$", "Interpreter", "latex", "FontSize", 15, "FontWeight","bold");
ylabel("$e_c[N*m*sec]$", "Interpreter","latex", "FontSize", 15, "FontWeight","bold")