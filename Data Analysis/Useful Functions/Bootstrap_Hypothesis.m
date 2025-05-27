function [h,p_val] = Bootstrap_Hypothesis(X, B, alpha)

    n = size(X,1);
    bootstrap_samples = zeros(B,n);
    bootstrap_statistic = zeros(B+1,1); 


    %DON'T FORGET TO CHANGE THIS TOO
    original_statistic = mean(X);
    bootstrap_statistic(1) = original_statistic;


    for i = 1:B
        indx = randi([1 n],n,1);
        boot = X(indx);
        bootstrap_samples(i,:) = boot;
        %MPOREI NA ALLAKSEI TO STATISTIC
        bootstrap_statistic(i+1) = mean(boot);
        %!!!!!!!!!!!!! CHECK    
    end

    [~,indx] = sort(bootstrap_statistic);
    rank = find(indx == 1,1);


    if(rank<B/2)
        p_val = 2*rank/(B+1);
    else
        p_val = 2*(1-rank/(B+1));
    end
    
    if(p_val<=alpha)
        h = 1;
    else
        h=0;
    end

end