function [p_param, h_perm] = PermutationCheck(X, Y, L, alpha)


    lower_limit = L*alpha*0.5;
    upper_limit = L*(1 - alpha/2);
    n = size(X, 1);
        
    Cov0 = corrcoef(X, Y);
    r0 = Cov0(1, 2);
    
    t0 = r0 * sqrt((n-2) / (1 - r0^2));

    p_param = 2 * (1-tcdf(abs(t0), n-2));
    
    t_stats = zeros(L, 1);
    for i=1:L
        idX = randperm(n);
        X_new = X(idX, 1);
    
        Cov = corrcoef(X_new, Y);
    
        r = Cov(1, 2);
        t_stats(i) = r * sqrt((n-2) / (1 - r^2));
    end
    
    t_stats = sort(t_stats, 1);


    
    t_lower = t_stats(lower_limit);
    t_upper = t_stats(upper_limit);
    
    if (t0 < t_lower || t0 > t_upper)
        h_perm = 1;
    else
        h_perm = 0;
    end
end