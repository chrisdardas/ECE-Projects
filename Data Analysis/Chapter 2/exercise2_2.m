clc;
clearvars;
close all;

x = rand(1000, 1); % Samples from Uniform Distribution
lamda = 1;
y = -1 / lamda * log(1 - x); % Creating Exponential Distribution from Samples 

data = linspace(0, 7, 1000);
pdf = exppdf(data, lamda); % Creating Exponential Distribution from Data

figure('Name','Histogram');
title('Histogram Created From Uniform Distribution');
histogram(y); % Plotting the Histogram of Y
%xlim([0, 10]);
xlabel('X Values');
ylabel('Count');
grid on;



figure('Name', 'Fitting');
% Plotting the Normalized Histogram
% Now its values represent density estimate instead of count of appereances
% Now the area under the bars equals to 1 representing a pdf
title('Fitting Of Exponential To Histogram')
histogram(y, 'Normalization','pdf') 
hold on;
plot(data, pdf, 'r');
legend('Normalized Histogram', 'PDF of Exponential Distribution')
xlabel('X values');
ylabel('f_x(x)');
%xlim([0, 10]);
grid on;
