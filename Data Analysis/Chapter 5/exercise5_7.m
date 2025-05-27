clc;
clearvars;
close all;

data = [
1 0.76 110
2 0.86 105
3 0.97 100
4 1.11 95
5 1.45 85
6 1.67 80
7 1.92 75
8 2.23 70
9 2.59 65
10 3.02 60
11 3.54 55
12 4.16 50
13 4.91 45
14 5.83 40
15 6.94 35
16 8.31 30
17 10.00 25
18 12.09 20
19 14.68 15
20 17.96 10
21 22.05 5
22 27.28 0
23 33.89 -5
24 42.45 -10
25 53.39 -15
26 67.74 -20
27 86.39 -25
28 111.30 -30
29 144.00 -35
30 188.40 -40
31 247.50 -45
32 329.20 -50 ] ;

x = data(:, 2); % Resistance
y = data(:, 3) + 273.15; % Temperature in K
n = size(x, 1);
k = 5;

x = log(x);
y = 1./ y;

for i=1:k
    switch i
        case 1
            X = [ones(n, 1) x] ;
            b = regress(y, X);
        case 2
            X = [ones(n, 1) x x.^2];
            b = regress(y, X);
        case 3
            X = [ones(n, 1) x x.^2 x.^3];
            b = regress(y, X);
        case 4
            X = [ones(n, 1) x x.^2 x.^3 x.^4];
            b = regress(y, X);
        case 5
            X = [ones(n, 1) x x.^2 x.^3 x.^4 x.^5];
            b = regress(y, X);
    end

   y_estimator = X * b;
   e = y - y_estimator;
   se = sqrt((1/(n-k-1))*sum(e.^2, 1));
   e_star = e / se;
   R2 = 1 - sum(e.^2, 1) / sum((y-mean(y_estimator)).^2, 1);
   adjR2 = 1 - (n-1) / (n-k-1) * (sum(e.^2, 1) / sum((y-mean(y_estimator)).^2, 1));
   
   figure('Name', 'Scatter Plot');
   scatter(x, y);
   hold on;
   grid on;
   title('Variance Plot');
   xlabel('ln(R)');
   ylabel('1/T');
   plot(x, y_estimator, 'r');
   txt = sprintf('R^2: %.8f  adjR^2: %.8f', R2, adjR2);
   x_pos = min(x) + 0.1 * range(x); % Set X position for the text
   y_pos = max(y) - 0.1 * range(y); % Set Y position for the text
   text(x_pos, y_pos, txt, 'FontSize', 10, 'Color', 'blue');
   hold off;
   figure('Name', 'Diagnostic Plot');
   scatter(y_estimator, e_star);
   hold on;
   yline(2, LineWidth=2,Color='red');
   yline(-2, LineWidth=2,Color='red');
   xlabel('Estimated y values');
   ylabel('e^*');
   hold off;

end

% Steinhart-Hart
X = [ones(n, 1) x x.^3];

b = regress(y, X);
y_estimator = X * b;
e = y - y_estimator;
se = sqrt((1/(n-k-1))*sum(e.^2, 1));
e_star = e / se;
R2 = 1 - sum(e.^2, 1) / sum((y-mean(y_estimator)).^2, 1);
adjR2 = 1 - (n-1) / (n-k-1) * (sum(e.^2, 1) / sum((y-mean(y_estimator)).^2, 1));
   
figure('Name', 'Scatter Plot');
scatter(x, y);
hold on;
grid on;
title('Steinhart-Hart Plot');
xlabel('ln(R)');
ylabel('1/T');
plot(x, y_estimator, 'r');
txt = sprintf('R^2: %.8f  adjR^2: %.8f', R2, adjR2);
x_pos = min(x) + 0.1 * range(x); % Set X position for the text
y_pos = max(y) - 0.1 * range(y); % Set Y position for the text
text(x_pos, y_pos, txt, 'FontSize', 10, 'Color', 'blue');
hold off;

figure('Name', 'Diagnostic Plot');
scatter(y_estimator, e_star);
hold on;
yline(2, LineWidth=2,Color='red');
yline(-2, LineWidth=2,Color='red');
title('Steinhart-Hart model');
xlabel('Estimated y values');
ylabel('e^*');
hold off;


