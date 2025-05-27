function [R2, adjR2] = Group47Exe5Func1(Setup, EDduration, degree, displayPlot)

    n = size(Setup, 1);
    xM = zeros(n, degree + 1);
    xM(:, 1) = ones(n, 1);
    x = 0:0.1:6;
    x = x';
    x_vec = zeros(size(x, 1), degree);
    
    for i=1:degree
        xM(:, i+1) = Setup.^i;
        x_vec(:, i) = x.^i;
    end
    
    b = regress(EDduration, xM);
    y_est = [ones(size(x,1), 1) x_vec] * b;

    % Calculating R^2 and adjR^2
    y_estimator = xM * b;
    e = EDduration - y_estimator;
    R2 = 1 - sum(e.^2, 1) / sum((EDduration-mean(EDduration)).^2, 1);
    adjR2 = 1 - (n-1) / (n-degree-1) * (1-R2);

    if(displayPlot)
        figure();
        scatter(Setup, EDduration);
        hold on;
        plot(x, y_est)
    end

end