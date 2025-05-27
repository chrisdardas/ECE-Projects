clc;
clearvars;
close all;

M = 1000;

mu_V = 77.78; % Volts
mu_I = 1.21; % Ampere
mu_f = 0.283; % rad

sigma_V = 0.71;
sigma_I = 0.071;
sigma_f = 0.017;

%------------------------------ Question (a) ------------------------------

sigma_P = sqrt((mu_I*cos(mu_f))^2 * sigma_V^2 + ...
    (mu_V*cos(mu_f))^2 * sigma_I^2 + ...
    (mu_V*mu_I*sin(mu_f))^2 * sigma_f^2);

fprintf("The uncertainty of power P is : %.4f\n", sigma_P);

%------------------------------ Question (b) ------------------------------

V = mu_V + sigma_V * randn(M, 1);
I = mu_I + sigma_I * randn(M, 1);
f = mu_f + sigma_f * randn(M, 1);

mean_V = mean(V);
mean_I = mean(I);
mean_f = mean(f);

var_V = var(V);
var_I = var(I);
var_f = var(f);

sigma_P_experiment = sqrt((mean_I*cos(mean_f))^2 * var_V + ...
    (mean_V*cos(mean_f))^2 * var_I + ...
    (mean_V*mean_I*sin(mean_f))^2 * var_f);

P = V.*I.*cos(f);
std_P = std(P);
fprintf("The uncertainty of power P is : %.4f\n", sigma_P_experiment);
fprintf("The uncertainty of power P is : %.4f\n", std_P);

%------------------------------ Question (c) ------------------------------

mu_table = [mu_V mu_I mu_f];
r_Vf = 0.5;
Sigma = [sigma_V^2 0 r_Vf*sigma_V*sigma_f; 0 sigma_I^2 0; r_Vf*sigma_V*sigma_f 0 sigma_f^2];
R = mvnrnd(mu_table, Sigma, M);

V_2 = R(:, 1);
I_2 = R(:, 2);
f_2 = R(:, 3);

mean_V2 = mean(V_2);
mean_I2 = mean(I_2);
mean_f2 = mean(f_2);

var_V2 = var(V_2);
var_I2 = var(I_2);
var_f2 = var(f_2);

P_2 = V_2.*I_2.*cos(f_2);
std_P_2 = std(P_2);
cov_Vf = r_Vf * sigma_V * sigma_f;

std_P_2_experiment = sqrt((mean_I2*cos(mean_f2))^2 * var_V2 + ...
    (mean_V2*cos(mean_f2))^2 * var_I2 + ...
    (mean_V2*mean_I2*sin(mean_f2))^2 * var_f2 + ...
    -2*mean_V2*mean_I2^2*sin(mean_f2)*cos(mean_f2)*cov_Vf);

fprintf("The uncertainty of power P is : %.4f\n", std_P_2_experiment);
fprintf("The uncertainty of power P is : %.4f\n", std_P_2);















