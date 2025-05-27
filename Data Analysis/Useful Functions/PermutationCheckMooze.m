function [p_param,p_val_perm] = PermutationCheckMooze(X,Y,L)
    n=size(X,1);

    C = cov(X,Y);
    s_xy = C(1,2);
    s_x = std(X);
    s_y = std(Y);

    rho = s_xy/(s_x*s_y);
    tau = rho*sqrt((n-2)/(1-rho^2));

    p_param = 2 * (1-tcdf(abs(tau),n-2)); %checking if the Hypothesis rho = 0 can be rejected.
    X_original = X;


    t = zeros(1,L);
    h0_randomized = NaN(1,L+1);
    t(1) = tau;
    for j=1:L
        indx = randperm(size(X,1));
        X = X_original(indx);
        C = cov(X,Y);
        s_xy = C(1,2);
        s_x = std(X);
        s_y = std(Y);
    
        rho = s_xy/(s_x*s_y);
        t(j+1) = rho*sqrt((n-2)/(1-rho^2));
    end
    [sorted,indx] = sort(t);
    rank = find(indx == 1,1);
    if(rank<L/2)
        p_val_perm = 2*rank/(L+1);
    else
        p_val_perm = 2*(1-rank/(L+1));
    end
end