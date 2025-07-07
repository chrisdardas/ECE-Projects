function dxdt = dead_zone(t, x, u, A, B, gamma1, gamma2, am1, am2, omega)
    x_real = x(1:2);
    theta = x(3:8);
    xhat = x(9:10);
    u_t = feval(u, t);
    omega_t = feval(omega, t);
    omega0 = sqrt(omega_t(1)^2 + omega_t(2)^2) * 1.2;
    
    xdot = A * x_real + B * u_t + omega_t;
    
    xhatdot(1) = theta(1) * x_real(1) + theta(2) * x_real(2) + theta(5) * u_t + am1 * (x_real(1) - xhat(1));
    xhatdot(2) = theta(3) * x_real(1) + theta(4) * x_real(2) + theta(6) * u_t + am2 * (x_real(2) - xhat(2));
    xhatdot =  xhatdot';
    
    e1 = x_real(1) - xhat(1);
    e2 = x_real(2) - xhat(2);
    
    if e1 < -omega0
        d1 = omega0;
    elseif e1 > omega0
        d1 = - omega0;
    else
        d1 = - e1;
    end

    if e2 < -omega0
        d2 = omega0;
    elseif e2 > omega0
        d2 = - omega0;
    else
        d2 = - e2;
    end
    thetadot(1) = gamma1 * (e1 + d1) * x_real(1);
    thetadot(2) = gamma1 * (e1 + d1) * x_real(2);
    thetadot(5) = gamma1 * (e1 + d1) * u_t;
    
    thetadot(3) = gamma2 * (e2 + d2) * x_real(1);
    thetadot(4) = gamma2 * (e2 + d2) * x_real(2);
    thetadot(6) = gamma2 * (e2 + d2) * u_t ;
  
    thetadot = projection(theta, thetadot', gamma1, gamma2);
    dxdt = [xdot; thetadot; xhatdot];
end