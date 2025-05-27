clc;
clearvars;
close all;

T = readtable('physical.txt');
y = T.Mass;
X = T.Variables;
X = X(:, 2:end);

n = size(X, 1);
k = size(X, 2);
xM = [ones(n, 1) X];

% PLS regression
[~, ~, ~, ~, b_PLS, PCTVAR]=plsregress(X, y);
yPLS = [ones(n, 1) X] * b_PLS;
e_PLS = y - yPLS;
se_PLS = (1/(n-k-1) * sum(e_PLS.^2));
e_PLS_star = e_PLS / se_PLS;

% PCR regression
X_center = X - repmat(mean(X), n, 1);
[U, S, V] = svd(X_center, 'econ');
eigenvalues = diag(S).^2/(n-1);
var_perc = 100 * cumsum(eigenvalues) / sum(eigenvalues);
figure("Name", "Expected Variance Percentage");
plot(1:size(eigenvalues), var_perc, 'r');
title("Expected Variance Percentage");
grid on;
xlabel("Index");
ylabel("Variance Percentage");
d = find(var_perc >= 90, 1) ;
V_d = V(:, 1:d);
U_d = U(:, 1:d);
S_d = S(1:d, 1:d);

b_PCR = V_d * inv(S_d) * U_d' * (y-mean(y));
b_PCR = [mean(y) - mean(X)*b_PCR; b_PCR];
yPCR = xM * b_PCR;
e_PCR = y - yPCR;
se_PCR = sqrt(1/(n-k-1) * (sum(e_PCR.^2)));
e_PCR_star = e_PCR / se_PCR;
%% Ridge regression
% bOLSV = vM * inv(sigmaM) * uM'* ycV;
% bOLSV = [my - mxV*bOLSV; bOLSV];
% yfitOLSV = [ones(n,1) xM] * bOLSV; 
% resOLSV = yV-yfitOLSV;
% RSSOLS = sum(resOLSV.^2);
% [u2M,sigma2M,v2M] = svd(xcM);
% mu = (1/(n-p)) * sum((u2M(:,p+1:n)'*ycV).^2);
% mu = RSSOLS/(n-p);
% sigmaV = diag(sigmaM);
% lambdaV = sigmaV.^2 ./ (sigmaV.^2 + mu);
% bRRV = vM * diag(lambdaV) * inv(sigmaM) * uM'* ycV;
% bRRV = [my - mxV*bRRV; bRRV];
% % bRRV = ridge(yV,xM,mu,0);
% yfitRRV = [ones(n,1) xM] * bRRV; 
% resRRV = yfitRRV - yV;     % Calculate residuals
% RSSRR = sum(resRRV.^2);

% Ridge Regression

l = 0:1e-3:5e-1;
bRRv = ridge(y, X, l, 0);
b_RR = bRRv(:, 1);

yRR = xM * b_RR;

for i=1:length(l)
    y_temp = xM * bRRv(:, i);

    if(sqrt(sum(y-y_temp)) < sqrt(sum(y-yRR)))
        b_RR = bRRv(:, i);
        yRR = xM * b_RR;
    end
end

e_RR = y - yRR;
se_RR = sqrt(1/(n-k-1) * sum(e_RR.^2));
e_RR_star = e_RR / se_RR;

% LASSO regression

[bLASSOv, FitInfo] = lasso(X, y, 'CV', 10);
idxLamdaMinMSE = FitInfo.IndexMinMSE;
bLASSOIntercept = FitInfo.Intercept(idxLamdaMinMSE);
b_LASSO = bLASSOv(:, idxLamdaMinMSE);

yLASSO = bLASSOIntercept + X * b_LASSO;
e_LASSO = y - yLASSO;
se_LASSO = sqrt(1/(n-k-1) * (sum(e_LASSO.^2)));
e_LASSO_star = e_LASSO / se_LASSO;

figure('Name', 'PCR');
title('Diagnostic Plot');
scatter(yPCR, e_PCR_star, 10);
hold on;
yline(2, 'LineWidth', 2, 'Color', 'red');
yline(-2, 'LineWidth', 2, 'Color', 'red');
xlabel('yhat');
ylabel('e^*');
hold off;
grid on;

figure('Name', 'PLS');
title('Diagnostic Plot');
scatter(yPLS, e_PLS_star, 10);
hold on;
yline(2, 'LineWidth', 2, 'Color', 'red');
yline(-2, 'LineWidth', 2, 'Color', 'red');
xlabel('yhat');
ylabel('e^*');
hold off;
grid on;

figure('Name', 'Ridge');
title('Diagnostic Plot');
scatter(yRR, e_RR_star, 10);
hold on;
yline(2, 'LineWidth', 2, 'Color', 'red');
yline(-2, 'LineWidth', 2, 'Color', 'red');
xlabel('yhat');
ylabel('e^*');
hold off;
grid on;

figure('Name', 'LASSO');
title('Diagnostic Plot');
scatter(yLASSO, e_LASSO_star, 10);
hold on;
yline(2, 'LineWidth', 2, 'Color', 'red');
yline(-2, 'LineWidth', 2, 'Color', 'red');
xlabel('yhat');
ylabel('e^*');
hold off;
grid on;
