function [yhat, R2, adjR2, MSE, var_e] = polyRegress(X, y, k)
    n = size(X, 1);
    xM = [ones(n, 1)];

    for i=1:k
        xM = [xM X.^(i)];
    end
   
    b = regress(y, xM);
    yhat = xM * b;
    e = y - yhat;

    var_e = 1/(n-k-1)*sum(e.^2);
    muy = mean(y);

    MSE = mean(e.^2);
    TSS = sum((y-muy).^2);
    RSS = sum(e.^2);

    R2 = 1 - RSS/TSS;

    adjR2 = 1 - (n-1)/(n-k-1)*(1-R2);
end