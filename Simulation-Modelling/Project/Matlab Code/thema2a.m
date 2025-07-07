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
base_functions = {'poly', 'nonlinear', 'nonlinear2', 'rbf', 'custom', 'fourier', 'abs_log'};

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

    l2_list = zeros(K, 1);
    l2_error_list = zeros(K, 1);
    x0 = [0; 0; zeros(n_params, 1)];
    for i=1:K
        % Retrieve all the u functions besides the i-th function
        fprintf('Fold %2d/%d → Excluding input #%d from training\n', i, K, i);
        u = u_funcs([1:i-1, i+1:end]);  % Exclude the i-th function
        a_matrix = zeros(K-1, n_params);
        idx = 1;
        for j=1:size(u, 1)
            % Call the basis_choice function with the current parameters
            fprintf('  Training with input #%d of %d...\n', j + (j >= i), K);
            dyn = @(t, x) estimation_phase(t, x, u{j}, basis{1}, theta1, theta2, gamma, am);
            [t, x] = ode45(dyn, tspan, x0, options);
            a_matrix(idx, :) = x(end, 3:end);
            idx = idx + 1;
        end
        param_avg = mean(a_matrix, 1)';
        fprintf('Average parameters for %s: %s\n', basis{1}, mat2str(param_avg));
        u_test = u_funcs{i};
        dyn_test = @(t, x) validation_phase(t, x, u_test, basis{1}, param_avg, theta1, theta2);
        [t_test, x_test] = ode45(dyn_test, tspan, [0; 0], options);
        e = x_test(:, 1) - x_test(:, 2);
        l2_error = error_calculation(t_test, x_test(:, 1), x_test(:, 2), u_test, basis{1}, param_avg, theta1, theta2);
        l2_list(i) = L2_Norm(e, t_test);
        l2_error_list(i) = L2_Norm(l2_error, t_test);
        fprintf('  → Fold %2d L2 norm: %.6f\n', i, l2_list(i));
        fprintf('  → Fold %2d L2 norm(f-fhat): %.6f\n', i, l2_error_list(i));
    end
    avg_l2 = mean(l2_list);
    avg_l2_diff = mean(l2_error_list);
    fprintf('*** Completed basis: %s | Mean L2 norm: %.6f ***\n', basis{1}, avg_l2);
    fprintf('*** Completed basis: %s | Mean L2 norm(f-fhat): %.6f ***\n', basis{1}, avg_l2_diff);
    % Store results in a structured array for later analysis
    if ~isfield(results, basis{1})
       results.(basis{1}) = struct(); % Initialize if it doesn't exist
    end
    results.(basis{1}).avg_l2 = avg_l2;
    results.(basis{1}).avg_l2_diff = avg_l2_diff;
end

save('crossval_results.mat', 'results');

elapsed_time = toc;
end_time = datetime('now');
fprintf('Finished at %s\n', datetime(end_time));
fprintf('Total elapsed time: %.2f seconds (%.2f minutes)\n', elapsed_time, elapsed_time / 60);