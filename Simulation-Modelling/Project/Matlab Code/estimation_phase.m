function dxdt = estimation_phase(t, x, u, basis, theta1, theta2, gamma, am)
    u_t = feval(u, t);
    x_real = x(1);
    xhat = x(2);
    
    a = x(3:end);
    
    xdot = -x_real^3 + theta1 * tanh(x_real) + theta2 * (1 / (1 + x_real^2)) + u_t;

    e = x_real - xhat;

    switch basis
        case 'poly'
            phi = [x_real; x_real^2; x_real^3; x_real^4; x_real^5; x_real^6; x_real^7; u_t];
        case 'nonlinear'
            phi = [x_real; x_real^3; tanh(x_real); 1 / (1 + x_real^2); u_t];
    
        case 'nonlinear2'
            sigmoid = @(x) 1 / (1 + exp(-x));
            phi = [tanh(x_real); sigmoid(x_real); x_real / (1 + abs(x_real)); sigmoid(u_t + x_real); u_t];
    
        case 'custom'
            phi = [x_real^2; tanh(x_real); u_t; 1 / (1 + x_real^2); x_real * u_t];
    
        case 'rbf'
            centers = linspace(-2, 2, 5);
            gamma_rbf = 1.0;
            phi = zeros(length(centers), 1);
            for i = 1:length(centers)
                c = centers(i);
                phi(i) = exp(-gamma_rbf * ((x_real - c)^2 + (u_t - c)^2));
            end
    
        case 'fourier'
            k = [1, 2]; 
            phi = [];
            for i = 1:length(k)
                phi = [phi; sin(k(i) * x_real); cos(k(i) * x_real); ...
                            sin(k(i) * u_t);   cos(k(i) * u_t)];
            end

        case 'abs_log'
             phi = [abs(x_real); log(1 + x_real^2); x_real / (1 + x_real^2); u_t];

    otherwise
        error('Unknown basis type');
    end

    xhat_dot = a' * phi + am * e;
    adot = gamma * e * phi;

    dxdt = [xdot; xhat_dot; adot];
end
