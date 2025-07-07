function dxdt = validation_phase(t, x, u, basis, a, theta1, theta2)
    u_t = feval(u, t);
    x_real = x(1);
    x_hat = x(2);
    
    % Basis
    switch basis
        case 'poly'
            phi = [x_hat; x_hat^2; x_hat^3; x_hat^4; x_hat^5; x_hat^6; x_hat^7; u_t];
        case 'nonlinear'
            phi = [x_hat; x_hat^3; tanh(x_hat); 1/(1+x_hat^2); u_t];
        case 'nonlinear2'
            sigmoid = @(x) 1 / (1 + exp(-x));
            phi = [tanh(x_hat); sigmoid(x_hat); x_hat/(1 + abs(x_hat)); sigmoid(u_t + x_hat); u_t];
        case 'custom'
            phi = [x_hat^2; tanh(x_hat); u_t; 1/(1 + x_hat^2); x_hat*u_t];
        case 'rbf'
            centers = linspace(-2, 2, 5);
            gamma_rbf = 1.0;
            phi = zeros(length(centers), 1);
            for i = 1:length(centers)
                c = centers(i);
                phi(i) = exp(-gamma_rbf * ((x_hat - c)^2 + (u_t - c)^2));
            end
        case 'fourier'
            k = [1, 2];
            phi = [];
            for i = 1:length(k)
                phi = [phi; sin(k(i) * x_hat); cos(k(i) * x_hat); ...
                            sin(k(i) * u_t); cos(k(i) * u_t)];
            end
        case 'abs_log'
            phi = [abs(x_hat); log(1 + x_hat^2); x_hat / (1 + x_hat^2); u_t];
        otherwise
            error('Unknown basis type');
    end

    % Real system
    xdot = -x_real^3 + theta1 * tanh(x_real) + theta2 / (1 + x_real^2) + u_t;

    % Estimated output with frozen parameters
    xhat_dot = a' * phi;

    dxdt = [xdot; xhat_dot];
end
