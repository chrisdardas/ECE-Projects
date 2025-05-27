clc;
clearvars;
close all;

data = readmatrix("physical.txt");
n = size(data, 1);
p = size(data, 2);

mean_values = mean(data);
X_center = data - repmat(mean_values, n, 1);

S = (1/(n-1)) * (X_center') * X_center;

[V, D] = eig(S);
eigenvalues = diag(D);

[eigenvalues, I] = sort(eigenvalues, 'descend');
V = V(:, I); % sorted eigenvectors

% Scree Plot
figure('Name', "Scree Plot");
plot(1:p, eigenvalues, 'bo-');
title("Scree Plot");
grid on;
xlabel("Index");
ylabel("Eigenvalues");

% Expected Variance Percentage
var_perc = 100 * cumsum(eigenvalues) / sum(eigenvalues);
figure("Name", "Expected Variance Percentage");
plot(1:p, var_perc, 'bo-');
grid on;
title("Expected Variance Percentage");
xlabel("Index");
ylabel("Variance Percentage");

V_R3 = V(:, 1:3);
Y = X_center * V_R3;

figure("Name", "PC Scores(3D)");
scatter3(Y(:, 1), Y(:, 2), Y(:, 3));
title("PC Scores(3D)");
grid on;
xlabel("PC1");
ylabel("PC2");
zlabel("PC3");


V_R2 = V(:, 1:2);
Y = X_center * V_R2;

figure("Name", "PC Scores(2D)");
scatter(Y(:, 1), Y(:, 2));
title("PC Scores(2D)");
grid on;
xlabel("PC1");
ylabel("PC2");