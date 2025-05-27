clc;
clearvars;
close all;

lightair = readmatrix("lightair.dat");

x = lightair(:, 1); % Air density 
y = lightair(:, 2); % Light speed
n = size(lightair, 1);

mean_x = mean(x);
mean_y = mean(y);
C = cov(x, y);
cov_xy = C(1, 2);
s_x = std(x);
s_y = std(y);
alpha = 0.05;
%------------------------------ Question (a,b) ----------------------------
b1 = cov_xy / s_x^2;
b0 = mean_y - b1*mean_x;
y_estimator = b0 + b1*x;

e = y - y_estimator;

s_e = sqrt((n-1)/(n-2) * (s_y^2 - b1^2*s_x^2));
e_star = e / s_e;

figure("Name","Diagnostic Plot");
plot(y, e_star, "linestyle", 'none', "Marker","o");
title("Diagnostic Plot");
xlabel("y_i")
ylabel("e_i^*")
yline(2, LineWidth=2,Color='red');
yline(-2, LineWidth=2,Color='red');
R = corrcoef(x, y);
r = R(1, 2);
fprintf("Correlation Coefficient of air and light is equal to : %.4f\n", r);

t_value = tinv(1-alpha/2, n-2);
S_xx = (n - 1) * s_x^2;

b1_ci(1) = b1 - t_value * (s_e / sqrt(S_xx));
b1_ci(2) = b1 + t_value * (s_e / sqrt(S_xx));

b0_ci(1) = b0 - t_value * s_e * sqrt(1/n + mean_x^2 / S_xx);
b0_ci(2) = b0 + t_value * s_e * sqrt(1/n + mean_x^2 / S_xx);

fprintf("95%% Confidence Interval for b1 is : [%.4f, %.4f]\n", b1_ci(1), b1_ci(2));
fprintf("95%% Confidence Interval for b0 is : [%.4f, %.4f]\n", b0_ci(1), b0_ci(2));


%------------------------------ Question (c) ------------------------------
x_value = 1.29;
% Confidence Interval for the mean value of Y
y_ci(1, :) = y_estimator - t_value * s_e * sqrt(1/n + (x_value - mean_x)^2 / S_xx);
y_ci(2, :) = y_estimator + t_value * s_e * sqrt(1/n + (x_value - mean_x)^2 / S_xx);
fprintf("95%% Confidence Interval for Y for x=%.2f is : [%.4f, %.4f]\n", x_value, y_ci(1), y_ci(2));

% Confidence Interval for a value of y
y_obs_ci(1, :) = y_estimator - t_value * s_e * sqrt(1 + 1/n + (x_value - mean_x)^2 / S_xx);
y_obs_ci(2, :) = y_estimator + t_value * s_e * sqrt(1 + 1/n + (x_value - mean_x)^2 / S_xx);
fprintf("95%% Confidence Interval for an observation y of Y for x=%.2f is : [%.4f, %.4f]\n", x_value, y_obs_ci(1), y_obs_ci(2));

figure("Name", "Regression Line");
plot(x, y, "linestyle", 'none', "Marker","o");
hold on;
plot(x, y_estimator, 'r');
xlabel("Air Density");
ylabel("Light Speed");
title("Regression Line");
plot(x, y_ci(1, :))
plot(x, y_ci(2, :))
plot(x, y_obs_ci(1, :))
plot(x, y_obs_ci(2, :))
% yline(y_ci(1), LineWidth=2, Color='red');
% yline(y_ci(2), LineWidth=2, Color='red');
% yline(y_obs_ci(1), LineWidth=2, Color='green');
% yline(y_obs_ci(2), LineWidth=2, Color='green');
hold off;

%------------------------------ Question (d) ------------------------------
c = 299792.458;
d0 = 1.29;
const = 299000;

y_real = c*(1 - 0.00029*x/d0);
beta_1 = -c*0.00029/d0;
beta_0 = c;

t_crit_b1 = (b1 - beta_1) * (sqrt(S_xx) / s_e);
t_crit_b0 = (b0 + const - beta_0) / (s_e * sqrt(1/n + (mean_x^2/S_xx)));

p0 = 2*(1 - tcdf(abs(t_crit_b0), n - 2));
p1 = 2*(1 - tcdf(abs(t_crit_b1), n - 2));

if p0 > alpha
    fprintf("We can not reject the Null Hypothesis(H0) for b0\n");
end

if p1 > alpha
    fprintf("We can not reject the Null Hypothesis(H0) for b1\n");
end

mean_y_real = mean(y_real);

if mean_y_real >= (y_ci(1) + const) && mean_y_real <= (y_ci(2) + const)
    fprintf("The real mean value is within the CI we calculated for the mean value of y\n")
end


