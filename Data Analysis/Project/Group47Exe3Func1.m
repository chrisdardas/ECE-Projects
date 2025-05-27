function [h_normal, h, CI] = Group47Exe3Func1(Dataset,Setup,alpha,B)
    mu_0 = mean(Dataset);
       
    Dataset1 = Dataset(Setup == 1);
    Dataset2 = Dataset(Setup == 2);
    Dataset3 = Dataset(Setup == 3);
    Dataset4 = Dataset(Setup == 4);
    Dataset5 = Dataset(Setup == 5);
    Dataset6 = Dataset(Setup == 6);
    
    Dataset_array = {Dataset1,Dataset2,Dataset3,Dataset4,Dataset5,Dataset6};
    h_normal = size(Dataset_array, 2);

    for i=1:6
        h_normal(i) = chi2gof(Dataset_array{i}, "Alpha", alpha);
    end
    
    lower_bound = fix((B+1)*alpha*0.5);
    upper_bound = B+1-lower_bound;
    CI = zeros(2,6);
    h = zeros(1, 6);
    for i=1:6
        X = zeros(B,size(Dataset_array{i},1));
        bootstrap_means = zeros(B,1);
        for j = 1:B
            X(j,:) = randsample(Dataset_array{i},size(Dataset_array{i},1),true);
            bootstrap_means(j) = mean(X(j,:));
        end
        bootstrap_means = sort(bootstrap_means,1);
        CI(1,i) = bootstrap_means(lower_bound);
        CI(2,i) = bootstrap_means(upper_bound);
        
        if mu_0 >= CI(1, i) && mu_0 <= CI(2, i)
            h(i) = 0;
        else
            h(i) = 1;
        end

    end

end