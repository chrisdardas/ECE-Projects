function [] = plotExplainedVar(eigenvalues)

    var_perc = 100 * cumsum(eigenvalues) / sum(eigenvalues);
    figure("Name", "Expected Variance Percentage");
    plot(1:size(eigenvalues), var_perc, 'r');
    title("Explained Variance Percentage");
    grid on;
    xlabel("Index");
    ylabel("Variance Percentage");
end