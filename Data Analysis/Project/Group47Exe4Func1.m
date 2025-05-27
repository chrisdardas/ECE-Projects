function [p,tau] = Group47Exe4Func1(X,Y)

    n=size(X,1);

    C = cov(X,Y);
    s_xy = C(1,2);
    s_x = std(X);
    s_y = std(Y);

    rho = s_xy/(s_x*s_y);
    tau = rho*sqrt((n-2)/(1-rho^2));

    p = 2 * (1-tcdf(abs(tau),n-2)); %checking if the Hypothesis rho = 0 can be rejected.
end

