function dxdt = sigma_modification(t, x, u, A, B, gamma1, gamma2, am1, am2, omega, sigma)

    x_real = x(1:2);
    theta = x(3:8);
    xhat = x(9:10);
    u_t = feval(u, t);
    omega_t = feval(omega, t);
    
    xdot = A * x_real + B * u_t + omega_t;
    
    xhatdot(1) = theta(1) * x_real(1) + theta(2) * x_real(2) + theta(5) * u_t + am1 * (x_real(1) - xhat(1));
    xhatdot(2) = theta(3) * x_real(1) + theta(4) * x_real(2) + theta(6) * u_t + am2 * (x_real(2) - xhat(2));
    xhatdot =  xhatdot';
    
    e1 = x_real(1) - xhat(1);
    e2 = x_real(2) - xhat(2);
    
    
    thetadot(1) = gamma1 * e1 * x_real(1) - sigma * gamma1 * theta(1);
    thetadot(2) = gamma1 * e1 * x_real(2) - sigma * gamma1 * theta(2);
    thetadot(5) = gamma1 * e1 * u_t - sigma * gamma1 * theta(5);
    
    thetadot(3) = gamma2 * e2 * x_real(1) - sigma * gamma2 * theta(3);
    thetadot(4) = gamma2 * e2 * x_real(2) - sigma * gamma2 * theta(4);
    thetadot(6) = gamma2 * e2 * u_t - sigma * gamma2 * theta(6);

    thetadot = projection(theta, thetadot', gamma1, gamma2);
     
    dxdt = [xdot; thetadot; xhatdot];
end