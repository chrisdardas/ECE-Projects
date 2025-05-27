clc;
close all;
clearvars

% h1 := the height where we drop the ball
% h2 := the height it reaches when it bounces

%------------------------------ Question (a) ------------------------------
n = 5; % number of repetitions
M = 1000;
alpha = 0.05;
h1 = 100;
h2 = [60;54;58;60;56];
e1 = sqrt(h2 / h1);
e_expected = 0.76;

eMean = mean(e1);
eVar  = var(e1);
eStd  = std(e1);
t = tinv(1-alpha/2, n-1);
systemic_fault = eMean - e_expected;
%==========================================================================
ci(1) =  eMean - t*eStd/sqrt(n);
ci(2) =  eMean + t*eStd/sqrt(n);
[~, ~, ci_2] = ttest(e1,e_expected,"Alpha",alpha);
next(1) = eMean - t*eStd;
next(2) = eMean + t*eStd;
fprintf("Systemic Fault for e is : %.4f\n", systemic_fault);
fprintf("Uncertainty of next value is in the interval : [%.3f, %.3f]\n", next(1), next(2));
fprintf("Uncertainty of mean value is in the interval : [%.3f, %.3f]\n", ci(1), ci(2));
%==========================================================================


%------------------------------ Question (b) ------------------------------
m2 = 58;
sigma2 = 2;
h2 = m2 + sigma2*randn(n, M);
mean_values_h2 = mean(h2)';
std_values_h2  = std(h2)';

e2 = sqrt(h2 / h1);

me = sqrt(m2 / h1);
sigma_e = sqrt(1/h1) * 0.5 * (1 / sqrt(m2)) * sigma2;
mean_values_e2 = mean(e2)';
std_values_e2  = std(e2)';

figure('Name','Histogram of Mean Values for h2');
histogram(mean_values_h2);
xline(m2,LineWidth=2,Color="red");
title("Mean Values of H2");
xlabel("Mean Values");
ylabel("Count of Frequencies");


figure('Name', 'Histogram of Standard Deviation for h2');
histogram(std_values_h2);
xline(sigma2, LineWidth=2, Color="red");
title("Standard Deviation of H2");
xlabel("Standard Deviation values");
ylabel("Count of Frequencies");

figure('Name','Histogram of Mean Values for e2');
histogram(mean_values_e2);
xline(me,LineWidth=2,Color="red");
title("Mean Values of E2");
xlabel("Mean Values");
ylabel("Count of Frequencies");


figure('Name', 'Histogram of Standard Deviation for e2');
histogram(std_values_e2);
xline(sigma_e, LineWidth=2, Color="red");
title("Standard Deviation of E2");
xlabel("Standard Deviation values");
ylabel("Count of Frequencies");

%------------------------------ Question (c) ------------------------------
h1 = [80;100;90;120;95];
h2 = [48;60;50;75;56];

mean_h1 = mean(h1);
std_h1  = std(h1);
mean_h2 = mean(h2);
std_h2  = std(h2);

ci_h1(1) = mean_h1 - t*std_h1;
ci_h1(2) = mean_h1 + t*std_h1;
fprintf("Uncertainty of next value is in the interval : [%.3f, %.3f]\n", ci_h1(1), ci_h1(2));

ci_h2(1) = mean_h2 - t*std_h2;
ci_h2(2) = mean_h2 + t*std_h2;
fprintf("Uncertainty of next value is in the interval : [%.3f, %.3f]\n", ci_h2(1), ci_h2(2));

e = sqrt(h2 ./ h1);
mean_e = mean(e);
std_e  = std(e);
var_e  = var(e);
independent = false;

if independent
    m_e = sqrt(mean_h2 / mean_h1);
    sigma_e = sqrt( (-0.5*(mean_h1)^(-3/2)*sqrt(mean_h2))^2 * std_h1^2 + ...
        ((1/sqrt(mean_h1)) * 0.5 * (1/sqrt(mean_h2))^2) * std_h2^2);
else
    r = corrcoef(h1, h2);
    sigma_e = sqrt( (-0.5*(mean_h1)^(-3/2)*sqrt(mean_h2))^2 * std_h1^2 + ...
        ((1/sqrt(mean_h1)) * 0.5 * (1/sqrt(mean_h2))^2) * std_h2^2 + ...
        -0.5 * (1/mean_h1)^2 * r(1,2));
end


