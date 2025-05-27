clc;
clearvars;
close all;

x = [2; 3; 8; 16; 32; 48; 64; 80];
y = [98.2; 91.7; 81.3; 64.0; 36.4; 32.6; 17.1; 11.3];
n = size(x, 1);

R = corrcoef(x, y);
r = R(1, 2);

covariance_matrix = cov(x, y);
s_xy = covariance_matrix(1, 2);
s_x = std(x);
s_y = std(y);

b1 = s_xy / s_x^2;
b0 = mean(y) - b1*mean(x);
y_estimator = b0 + b1 * x;
s_e = sqrt(((n-1) / (n-2)) * s_y^2 * (1 - r^2));

e = y - y_estimator;
e_star = e / s_e;

figure('Name', 'Scatter Plot');
scatter(x, y, 'blue');
hold on;
grid on;
plot(x, y_estimator, 'r');
xlabel('Distance in km');
ylabel('Percentage of Usage');
hold off;

figure('Name', 'Diagnostic Plot');
scatter(y_estimator, e_star);
hold on;
grid on;
title('Diagnostic Plot for Linear Regression');
yline(2, LineWidth=2,Color='red');
yline(-2, LineWidth=2,Color='red');
xlabel('Estimated y values');
ylabel('e^*');
hold off;


% Seems like the model is in this form y = a*x^b*ε => 
% y' = ln(y) = ln(a) + b * x' + ε', x'=ln(x) & ε'=ln(ε)

y_linear = log(y); % y' = ln(y)
x_linear = log(x); % x' = ln(x)

R1 = corrcoef(x_linear, y_linear);
r1 = R1(1, 2);

sx_linear = std(x_linear);
sy_linear = std(y_linear);
C = cov(x_linear, y_linear);
sxy_linear = C(1, 2);

b1_linear = sxy_linear / sx_linear ^ 2;
b0_linear = mean(y_linear) - b1_linear * mean(x_linear);

y_linear_estimator = b0_linear + b1_linear * x_linear;

se_linear = sqrt(((n-1) / (n-2)) * sy_linear^2 * (1 - r1^2));

e_linear = y_linear - y_linear_estimator;
e_star_linear = e_linear / se_linear;

y_estimator_1 = exp(y_linear_estimator);

figure('Name', 'Scatter Plot');
scatter(x_linear, y_linear);
hold on;
grid on;
plot(x_linear, y_linear_estimator, 'r');
xlabel('Distance in km');
ylabel('Percentage of Usage');
title('Linear');
hold off;

figure('Name', 'Scatter Plot');
scatter(x, y);
hold on;
grid on;
plot(x, y_estimator_1, 'r');
xlabel('Distance in km');
ylabel('Percentage of Usage');
title('Exponential');
hold off;

figure('Name', 'Diagnostic Plot');
scatter(y_linear_estimator, e_star_linear);
hold on;
grid on;
title('Diagnostic Plot for Linear Regression');
yline(2, LineWidth=2,Color='red');
yline(-2, LineWidth=2,Color='red');
xlabel('Estimated y values');
ylabel('e^*');
hold off;


% Seems like the model is in this form y = ae^(b*x) => 
% y' = ln(y) = ln(a) + b * x

y_linear_2 = log(y); % y' = ln(y)

R2 = corrcoef(x, y_linear);
r2 = R2(1, 2);

sx_linear_2 = std(x);
sy_linear_2 = std(y_linear_2);
C = cov(x, y_linear_2);
sxy_linear_2 = C(1, 2);

b1_linear_2 = sxy_linear_2 / sx_linear_2 ^ 2;
b0_linear_2 = mean(y_linear_2) - b1_linear_2 * mean(x);

y_linear_estimator_2 = b0_linear_2 + b1_linear_2 * x;

se_linear_2 = sqrt(((n-1) / (n-2)) * sy_linear_2^2 * (1 - r2^2));

e_linear_2 = y_linear_2 - y_linear_estimator_2;
e_star_linear_2 = e_linear_2 / se_linear_2;

y_estimator_2 = exp(y_linear_estimator_2);

figure('Name', 'Scatter Plot');
scatter(x, y_linear);
hold on;
grid on;
plot(x, y_linear_estimator_2, 'r');
xlabel('Distance in km');
ylabel('Percentage of Usage');
title('Linear');
hold off;

figure('Name', 'Scatter Plot');
scatter(x, y);
hold on;
grid on;
plot(x, y_estimator_2, 'r');
xlabel('Distance in km');
ylabel('Percentage of Usage');
title('Natural Logarithm');
hold off;

figure('Name', 'Diagnostic Plot');
scatter(y_linear_estimator_2, e_star_linear_2);
hold on;
grid on;
title('Diagnostic Plot for Linear Regression');
yline(2, LineWidth=2,Color='red');
yline(-2, LineWidth=2,Color='red');
xlabel('Estimated y values');
ylabel('e^*');
hold off;

%------------------------------ Question (b) ------------------------------
x_value = 25000;

y1 = b0 + b1*x_value;
y2 = exp(b0_linear + b1_linear * log(x_value));
y3 = exp(b0_linear_2 + b1_linear_2 * x_value);

fprintf('Linear Model : %.4f\n', y1);
fprintf('Power model : %.4f\n', y2);
fprintf('Log model : %.4f\n', y3);

