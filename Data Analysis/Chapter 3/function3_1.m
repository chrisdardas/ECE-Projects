function [Mean] = function3_1(M, n, lambda)

%data = zeros(n, 1);
sample_means = zeros(M, 1);

for i=1:M
    data = poissrnd(lambda, n, 1);

    sample_means(i, 1) = sum(data, 1) / n;
end

figure
histogram(sample_means);
title("Histogram Of Sample Means");
ylabel('Number Of Frequencies');
xlabel('Mean Value');

Mean = mean(sample_means,1);
end