clc;
clearvars;
close all;

n = 1000;
l = 5;
sigma_e = 5;
mu = [0.2, 5, 2, 4.3, 2.3];
beta = [0, 2, 0, -3, 0];
epsilon = 0 + sigma_e*randn(n, 1);

X = exprnd(repmat(mu, n, 1));

y = X * beta' + epsilon;
% OLS
[U, S, V] = svd(X - repmat(mean(X), n, 1), "econ");
b_OLS = V * inv(S) * U' * (y-mean(y));
b_OLS = [mean(y) - mean(X) * b_OLS; b_OLS];
y_fit_OLS = [ones(n, 1) X] * b_OLS;
e_OLS = y - y_fit_OLS;
se_OLS = sqrt(1/(n-l-1) * (sum(e_OLS.^2)));
e_OLS_star = e_OLS / se_OLS;

% PLS
[~,~,~,~,b_PLS,PCTVAR] = plsregress(X, y);
y_fit_PLS = [ones(n, 1) X] * b_PLS; 
e_PLS = y - y_fit_PLS;
se_PLS = sqrt(1/(n-l-1) * (sum(e_PLS.^2)));
e_PLS_star = e_PLS / se_PLS;

% PCR 
X_center = X - repmat(mean(X), n, 1);
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
b_PCR = [mean(y) - mean(X) * b_PCR; b_PCR];
y_fit_PCR = [ones(n,1) X] * b_PCR;
e_PCR = y - y_fit_PCR;
se_PCR = sqrt(1 / (n-l-1) * (sum(e_PCR.^2)));
e_PCR_star = e_PCR / se_PCR;

% Ridge Regression
k = 0:1e-3:5e-1;
b_RRv = ridge(y,X,k,0);

idx = -1;
bRR = b_RRv(:,1);
y_fit_RR = [ones(n,1) X]*bRR;
for i=1:length(k)
 yfittemp = [ones(n,1) X]*b_RRv(:,i);
 if(sum(sqrt(y-yfittemp)) < sum(sqrt(y-y_fit_RR)))
    bRR = b_RRv(:,i);
    y_fit_RR = yfittemp;
    idx = i;
 end
end

e_RR = y - y_fit_RR;
se_RR = sqrt(1/(n-l-1) * (sum(e_RR.^2)));
e_RR_star = e_RR / se_RR;

% LASSO
[b_LASSOv, FitInfo] = lasso(X, y, 'CV', 10);
idxLamdaMinMSE = FitInfo.IndexMinMSE;
bLASSOIntercept = FitInfo.Intercept(idxLamdaMinMSE);

b_LASSO = b_LASSOv(:, idxLamdaMinMSE);
y_fit_LASSO = bLASSOIntercept + X * b_LASSO;
e_LASSO = y - y_fit_LASSO;
se_LASSO = sqrt(1/(n-l-1) * sum(e_LASSO.^2));
e_LASSO_star = e_LASSO / se_LASSO;

figure('Name', 'Comparison with OLS');
nexttile;
scatter(y, y_fit_OLS);
title('OLS');
xlabel('y');
ylabel('yOLS');
grid on;
nexttile;
title('Diagnostic Plot');
scatter(y_fit_OLS, e_OLS_star, 10);
hold on;
yline(2, 'LineWidth', 2, 'Color', 'red');
yline(-2, 'LineWidth', 2, 'Color', 'red');
xlabel('yhat');
ylabel('e^*');
hold off;
grid on;

figure('Name', 'Comparison with PCR');
nexttile
scatter(y, y_fit_PCR);
title('PCR');
xlabel('y');
ylabel('yPCR');
grid on;
nexttile;
title('Diagnostic Plot');
scatter(y_fit_PCR, e_PCR_star, 10);
hold on;
yline(2, 'LineWidth', 2, 'Color', 'red');
yline(-2, 'LineWidth', 2, 'Color', 'red');
xlabel('yhat');
ylabel('e^*');
hold off;
grid on;

figure('Name', 'Comparison with PLS');
nexttile;
scatter(y, y_fit_PLS);
title('PLS');
xlabel('y');
ylabel('yPLS');
grid on;
nexttile;
title('Diagnostic Plot');
scatter(y_fit_PLS, e_PLS_star, 10);
hold on;
yline(2, 'LineWidth', 2, 'Color', 'red');
yline(-2, 'LineWidth', 2, 'Color', 'red');
xlabel('yhat');
ylabel('e^*');
hold off;
grid on;

figure('Name', 'Comparison with Ridge');
nexttile;
scatter(y, y_fit_RR);
title('Ridge');
xlabel('y');
ylabel('yRR');
grid on;
nexttile;
title('Diagnostic Plot');
scatter(y_fit_RR, e_RR_star, 10);
hold on;
yline(2, 'LineWidth', 2, 'Color', 'red');
yline(-2, 'LineWidth', 2, 'Color', 'red');
xlabel('yhat');
ylabel('e^*');
hold off;
grid on;

figure('Name', 'Comparison with LASSO');
nexttile;
scatter(y, y_fit_LASSO);
title('LASSO');
xlabel('y');
ylabel('yLASSO');
grid on;
nexttile;
title('Diagnostic Plot');
scatter(y_fit_LASSO, e_LASSO_star, 10);
hold on;
yline(2, 'LineWidth', 2, 'Color', 'red');
yline(-2, 'LineWidth', 2, 'Color', 'red');
xlabel('yhat');
ylabel('e^*');
hold off;
grid on;