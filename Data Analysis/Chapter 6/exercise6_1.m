clc;
clearvars;
close all;

n = 1000;
var_1 = 1;
mu_1 = 0;
var_2 = 4;
mu_2 = 0;
Sigma = [var_1 0; 0 var_2];
mu = [mu_1 mu_2];

R = mvnrnd(mu, Sigma, n);

W = [0.2 0.8; 0.4 0.5; 0.7 0.3];

X = R * transpose(W); % converting our data from R^2 to R^3

figure('Name', 'Generated Points');
scatter(R(:, 1), R(:, 2));
xlabel('x_1');
ylabel('x_2');
title('2D Gaussian Generated Points');


figure('Name', '3D Points');
scatter3(X(:, 1), X(:, 2), X(:,3));
xlabel('y_1');
ylabel('y_2');
zlabel('y_3');
title('3D Observed Points');

mean_values = mean(X, 1)';
X_center = zeros(n, size(X, 2));

for i=1:size(X, 2)
    X_center(:, i) = X(:, i) - mean_values(i); % centering each column
end

S = (1/(n-1)) * transpose(X_center) * X_center; % creating the covariance matrix
 
[V, D] = eig(S); % getting the eigenvectors and eigenvalues of S 

eigenvalues = diag(D);
[eigenvalues, I] = sort(eigenvalues, "descend");
V = V(:, I);

% eigenvectors = V(:, size(X, 2):-1:1);

Y = X_center*V; % Getting the PC scores
figure("Name", "PC scores(3D)")
scatter3(Y(:, 1), Y(:, 2), Y(:, 3));
xlabel("PC1");
ylabel("PC2");
zlabel("PC3");
title("Principal Components Scores");

% Scree plot
figure("Name", 'Scree Plot');
plot(1:size(eigenvalues), eigenvalues, 'o-');
xlabel('index');
ylabel('eigenvalues');
title('Scree Plot');

Y = X_center * V(:, 1:2);

figure("Name", "PC scores(2D)")
scatter(Y(:, 1), Y(:, 2));
xlabel("PC1");
ylabel("PC2");
title("Principal Components Scores");