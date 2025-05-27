function [X_train, X_test, y_train, y_test] = Group47Exe7Func1(X, y, test_size)
    n = size(y, 1);

    test_size = fix(test_size * n);

    idx = randperm(n);
    X = X(idx, :);
    y = y(idx);

    X_train = X(1:end-test_size, :);
    y_train = y(1:end-test_size, :);

    X_test = X(end - test_size + 1:end, :);
    y_test = y(end - test_size + 1: end, :);
    
end