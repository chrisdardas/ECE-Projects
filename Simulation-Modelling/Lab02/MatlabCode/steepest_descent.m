function dxdt = steepest_descent(t, x, u, m, k, b, am, G)

    x1 = x(1); % x 
    x2 = x(2); % xdot

    % phi values 
    phi1 = x(3); 
    phi2 = x(4);
    phi3 = x(5);
    phi = [phi1; phi2; phi3];
  
    % theta values
    theta1 = x(6);
    theta2 = x(7);
    theta3 = x(8);
    theta = [theta1; theta2; theta3];

    u_t = feval(u, t);

    state1 = x2;
    state2 = 1/m * (u_t - b*x2 -k*x1);

    xdothat = theta' * phi;
    e = x2 - xdothat;

    phidot1 = -am * phi1 + x2;
    phidot2 = -am * phi2 + x1;
    phidot3 = -am * phi3 + u_t;
    thetadot1 = G(1, 1) * e * phi1;
    thetadot2 = G(2, 2) * e * phi2;
    thetadot3 = G(3, 3) * e * phi3;

    dxdt = [state1; state2; phidot1; phidot2; phidot3; thetadot1; thetadot2; thetadot3; xdothat];

end