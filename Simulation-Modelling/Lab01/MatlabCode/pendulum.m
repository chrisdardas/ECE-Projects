function dxdt = pendulum(t, x, m, L, c, u)
    g = 9.81;
    u_t = feval(u, t);  % Explicit function evaluation
    dxdt(1) = x(2);
    dxdt(2) = 1/(m * L^2) * (u_t - c*x(2) - m*g*L*x(1));

    dxdt = dxdt';
end