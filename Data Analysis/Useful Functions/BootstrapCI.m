function [boot_ci] = BootstrapCI(X, B, alpha)
    

    n = size(X, 1);
    bootstrap_samples = zeros(B, n);
    bootstrap_stat = zeros(B, 1);

    lower = fix((B+1)*alpha/2);
    upper = B + 1 - lower;

    for i=1:B
        idx = randi([1 n], n, 1);
        bootstrap_samples(i, :) = X(idx);
        % YOU MIGHT NEED TO CHANGE THAT!!!!!!!!!!!!!!!!!!!!!!
        bootstrap_stat(i) = mean(bootstrap_samples(i, :)); % BE CAREFULL
        % !!!!!!!!!!!!!!!!!!!!!!!!! CHECK
    end

    bootstrap_stat = sort(bootstrap_stat, 1);

    boot_ci = zeros(2, 1);

    boot_ci(1) = bootstrap_stat(lower);
    boot_ci(2) = bootstrap_stat(upper);
end