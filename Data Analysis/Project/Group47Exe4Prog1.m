clc;
clearvars;
close all;

data = readtable('TMS.xlsx');
alpha = 0.05;
mask = (data.TMS == 1);

preTMS = data.preTMS(mask);
postTMS = data.postTMS(mask);

Setup = data.Setup(mask);

L=1e4;

lower_bound = fix(L*alpha/2);
upper_bound = fix(L*(1-alpha/2));

p0 = zeros(1,6);
t0 = zeros(1,6);
h0_parametric = zeros(1,6);
h0_randomized = zeros(1,6);

fig = figure();
for i = 1:6
    X = preTMS(Setup == i);
    Y = postTMS(Setup == i);
    subplot(2,3,i);
    scatter(X,Y);
    title(sprintf("Setup %d",i));
    xlabel("preTMS");
    ylabel("postTMS");
    [p0(i),t0(i)] = Group47Exe4Func1(X,Y);
    X_original = X;

    if(p0(i) < alpha)
        h0_parametric(i) = 1;
    else
        h0_parametric(i) = 0;
    end

    t = zeros(1,L);

    for j=1:L
        indx = randperm(size(X,1));
        X = X_original(indx);
        [~,t(j)] = Group47Exe4Func1(X,Y);
    end
    t = sort(t);
    if(t0(i) < t(lower_bound) || t0(i) > t(upper_bound))
       h0_randomized(i) = 1;
    else
        h0_randomized(i) = 0;
    end
end
sgtitle("Scatter plots for each Setup");


X = preTMS;
Y = postTMS;

fig = figure();
scatter(X,Y);
xlabel("preTMS");
ylabel("postTMS");
title("Scatter plot for all Setups");

[p_val_all,t_val_all] = Group47Exe4Func1(X,Y);
X_original = X;

if(p_val_all < alpha)
    h_val_all = 1;
else
    h_val_all = 0;
end

t = zeros(1,L);

for j=1:L
    indx = randperm(size(X,1));
    X = X_original(indx);
    [~,t(j)] = Group47Exe4Func1(X,Y);
end
t = sort(t);
if(t_val_all < t(lower_bound) || t_val_all > t(upper_bound))
   h_val_all_rand = 1;
else
    h_val_all_rand = 0;
end

% Considering the parametric and the randomized control for each setup we
% can conclude that we can not reject the null Hypothesis H0 that the 
% correlation coefficient of preTMS and postTMs is zero. That conclusion 
% stands for each one of the six setups provided, as well as all together.This suggests that there 
% is insufficient evidence to claim a significant correlation between 
% preTMS and postTMS for any setup.The parametric method is generally more 
% reliable due to its established statistical foundation and efficiency. 
% However, it assumes normality and linearity in the data. The parametric
% results provide stronger evidence against rejecting ​H0, while the 
% randomized test supports this conclusion.
% In general we can be more sure about the results coming
% from the parametric control rather than from the randomized control.