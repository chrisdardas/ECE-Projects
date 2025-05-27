function [h,p_val] = Bootstrap_meanDiff2(X,Y,B,alpha)

    n = size(X,1);
    m = size(Y,1);
    Z = [X;Y];
    bootstrap_samplesX = zeros(B,n);
    bootstrap_samplesY = zeros(B,m);
    bootstrap_statistic = zeros(B+1,1);    
    %DON'T FORGET TO CHANGE THIS TOO
    original_statistic = mean(X)-mean(Y);
    bootstrap_statistic(1) = original_statistic;
    for i = 1:B
        indx = randperm(n+m, n+m);
        bootstrap_samplesX(i,:) = Z(indx(1:n));
        bootstrap_samplesY(i,:) = Z(indx(n+1:end));
        %MPOREI NA ALLAKSEI TO STATISTIC
        bootstrap_statistic(i+1) = mean(bootstrap_samplesX(i,:))-mean(bootstrap_samplesY(i,:));
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