function [] = function5_1(rho , mX, mY, sigmaX, sigmaY, n, M, alpha, squared)

    if squared == 1
        rho = rho^2;
    end

    rho_low = zeros(M, 1);
    rho_upper = zeros(M, 1);
    p_values = zeros(M, 1);
    p = zeros(M, 1);
    mu = [mX mY];
    Sigma = [sigmaX^2 rho*sigmaX*sigmaY; rho*sigmaX*sigmaY sigmaY^2];
    correct = 0;
    rejected = 0;
    rejected2 = 0;

    for i=1:M
        R = mvnrnd(mu, Sigma, n);
        
        X = R(:, 1);
        Y = R(:, 2);
        if squared == 1
            X = X.^2;
            Y = Y.^2;
        end
        
        mean_x = mean(X);
        mean_y = mean(Y);
        
        % alternative way of calculating is : r = corrcoef(X, Y)
        
        s_xy = (1/(n-1))*sum((X-mean_x) .* (Y - mean_y));
        s_x = std(X);
        s_y = std(Y);
        r = s_xy/(s_x * s_y);
        
        w = atanh(r);
        z = norminv(1-alpha/2);
        zeta_low   = w - z * sqrt(1/(n-3));
        zeta_upper = w + z * sqrt(1/(n-3));
        
        rho_low(i)   = tanh(zeta_low);
        rho_upper(i) = tanh(zeta_upper);
    
        if(rho_low(i) <= rho && rho_upper(i) >= rho)
            correct = correct + 1;
        end
        % Null Hypothesis Testing 
        tc = r * sqrt((n-2)/(1-r^2));

        p_values(i) = 2*(1 - tcdf(abs(tc), n-2));
        if p_values(i) < alpha
            rejected = rejected + 1;
        end
        [~,P]=corrcoef(X, Y);
        p(i) = P(1, 2);
        if p(i) < alpha
            rejected2 = rejected2 + 1;
        end
    end
    
    figure("Name", "Lower Bound");
    histogram(rho_low);
    hold on;
    xline(rho,LineWidth=2,Color='red');
    hold off;
    title("Lower Bound for ρ");
    xlabel("ρ Values");
    ylabel("Count of Frequencies");
    
    figure("Name", "Upper Bound");
    histogram(rho_upper);
    hold on;
    xline(rho,LineWidth=2,Color='red');
    hold off;
    title("Upper Bound for ρ");
    xlabel("ρ Values");
    ylabel("Count of Frequencies");
    
    percentage = (correct / M) * 100;
    rejection_percentage = (rejected / M) * 100;
    rejection_percentage_2 = (rejected / M) * 100;
    fprintf("Real value of ρ is in the confidence interval with %.2f%% percentage\n", percentage);
    fprintf("The Null Hypothesis H0 is rejected with %.2f%% percentage\n", rejection_percentage);
    fprintf("The Null Hypothesis H0 is rejected with %.2f%% percentage\n", rejection_percentage_2);
end