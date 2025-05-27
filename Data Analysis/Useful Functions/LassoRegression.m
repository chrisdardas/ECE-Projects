function [yhat, R2, adjR2, MSE, se_step, e_star] = LassoRegression(X, y)

    n = size(X, 1);
    muy = mean(y);
    R2_vec = zeros(20,1);
    adjR2_vec = zeros(20,1);
    lambdas = 0:0.05:1;
    indx = 1;
    for i=lambdas
        [bLASSOv, FitInfo] = lasso(X, y,"CV",10,'Lambda',i);
        min_er_indx = FitInfo.IndexMinMSE;
        Intercept = FitInfo.Intercept(min_er_indx);
        bLASSO = bLASSOv(:,min_er_indx);
        
        y_LASSO = Intercept + X*bLASSO;
        
        mask3 = (bLASSO ~= 0);
        k2 = sum(mask3);
        
        e_LASSO = y_LASSO-y;
        
        R2_LASSO = 1-sum((y-y_LASSO).^2)/sum((y-mean(y)).^2);
        adjR2_LASSO = 1-(n-1)/(n-k2-1)*(1-R2_LASSO);
        
        R2_vec(indx) = R2_LASSO;
        adjR2_vec(indx) = adjR2_LASSO;
        indx = indx + 1;
    end
    
    [adjR2_LASSO,max_r2_indx] = max(adjR2_vec);
    lambda = lambdas(max_r2_indx);
    
    [bLASSOv, FitInfo ] = lasso(X, y,"CV",10,'Lambda',lambda);
    min_er_indx = FitInfo.IndexMinMSE;
    Intercept = FitInfo.Intercept(min_er_indx);


    bLASSO = bLASSOv(:,min_er_indx);
    mask3 = (bLASSO ~= 0);
    k = sum(mask3);
    
    yhat = Intercept + X*bLASSO;
    
    e = y - yhat;
    se_step = sqrt(1/(n-k-1) * sum(e.^2));
    e_star = e / se_step;

    MSE = mean(e.^2);
    TSS = sum((y-muy).^2);
    RSS = sum(e.^2);

    R2 = 1 - RSS/TSS;

    adjR2 = 1 - (n-1)/(n-k-1)*(1-R2);

end