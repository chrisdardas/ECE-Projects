function dxdt = recursive_steepest(t, x, rd, phi_func, T, a1, a2, a3, b, k1, k2, rho, am, G)

    % State variables
    x1 = x(1); % position
    x2 = x(2); % velocity

    % Filtered regressor variables
    phiV = [x(3); x(4); x(5); x(6)];

    % Estimated parameters
    theta = [x(7); x(8); x(9); x(10)];

    % Reference trajectory and its shaping
    r_d = rd(t);
    phi_val = phi_func(t);

    z1 = (x1 - r_d) / phi_val;
    a = -k1 * T(z1);

    z2 = (x2 - a) / rho;
    u = -k2 * T(z2);

    % True system dynamics
    state1 = x2;
    state2 = -a1*x2 - a2*sin(x1) + a3*(x2^2)*sin(2*x1) + b*u;

    % Build real-time regressor phi(t)
    phi = [-x2; -sin(x1); (x2^2)*sin(2*x1); u];

    % Model estimate of \ddot{r}
    xdothat = theta' * phiV;

    % Estimation error (based on acceleration)
    e = state1 - xdothat;

    % Dynamics of filtered regressor
    phidot = -am * phiV + phi;

    % Parameter update law
    thetadot = - G * e * phiV;

    % Return derivatives (only states and estimators)
    dxdt = [state1; state2; phidot; thetadot];
end
