function [] = function5_2(n, L, rho, mX, mY, sigmaX, sigmaY, alpha, squared, M)


if squared == 1
    rho = rho^2;
end

mu = [mX mY];
Sigma = [sigmaX^2 rho*sigmaX*sigmaY; rho*sigmaX*sigmaY sigmaY^2];
lower_limit = L*alpha*0.5;
upper_limit = L*(1 - alpha/2);

R = mvnrnd(mu, Sigma, n);
X = R(:, 1);
Y = R(:,2);
rejected = 0;

for j=1:M
    if squared == 1
        X = X.^2;
        Y = Y.^2;
    end
    
    Cov0 = corrcoef(X, Y);
    r0 = Cov0(1, 2);
    
    tc0 = r0 * sqrt((n-2) / (1 - r0^2));
    
    t_stats = zeros(L, 1);
    for i=1:L
        idX = randperm(n);
        X_new = R(idX, 1);
        if squared == 1
            X_new = X_new.^2;
        end
    
        Cov = corrcoef(X_new, Y);
    
        r = Cov(1, 2);
        t_stats(i) = r * sqrt((n-2) / (1 - r^2));
    end
    
    t_stats = sort(t_stats, 1);
    
    t_lower = t_stats(lower_limit);
    t_upper = t_stats(upper_limit);
    
    if (tc0 < t_lower || tc0 > t_upper)
        rejected = rejected + 1;
    end
end

fprintf("The Null Hypothesis is rejected with %.2f%% percentage\n", rejected);
end