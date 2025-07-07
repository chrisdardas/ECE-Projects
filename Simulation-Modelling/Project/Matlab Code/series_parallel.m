function dxdt = series_parallel(t, x, u, A, B, gamma1, gamma2, am1, am2)

    x_real = x(1:2);
    theta = x(3:8);
    xhat = x(9:10);
    u_t = feval(u, t);
    
    xdot = A * x_real + B * u_t;
    
    xhatdot(1) = theta(1) * x_real(1) + theta(2) * x_real(2) + theta(5) * u_t + am1 * (x_real(1) - xhat(1));
    xhatdot(2) = theta(3) * x_real(1) + theta(4) * x_real(2) + theta(6) * u_t + am2 * (x_real(2) - xhat(2));
    xhatdot =  xhatdot';
    
    e1 = x_real(1) - xhat(1);
    e2 = x_real(2) - xhat(2);
    
    
    thetadot(1) = gamma1 * e1 * x_real(1);
    thetadot(2) = gamma1 * e1 * x_real(2);
    thetadot(5) = gamma1 * e1 * u_t;
    
    thetadot(3) = gamma2 * e2 * x_real(1);
    thetadot(4) = gamma2 * e2 * x_real(2);
    thetadot(6) = gamma2 * e2 * u_t;

    thetadot = projection(theta, thetadot', gamma1, gamma2);
    
    dxdt = [xdot; thetadot; xhatdot];
end