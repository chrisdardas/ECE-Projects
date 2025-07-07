clc;
clearvars;
close all;
rng(42); % for reproducibility
start_time = datetime('now');
fprintf('Started at %s\n', datetime(start_time));
tic;

theta1 = 1.5;
theta2 = 2;
gamma = 5;
am = 5;
base_functions = {'nonlinear', 'fourier'};

K = 10;
u_funcs = cell(K,1);
make_u = @(A, omega, D, B, C, c, s) @(t) A * cos(omega * t) .* exp(-D * t) + B + C * exp(-((t - c).^2) / s^2);

p_zero = 0.3;

for k = 1:K
    A = (rand() > p_zero) * (rand()*1.2 + 0.3);        % 70% chance to be non-zero
    w = 2*pi*(rand()*1.5 + 0.5);                       % [π, 3π], always active
    D = (rand() > p_zero) * (rand()*0.3);              % maybe zero
    B = (rand() > p_zero) * ((rand()-0.5)*0.6);        % maybe zero
    C = (rand() > p_zero) * (rand()*1.0);              % maybe zero
    c = rand()*20;                                     % gaussian center
    s = rand()*3 + 0.5;                                % spread

    u_funcs{k} = make_u(A, w, D, B, C, c, s);
end

tspan = [0 20];
options = odeset('MaxStep', 1e-3);

results = struct();
params = [];
for basis = base_functions
    fprintf('\n==============================\n');
    fprintf('Starting basis: %s\n', basis{1});
    fprintf('==============================\n');
    switch basis{1}
        case {'nonlinear', 'nonlinear2', 'custom'}
            n_params = 5;
        case 'rbf'
            n_params = 5;
        case {'fourier', 'poly'}
            n_params = 8; 
        case 'abs_log'
            n_params = 4;
    end

    x0 = [0; 0; zeros(n_params, 1)];
    u = u_funcs;
    a_matrix = zeros(K, n_params);
    idx = 1;
    for j=1:size(u, 1)
        dyn = @(t, x) estimation_phase(t, x, u{j}, basis{1}, theta1, theta2, gamma, am);
        [t, x] = ode45(dyn, tspan, x0, options);
        a_matrix(idx, :) = x(end, 3:end);
        idx = idx + 1;
    end
    param_avg = mean(a_matrix, 1)';
    fprintf('Average parameters for %s: %s\n', basis{1}, mat2str(param_avg));
    % Pad with NaNs if necessary
    if length(param_avg) < 8
        param_avg = [param_avg; nan(8 - length(param_avg), 1)];
    end

    params = [params, param_avg];
end


%%% Step Functions %%%
step_funcs = cell(K, 1);
for k=1:K
    A = -5 + 10 * rand();
    step_funcs{k} = @(t) A;
end


idx = 1;
for basis = base_functions
    fprintf('\n==============================\n');
    fprintf('Starting basis(STEP FUNCTIONS): %s\n', basis{1});
    fprintf('==============================\n');
    switch basis{1}
        case {'nonlinear', 'nonlinear2', 'custom'}
            n_params = 5;
        case 'rbf'
            n_params = 5;
        case {'fourier', 'poly'}
            n_params = 8; 
        case 'abs_log'
            n_params = 4;
    end

    x0 = [0; 0];
    u = step_funcs;
    a_matrix = zeros(K, n_params);
    l2_list = zeros(K, 1);
    l2_error_list = zeros(K, 1);
    
    for j=1:size(u, 1)
        if idx == 1
            a = params(1:5, idx);
        else 
            a = params(:, idx);
        end
        dyn = @(t, x) validation_phase(t, x, u{j}, basis{1}, a, theta1, theta2);
        [t, x] = ode45(dyn, tspan, x0, options);
        e = x(:, 1) - x(:, 2);
        l2_error = error_calculation(t, x(:, 1), x(:, 2), u{j}, basis{1}, a, theta1, theta2);
        l2_list(j) = L2_Norm(e, t);
        l2_error_list(j) = L2_Norm(l2_error, t);
        % fprintf('  L2 norm: %.6f\n', l2_list(j));
        % fprintf('  L2 norm(f-fhat): %.6f\n', l2_error_list(j));
    end
    avg_l2 = mean(l2_list);
    avg_l2_diff = mean(l2_error_list);
    fprintf('*** Completed basis: %s | Mean L2 norm: %.6f ***\n', basis{1}, avg_l2);
    fprintf('*** Completed basis: %s | Mean L2 norm(f-fhat): %.6f ***\n', basis{1}, avg_l2_diff);
    idx = idx + 1;
end

%%% Sine Functions %%%
sine_funcs = cell(K, 1);
for k=1:K
    A = -1 + 2 * rand();
    omega = -2 + 4 * rand();
    sine_funcs{k} = @(t) A * sin(omega*t);
end


idx = 1;
for basis = base_functions
    fprintf('\n==============================\n');
    fprintf('Starting basis(SINE FUNCTIONS): %s\n', basis{1});
    fprintf('==============================\n');
    switch basis{1}
        case {'nonlinear', 'nonlinear2', 'custom'}
            n_params = 5;
        case 'rbf'
            n_params = 5;
        case {'fourier', 'poly'}
            n_params = 8; 
        case 'abs_log'
            n_params = 4;
    end

    x0 = [0; 0];
    u = sine_funcs;
    a_matrix = zeros(K, n_params);
    l2_list = zeros(K, 1);
    l2_error_list = zeros(K, 1);
    
    for j=1:size(u, 1)
        if idx == 1
            a = params(1:5, idx);
        else 
            a = params(:, idx);
        end
        dyn = @(t, x) validation_phase(t, x, u{j}, basis{1}, a, theta1, theta2);
        [t, x] = ode45(dyn, tspan, x0, options);
        e = x(:, 1) - x(:, 2);
        l2_error = error_calculation(t, x(:, 1), x(:, 2), u{j}, basis{1}, a, theta1, theta2);
        l2_list(j) = L2_Norm(e, t);
        l2_error_list(j) = L2_Norm(l2_error, t);
        % fprintf('  L2 norm: %.6f\n', l2_list(j));
        % fprintf('  L2 norm(f-fhat): %.6f\n', l2_error_list(j));
    end
    avg_l2 = mean(l2_list);
    avg_l2_diff = mean(l2_error_list);
    fprintf('*** Completed basis: %s | Mean L2 norm: %.6f ***\n', basis{1}, avg_l2);
    fprintf('*** Completed basis: %s | Mean L2 norm(f-fhat): %.6f ***\n', basis{1}, avg_l2_diff);
    idx = idx + 1;
end
%%% Cosine Functions %%%
cosine_funcs = cell(K, 1);
for k=1:K
    B = -1.5 + 3 * rand();
    omega = -2 + 4 * rand();
    cosine_funcs{k} = @(t) B * cos(omega*t);
end


idx = 1;
for basis = base_functions
    fprintf('\n==============================\n');
    fprintf('Starting basis(COSINE FUNCTIONS): %s\n', basis{1});
    fprintf('==============================\n');
    switch basis{1}
        case {'nonlinear', 'nonlinear2', 'custom'}
            n_params = 5;
        case 'rbf'
            n_params = 5;
        case {'fourier', 'poly'}
            n_params = 8; 
        case 'abs_log'
            n_params = 4;
    end

    x0 = [0; 0];
    u = cosine_funcs;
    a_matrix = zeros(K, n_params);
    l2_list = zeros(K, 1);
    l2_error_list = zeros(K, 1);
    
    for j=1:size(u, 1)
        if idx == 1
            a = params(1:5, idx);
        else 
            a = params(:, idx);
        end
        dyn = @(t, x) validation_phase(t, x, u{j}, basis{1}, a, theta1, theta2);
        [t, x] = ode45(dyn, tspan, x0, options);
        e = x(:, 1) - x(:, 2);
        l2_error = error_calculation(t, x(:, 1), x(:, 2), u{j}, basis{1}, a, theta1, theta2);
        l2_list(j) = L2_Norm(e, t);
        l2_error_list(j) = L2_Norm(l2_error, t);
        % fprintf('  L2 norm: %.6f\n', l2_list(j));
        % fprintf('  L2 norm(f-fhat): %.6f\n', l2_error_list(j));
    end
    avg_l2 = mean(l2_list);
    avg_l2_diff = mean(l2_error_list);
    fprintf('*** Completed basis: %s | Mean L2 norm: %.6f ***\n', basis{1}, avg_l2);
    fprintf('*** Completed basis: %s | Mean L2 norm(f-fhat): %.6f ***\n', basis{1}, avg_l2_diff);
    idx = idx + 1;
end

%%% Sine & Cosine Functions %%%
comb_funcs = cell(K, 1);
for k=1:K
    A = -1 + 2 * rand();
    B = -1.5 + 3 * rand();
    omega = -2 + 4 * rand();
    comb_funcs{k} = @(t) A * sin(omega*t) + B * cos(omega*t);
end


idx = 1;
for basis = base_functions
    fprintf('\n==============================\n');
    fprintf('Starting basis(SINE & COSINE FUNCTIONS): %s\n', basis{1});
    fprintf('==============================\n');
    switch basis{1}
        case {'nonlinear', 'nonlinear2', 'custom'}
            n_params = 5;
        case 'rbf'
            n_params = 5;
        case {'fourier', 'poly'}
            n_params = 8; 
        case 'abs_log'
            n_params = 4;
    end

    x0 = [0; 0];
    u = comb_funcs;
    a_matrix = zeros(K, n_params);
    l2_list = zeros(K, 1);
    l2_error_list = zeros(K, 1);
    
    for j=1:size(u, 1)
        if idx == 1
            a = params(1:5, idx);
        else 
            a = params(:, idx);
        end
        dyn = @(t, x) validation_phase(t, x, u{j}, basis{1}, a, theta1, theta2);
        [t, x] = ode45(dyn, tspan, x0, options);
        e = x(:, 1) - x(:, 2);
        l2_error = error_calculation(t, x(:, 1), x(:, 2), u{j}, basis{1}, a, theta1, theta2);
        l2_list(j) = L2_Norm(e, t);
        l2_error_list(j) = L2_Norm(l2_error, t);
        % fprintf('  L2 norm: %.6f\n', l2_list(j));
        % fprintf('  L2 norm(f-fhat): %.6f\n', l2_error_list(j));
    end
    avg_l2 = mean(l2_list);
    avg_l2_diff = mean(l2_error_list);
    fprintf('*** Completed basis: %s | Mean L2 norm: %.6f ***\n', basis{1}, avg_l2);
    fprintf('*** Completed basis: %s | Mean L2 norm(f-fhat): %.6f ***\n', basis{1}, avg_l2_diff);
    idx = idx + 1;
end

%%% Exponential Functions %%%
exp_funcs = cell(K, 1);
for k=1:K
    A = -2 + 4*rand();             
    D = 5 + 5*rand();                                     
    B = rand()*2 + 1.5;                                
    exp_funcs{k} = @(t) A * exp(-D*t) + B;
end


idx = 1;
for basis = base_functions
    fprintf('\n==============================\n');
    fprintf('Starting basis(EXPONENTIAL FUNCTIONS): %s\n', basis{1});
    fprintf('==============================\n');
    switch basis{1}
        case {'nonlinear', 'nonlinear2', 'custom'}
            n_params = 5;
        case 'rbf'
            n_params = 5;
        case {'fourier', 'poly'}
            n_params = 8; 
        case 'abs_log'
            n_params = 4;
    end

    x0 = [0; 0];
    u = exp_funcs;
    a_matrix = zeros(K, n_params);
    l2_list = zeros(K, 1);
    l2_error_list = zeros(K, 1);
    
    for j=1:size(u, 1)
        if idx == 1
            a = params(1:5, idx);
        else 
            a = params(:, idx);
        end
        dyn = @(t, x) validation_phase(t, x, u{j}, basis{1}, a, theta1, theta2);
        [t, x] = ode45(dyn, tspan, x0, options);
        e = x(:, 1) - x(:, 2);
        l2_error = error_calculation(t, x(:, 1), x(:, 2), u{j}, basis{1}, a, theta1, theta2);
        l2_list(j) = L2_Norm(e, t);
        l2_error_list(j) = L2_Norm(l2_error, t);
        % fprintf('  L2 norm: %.6f\n', l2_list(j));
        % fprintf('  L2 norm(f-fhat): %.6f\n', l2_error_list(j));
    end
    avg_l2 = mean(l2_list);
    avg_l2_diff = mean(l2_error_list);
    fprintf('*** Completed basis: %s | Mean L2 norm: %.6f ***\n', basis{1}, avg_l2);
    fprintf('*** Completed basis: %s | Mean L2 norm(f-fhat): %.6f ***\n', basis{1}, avg_l2_diff);
    idx = idx + 1;
end

%%% Gaussian Functions %%%
 gaussian_funcs = cell(K, 1);
for k=1:K
    C = -2 + 4*rand();             
    c = -5 + 10*rand();                                     
    s = rand()*2 + 1.5;                                
    gaussian_funcs{k} = @(t) C * exp(-((t - c).^2) / s^2);
end


idx = 1;
for basis = base_functions
    fprintf('\n==============================\n');
    fprintf('Starting basis(GAUSSIAN FUNCTIONS): %s\n', basis{1});
    fprintf('==============================\n');
    switch basis{1}
        case {'nonlinear', 'nonlinear2', 'custom'}
            n_params = 5;
        case 'rbf'
            n_params = 5;
        case {'fourier', 'poly'}
            n_params = 8; 
        case 'abs_log'
            n_params = 4;
    end

    x0 = [0; 0];
    u = gaussian_funcs;
    a_matrix = zeros(K, n_params);
    l2_list = zeros(K, 1);
    l2_error_list = zeros(K, 1);
    
    for j=1:size(u, 1)
        if idx == 1
            a = params(1:5, idx);
        else 
            a = params(:, idx);
        end
        dyn = @(t, x) validation_phase(t, x, u{j}, basis{1}, a, theta1, theta2);
        [t, x] = ode45(dyn, tspan, x0, options);
        e = x(:, 1) - x(:, 2);
        l2_error = error_calculation(t, x(:, 1), x(:, 2), u{j}, basis{1}, a, theta1, theta2);
        l2_list(j) = L2_Norm(e, t);
        l2_error_list(j) = L2_Norm(l2_error, t);
        % fprintf('  L2 norm: %.6f\n', l2_list(j));
        % fprintf('  L2 norm(f-fhat): %.6f\n', l2_error_list(j));
    end
    avg_l2 = mean(l2_list);
    avg_l2_diff = mean(l2_error_list);
    fprintf('*** Completed basis: %s | Mean L2 norm: %.6f ***\n', basis{1}, avg_l2);
    fprintf('*** Completed basis: %s | Mean L2 norm(f-fhat): %.6f ***\n', basis{1}, avg_l2_diff);
    idx = idx + 1;
end

elapsed_time = toc;
end_time = datetime('now');
fprintf('Finished at %s\n', datetime(end_time));
fprintf('Total elapsed time: %.2f seconds (%.2f minutes)\n', elapsed_time, elapsed_time / 60);