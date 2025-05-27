clc;
clearvars;
close all;

n = 100;
y = zeros(1e5, 1);
len = length(y);

for i=1:len
    x = rand(n, 1);
    y(i,1) = mean(x);
end

figure('Name', 'Histogram');
histogram(y);
title('Histogram of Y');
xlabel('Mean Values of X');
ylabel('Count of Frequencies');

figure('Name', 'Fit the Curve');
histfit(y, 50, 'normal');
title('Fit the Normal Curve to Histogram');
xlabel('Mean Values of X');
ylabel('Count of Frequencies');