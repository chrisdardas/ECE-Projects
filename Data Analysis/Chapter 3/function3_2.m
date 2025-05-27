function [Mean] = function3_2(M, n, lambda)

sample_mean = zeros(n, 1);
for i=1:M
    data = exprnd(lambda, n, 1);
    sample_mean(i, 1) = sum(data, 1) / n;
end

figure;
histogram(sample_mean);
title('Histogram Of Sample Means');
ylabel('Count Of Frequencies');
xlabel('Mean Values');

Mean = mean(sample_mean, 1);
end