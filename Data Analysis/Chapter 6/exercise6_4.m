clc;
clearvars;
close all;

n = 10000;

chirpSignal = load("chirp.mat");
chirpSignal = chirpSignal.y(1:n);
chirpSignal = chirpSignal - mean(chirpSignal);

gongSignal  = load("gong.mat");
gongSignal  = gongSignal.y(1:n);
gongSignal  = gongSignal - mean(gongSignal);

figure('Name', 'Signal 1')
plot(chirpSignal);
title("Source Signal 1(chirp signal)");
xlabel('t');
ylabel('s_1(t)');

figure('Name', 'Signal 2')
plot(gongSignal);
title("Source Signal 2(gong signal)");
xlabel('t');
ylabel('s_2(t)');

figure('Name', 'Original Signals');
scatter(chirpSignal, gongSignal);
title('Scatter diagram source 2D');
xlabel('s_1(t)');
ylabel('s_2(t)');


%------------------------------ Question (a) ------------------------------
% without pre-whitening
A = rand(2, 2) * 2.5;
signals = ([chirpSignal gongSignal]);

X = signals * A;


figure('Name', 'Signal 1')
plot(X(:, 1));
title("Observed Signal 1(chirp signal)");
xlabel('t');
ylabel('s_1(t)');

figure('Name', 'Signal 2')
plot(X(:, 2));
title("Observed Signal 2(gong signal)");
xlabel('t');
ylabel('s_2(t)');

figure('Name', 'Original Signals');
scatter(X(:, 1), X(:, 2));
title('Scatter diagram source 2D');
xlabel('s_1(t)');
ylabel('s_2(t)');

W = rica(X, 2);

S = X * W.TransformWeights;

figure('Name', 'Signal 1')
plot(S(:, 1));
title("Reconstructed Signal 1(chirp signal)");
xlabel('t');
ylabel('s_1(t)');

figure('Name', 'Signal 2')
plot(S(:, 2));
title("Reconstructed Signal 2(gong signal)");
xlabel('t');
ylabel('s_2(t)');

figure('Name', 'Original Signals');
scatter(S(:, 1), S(:, 2));
title('Scatter diagram source 2D');
xlabel('s_1(t)');
ylabel('s_2(t)');

% with pre-whitening

[U, S, V] = svd(X, "econ");
X_new = prewhiten(X);

W_white = rica(X_new, 2);

S_new = X_new * W_white.TransformWeights;

figure('Name', 'Signal 1')
plot(S_new(:, 1));
title("Reconstructed Signal 1(chirp signal)");
xlabel('t');
ylabel('s_1(t)');

figure('Name', 'Signal 2')
plot(S_new(:, 2));
title("Reconstructed Signal 2(gong signal)");
xlabel('t');
ylabel('s_2(t)');

figure('Name', 'Original Signals');
scatter(S_new(:, 1), S_new(:, 2));
title('Scatter diagram source 2D');
xlabel('s_1(t)');
ylabel('s_2(t)');

%------------------------------ Question (b) ------------------------------
% without pre-whitening
A = rand(2, 3) * 2.5;
signals = ([chirpSignal gongSignal]);

X = signals * A;


figure('Name', 'Signal 1')
plot(X(:, 1));
title("Observed Signal 1(chirp signal)");
xlabel('t');
ylabel('s_1(t)');

figure('Name', 'Signal 2')
plot(X(:, 2));
title("Observed Signal 2(gong signal)");
xlabel('t');
ylabel('s_2(t)');

figure('Name', 'Original Signals');
scatter(X(:, 1), X(:, 2));
title('Scatter diagram source 2D');
xlabel('s_1(t)');
ylabel('s_2(t)');

W = rica(X, 2);

S = X * W.TransformWeights;

figure('Name', 'Signal 1')
plot(S(:, 1));
title("Reconstructed Signal 1(chirp signal)");
xlabel('t');
ylabel('s_1(t)');

figure('Name', 'Signal 2')
plot(S(:, 2));
title("Reconstructed Signal 2(gong signal)");
xlabel('t');
ylabel('s_2(t)');

figure('Name', 'Original Signals');
scatter(S(:, 1), S(:, 2));
title('Scatter diagram source 2D');
xlabel('s_1(t)');
ylabel('s_2(t)');

% with pre-whitening

[U, S, V] = svd(X, "econ");
X_new = prewhiten(X);

W_white = rica(X_new, 2);

S_new = X_new * W_white.TransformWeights;

figure('Name', 'Signal 1')
plot(S_new(:, 1));
title("Reconstructed Signal 1(chirp signal)");
xlabel('t');
ylabel('s_1(t)');

figure('Name', 'Signal 2')
plot(S_new(:, 2));
title("Reconstructed Signal 2(gong signal)");
xlabel('t');
ylabel('s_2(t)');

figure('Name', 'Original Signals');
scatter(S_new(:, 1), S_new(:, 2));
title('Scatter diagram source 2D');
xlabel('s_1(t)');
ylabel('s_2(t)');

