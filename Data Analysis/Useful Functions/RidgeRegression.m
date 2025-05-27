function [yhat, R2, adjR2, MSE, se_step, e_star] = RidgeRegression(X, y)
    
    n = size(X, 1);
    p = size(X, 2);
    Xc = X - repmat(mean(X), n, 1);
    yc = y - mean(y);
    [U, S, V] = svd(Xc, "econ");

    bOLSV = V * inv(S) * U'* yc;

    bOLSV = [mean(y) - mean(X)*bOLSV; bOLSV];
    yfitOLSV = [ones(n,1) X] * bOLSV; 
    resOLSV = y-yfitOLSV;
    RSSOLS = sum(resOLSV.^2);

    mu = RSSOLS/(n-p);
    sigmaV = diag(S);
    lambdaV = sigmaV.^2 ./ (sigmaV.^2 + mu);
    bRRV = V * diag(lambdaV) * inv(S) * U'* yc;
    bRRV = [mean(y) - mean(X)*bRRV; bRRV];
    % bRRV = ridge(yV,xM,mu,0);
    yhat = [ones(n,1) X] * bRRV; 

    e = y - yhat;
    se_step = sqrt(1/(n-p-1) * sum(e.^2));
    e_star = e / se_step;

    MSE = mean(e.^2);
    TSS = sum((y-mean(y)).^2);
    RSS = sum(e.^2);

    R2 = 1 - RSS/TSS;

    adjR2 = 1 - (n-1)/(n-p-1)*(1-R2);
end