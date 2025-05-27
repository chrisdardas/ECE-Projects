function [h] = Group47Exe2Func1(dataset, alpha, M)
    dataset_mean = mean(dataset);
    n = size(dataset, 1);
    
    X = exprnd(dataset_mean, n, M);
    
    chi_array = zeros(1, M+1);
    % Upper Bound can be chosen differently depending on the circumstance
    lower_bound = fix((M+1) * alpha );
    upper_bound = M + 1 - lower_bound;
    
    [~, ~, stats] = chi2gof(dataset, "CDF", {@expcdf, dataset_mean}, 'Alpha', alpha);
    chi0 = sum((stats.O - stats.E).^2 ./ stats.E);
    chi_array(1, 1) = chi0;
    
    for i=1:M
        [~, ~, stats] = chi2gof(X(:, i), "CDF", {@expcdf, dataset_mean}, 'Alpha', alpha);
        chi_array(1, i+1) = sum((stats.O - stats.E).^2 ./ stats.E);
    end
    
    chi_array = sort(chi_array, 2);
    
    if chi0 < chi_array(upper_bound)
        h = 0;
    else
        h = 1;
    end

end