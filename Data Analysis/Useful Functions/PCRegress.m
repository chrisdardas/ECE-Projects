function [yhat, R2, adjR2, MSE, se, e_star, eigenvalues] = PCRegress(X, y, perc)
    
    n = size(X, 1);
    p = size(X, 2);
    yc = y - mean(y);
    Xc  = X - repmat(mean(X), n, 1);
    size(Xc)

    [U, S, V] = svd(Xc, "econ");

    eigenvalues = diag(S).^2/(n-1);
    var_perc = 100 * cumsum(eigenvalues) / sum(eigenvalues);
    d = find(var_perc >= perc, 1);
   
    lambdas = zeros(p, 1);
    lambdas(1:d) = 1;

    bPCR = V * diag(lambdas) * inv(S) * U' * yc;

    bPCR = [mean(y) - mean(X)*bPCR; bPCR];
    yhat = [ones(n, 1) X] * bPCR;

    e = y - yhat;
    se = sqrt(1/(n-d-1) * sum(e.^2));
    e_star = e / se;

    MSE = mean(e.^2);
    TSS = sum((y-mean(y)).^2);
    RSS = sum(e.^2);

    R2 = 1 - RSS/TSS;
    adjR2 = 1 - (n-1)/(n-d-1)*(1-R2);
end