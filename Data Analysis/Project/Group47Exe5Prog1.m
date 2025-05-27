clc;
clearvars
close all;

data = readtable("TMS.xlsx");
mask = (data.TMS == 0);

EDduration = data.EDduration(mask);
Setup = data.Setup(mask);

n = 10;
R2 = zeros(n, 1);
adjR2 = zeros(n, 1);

for i=1:n
    [R2(i), adjR2(i)] = Group47Exe5Func1(Setup, EDduration, i, false);
end

% We conclude that the model of linear regression is not ideal, since the
% two metrics printed are very low. 
% We will try calculating the same metrics with models of higher power and
% see if the fitting is better then


fprintf("Coeffiecient of multiple determination R^2 : %.4f \t adjusted coefficient : %.4f\n", R2(1), adjR2(1));

figure();
x = 1:1:n;
scatter(x, R2, 'blue');
title("Coeffiecient of multiple determination R^2 and adjR^2");
hold on;
scatter(x, adjR2, 'red');

% We can observe that a regression model of power 5 is the ideal model for
% this case. So it seems that using a higher power polynomial regression
% model helped us improve the fitting of the data. However, it is still
% important to note that the fitting is still not considered great.

EDduration = data.EDduration(~mask);
Setup = data.Setup(~mask);

R2 = zeros(n, 1);
adjR2 = zeros(n, 1);

for i=1:n
    [R2(i), adjR2(i)] = Group47Exe5Func1(Setup, EDduration, i, false);
end

fprintf("Coeffiecient of multiple determination R^2 : %.4f \t adjusted coefficient : %.4f\n", R2(1), adjR2(1));

% We conclude that the model of linear regression is not ideal, since the
% two metrics printed are very low. 

% The results are different from the case without TMS and the model seems
% to be a bit better in this case. However, the fitting is still very bad.

% As previously we try polynomial models of different power to see if we
% will get a better fit

figure();
x = 1:1:n;
scatter(x, R2, 'blue');
title("Coeffiecient of multiple determination R^2 and adjR^2");
hold on;
scatter(x, adjR2, 'red');

% Once again the model of polynomial with degree 5 is the best one we got.
% It is also performing better than its equivalent without TMS. We conclude
% that even though the models are not very good, the EDduration with TMS
% can be better approximated than the one without, with a polynomial model
% of degree 5.