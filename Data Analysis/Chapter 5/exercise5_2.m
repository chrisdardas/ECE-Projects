clc;
clearvars;
close all;

L = 1000; % number of samples
n = 20; % number of observations in a sample
alpha = 0.05;
mX = 0;
mY = 0;
sigmaX = 1;
sigmaY = 1;
M = 100;

% For (X, Y) and ρ = 0
rho = 0;
squared = 0;
function5_2(n, L, rho, mX, mY, sigmaX, sigmaY, alpha, squared, M);

% For (X, Y) and ρ = 0.5
rho = 0.5;
function5_2(n, L, rho, mX, mY, sigmaX, sigmaY, alpha, squared, M);

% For (X^2, Y^2) and ρ = 0
rho = 0;
squared = 1;
function5_2(n, L, rho, mX, mY, sigmaX, sigmaY, alpha, squared, M);

% For (X^2, Y^2) and ρ = 0.5
rho = 0.5;
function5_2(n, L, rho, mX, mY, sigmaX, sigmaY, alpha, squared, M);

