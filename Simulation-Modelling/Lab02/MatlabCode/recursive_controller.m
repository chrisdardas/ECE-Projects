function dxdt = recursive_controller(t, x, rd, phi, T, a1, a2, a3, b, k1, k2, rho)
    x1 = x(1);
    x2 = x(2);
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

    dxdt = [state1; state2];
end