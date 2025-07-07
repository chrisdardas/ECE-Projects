function dxdt = recursive_controller_SP(t, x, rd, phi, T, a1, a2, a3, b, k1, k2, rho, am, G)

    x1 = x(1);
    x2 = x(2);
    xhat1 = x(3);
    xhat2 = x(4);
    a1_hat = x(5);
    a2_hat = x(6);
    a3_hat = x(7);
    b_hat  = x(8);
    rd_t = feval(rd, t); 
    phi_t = feval(phi, t);

    z1 = (x1 - rd_t) / phi_t;
    a = -k1 * T(z1);

    z2 = (x2 - a) / rho ;
    u = -k2 * T(z2);

    if abs(x1 - rd_t) >= phi_t
        error('|x1 - rd(t)| = %6.3f is not less than phi(t) = %6.3f at time t = %6.3f', abs(x1 - rd_t), phi_t, t);
    end
    if abs(x2 - a) >= rho
        error('|x2 - a| = %6.3f is not less than rho = %6.3f at time t = %6.3f', abs(x2 - a), rho, t);
    end
    state1 = x2;
    state2 = -a1*x2 - a2*sin(x1) + a3*x2^2*sin(2*x1) + b * u;

    xhatdot1 = x2 + am * (xhat1 - x1);
    xhatdot2 = -a1_hat * x2 - a2_hat * sin(x1) + a3_hat * x2^2 * sin(2*x1) + b_hat * u  + am * (xhat2 - x2);
    xhatdot = [xhatdot1; xhatdot2];

    % e1 = x1 - xhat1;
    e2 = x2 - xhat2;

    a1_hat_dot =  - G(1) * e2 * x2;
    a2_hat_dot =  - G(2) * e2 * sin(x1);
    a3_hat_dot =  - G(3) * e2 * (x2^2 * sin(2*x1));
    b_hat_dot  =  + G(4) * e2 * u;

    dxdt = [state1; state2; xhatdot; a1_hat_dot; a2_hat_dot; a3_hat_dot; b_hat_dot];
end