clc;
clearvars;
close all;

L_real = 1.25;
m_real = 0.75;
c_real = 0.15;
omega = 2;
g = 9.81;
A0 = [0.5 1 3 5 7]; % Amplitude of the input
Ts = 0.1;
time_vector = (0:Ts:20)';

x0 = [0; 0];
tspan = [0 20];
options = odeset('MaxStep', 1e-3);
poles = [2 1];
lambda = [poles(1); poles(2); 0];
Z_1 = tf([-1 0], [1 poles(1) poles(2)]);
Z_2 = tf(-1, [1 poles(1) poles(2)]);
Z_3 = tf(1, [1 poles(1) poles(2)]);

e_L = zeros(size(A0, 2), 1);
e_m = zeros(size(A0, 2), 1);
e_c = zeros(size(A0, 2), 1);
j = 1;

for A=A0
    u=@(t)A*sin(omega*t);
    [t, x] = ode45(@(t, x)pendulum(t, x, m_real, L_real, c_real, u), tspan, x0, options);

    x_samples = interp1(t, x, time_vector); % to get the values at the specific time we need
    u_samples = u(time_vector);

    zeta_1 = lsim(Z_1, x_samples(:, 1), time_vector);
    zeta_2 = lsim(Z_2, x_samples(:, 1), time_vector);
    zeta_3 = lsim(Z_3, u_samples, time_vector);
  
    sum_zeta = 0;
    sum_response = 0;
    for i=1:size(x_samples, 1)
        zeta = [zeta_1(i); zeta_2(i); zeta_3(i)];
        sum_zeta = sum_zeta + zeta*zeta';
        sum_response = sum_response + x_samples(i, 1) * zeta;
    end
    
    theta_lambda = sum_zeta \ sum_response;
    theta_hat = theta_lambda + lambda;
    L_hat = g / theta_hat(2);
    m_hat = 1 / (theta_hat(3) * L_hat^2);
    c_hat = theta_hat(1) * m_hat * L_hat^2;


    e_L(j) = (L_real - L_hat);
    e_m(j) = (m_real - m_hat);
    e_c(j) = (c_real - c_hat);
    j = j + 1;
end

figure('Name', "L Error");
plot(A0,e_L, "Color", "red");
grid on;
title("Error of Length");
xlabel("$A_0[N*m]$", "Interpreter", "latex", "FontSize", 15, "FontWeight","bold");
ylabel("$e_L[m]$", "Interpreter","latex", "FontSize", 15, "FontWeight","bold");

figure('Name', "m Error");
plot(A0,e_m, "Color", "blue");
grid on;
title("Error of mass");
xlabel("$A_0[N*m]$", "Interpreter", "latex", "FontSize", 15, "FontWeight","bold");
ylabel("$e_m[kg]$", "Interpreter","latex", "FontSize", 15, "FontWeight","bold");

figure('Name', "c Error");
plot(A0,e_c, "Color", "green");
grid on;
title("Error of c");
xlabel("$A_0[N*m]$", "Interpreter", "latex", "FontSize", 15, "FontWeight","bold");
ylabel("$e_c[N*m*sec]$", "Interpreter","latex", "FontSize", 15, "FontWeight","bold");