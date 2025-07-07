function projected = projection(theta, thetadot, gamma1, gamma2)

    theta1 = theta(1);
    theta6 = theta(6);

    G = diag([gamma1 gamma1 gamma2 gamma2 gamma1 gamma2]);

    
    grad_g1 = [1; 0; 0; 0; 0; 0];   % theta1 >= -1
    grad_g2 = [-1; 0; 0; 0; 0; 0];  % theta1 <= -3
    grad_g3 = [0; 0; 0; 0; 0; -1];   % theta6 <= 1

    dot1 = dot(grad_g1, thetadot);
    dot2 = dot(grad_g2, thetadot);
    dot3 = dot(grad_g3, thetadot);

   
    case0 = ...
        (theta1 > -3 && theta1 < -1 && theta6 > 1) || ...
        (theta1 <= -3 && dot2 <= 0 && theta6 > 1) || ...
        (theta1 >= -1 && dot1 <= 0 && theta6 > 1) || ...
        (theta6 <= 1 && dot3 <= 0 && theta1 > -3 && theta1 < -1);

    case1 = (theta1 >= -1 && dot1 > 0);
    case2 = (theta1 <= -3 && dot2 > 0);
    case3 = (theta6 <= 1 && dot3 > 0);

    % Projection logic
    if case0
        projected = thetadot;
    elseif case1
        projected = thetadot - G * (grad_g1 * grad_g1') * thetadot / (grad_g1' * G * grad_g1);
    elseif case2
        projected = thetadot - G * (grad_g2 * grad_g2') * thetadot / (grad_g2' * G * grad_g2);
    elseif case3
        projected = thetadot - G * (grad_g3 * grad_g3') * thetadot / (grad_g3' * G * grad_g3);
    else
        projected = thetadot;
    end

end