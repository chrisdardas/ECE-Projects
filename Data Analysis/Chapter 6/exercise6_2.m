clc;
clearvars;
close all;

data = readmatrix('yeast.dat');
n = size(data, 2); % number of observations
p = size(data, 1); % number of features

data = data';

mean_values = mean(data);

X_center = data - repmat(mean_values, n, 1);

S = 1/(n - 1) * (X_center') * X_center;

[V, D] = eig(S);
eigenvalues = diag(D);
[eigenvalues, I] = sort(eigenvalues, 'descend');

% Scree plot
figure("Name","Scree Plot");
plot(1:size(eigenvalues), eigenvalues,'bo-');
title('Scree Plot');
xlabel('Index');
ylabel('Eigenvalues');

% Explained Variance Percentage
var_perc = 100 * cumsum(eigenvalues) / sum(eigenvalues);
figure("Name", "Expected Variance Percentage");
plot(1:p, var_perc, 'r');
title("Expected Variance Percentage");
grid on;
xlabel("Index");
ylabel("Variance Percentage");

d = 3;
V_R3 = V(:, I(1:d));
Y = X_center * V_R3;

figure('Name', 'PC Scores(3D)');
scatter3(Y(:, 1), Y(:, 2), Y(:, 3));
title("PC Scores");
grid on;
xlabel('PC1');
ylabel("PC2");
zlabel("PC3");


V_R2 = V(:, I(1:2));
Y = X_center * V_R2;
figure('Name', 'PC Scores(2D)');
scatter(Y(:, 1), Y(:, 2));
title("PC Scores(2D)");
grid on;
xlabel('PC1');
ylabel("PC2");






