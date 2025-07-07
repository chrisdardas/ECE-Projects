function e = error_calculation(t, x_real, x_hat, u, basis, a, theta1, theta2)

    u_t = u(t);
    
    % Basis
    switch basis
        case 'poly'
            xhat_dot = a(1)*x_hat + a(2)*x_hat.^2 + a(3)*x_hat.^3 + a(4)*x_hat.^4 + a(5)*x_hat.^5 + a(6)*x_hat.^6 + a(7)*x_hat.^7 + a(8)*u_t;
        case 'nonlinear'
            xhat_dot = a(1)*x_hat + a(2)*x_hat.^3 + a(3)*tanh(x_hat) + ...
                       a(4)./(1 + x_hat.^2) + a(5)*u_t;
    
        case 'nonlinear2'
            sigmoid = @(z) 1 ./ (1 + exp(-z));
            xhat_dot = a(1)*tanh(x_hat) + a(2)*sigmoid(x_hat) + ...
                       a(3)*(x_hat ./ (1 + abs(x_hat))) + ...
                       a(4)*sigmoid(u_t + x_hat) + a(5)*u_t;
    
        case 'custom'
            xhat_dot = a(1)*x_hat.^2 + a(2)*tanh(x_hat) + a(3)*u_t + ...
                       a(4)./(1 + x_hat.^2) + a(5)*x_hat.*u_t;
    
        case 'rbf'
            centers = linspace(-2, 2, 5);
            gamma_rbf = 1.0;
            xhat_dot = 0;
            for i = 1:length(centers)
                c = centers(i);
                xhat_dot = xhat_dot + a(i)*exp(-gamma_rbf * ((x_hat - c).^2 + (u_t - c).^2));
            end
    
        case 'fourier'
            k = [1, 2];
            xhat_dot = 0;
            idx = 1;
            for i = 1:length(k)
                xhat_dot = xhat_dot + a(idx)*sin(k(i)*x_hat); idx = idx + 1;
                xhat_dot = xhat_dot + a(idx)*cos(k(i)*x_hat); idx = idx + 1;
                xhat_dot = xhat_dot + a(idx)*sin(k(i)*u_t);    idx = idx + 1;
                xhat_dot = xhat_dot + a(idx)*cos(k(i)*u_t);    idx = idx + 1;
            end
    
        case 'abs_log'
            xhat_dot = a(1)*abs(x_hat) + a(2)*log(1 + x_hat.^2) + ...
                       a(3)*(x_hat ./ (1 + x_hat.^2)) + a(4)*u_t;
    
        otherwise
            error('Unknown basis type');
    end

    % Real system
    xdot = -x_real.^3 + theta1 * tanh(x_real) + theta2 ./ (1 + x_real.^2) + u_t;

    e = xdot - xhat_dot;
end