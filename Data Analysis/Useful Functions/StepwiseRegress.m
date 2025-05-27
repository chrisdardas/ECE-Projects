function [yhat, R2, adjR2, MSE, se_step, e_star] = StepwiseRegress(X, y)
    
    % Stepwise Model
    n = size(X, 1);
    [b_step, s_e, pval, finalmodel, stats] = stepwisefit(X, y);
    % b0 = stats.intercept;
    % b_step(~finalmodel) = 0;
    % b_step = [b0; b_step];
    % yhat = [ones(n,1) X] * b_step;
    k = sum(finalmodel);
    yhat = stats.intercept + X(:, finalmodel)*b_step(finalmodel);
    muy = mean(y);
    e = y - yhat;
    se_step = sqrt(1/(n-k-1) * sum(e.^2));
    e_star = e / se_step;

    MSE = mean(e.^2);
    TSS = sum((y-muy).^2);
    RSS = sum(e.^2);

    R2 = 1 - RSS/TSS;

    adjR2 = 1 - (n-1)/(n-k-1)*(1-R2);
end