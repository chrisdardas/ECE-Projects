clc;
clearvars;
close all;

M = 1000; % number of samples
n = 20; % number of observations

mX = 0;
mY = 0;
sigmaX = 1;
sigmaY = 1;
mu = [mX mY];
alpha = 0.05;
squared = 0;

%------------------------------ Question (a,b) ----------------------------
% ρ = 0
function5_1(0, mX, mY, sigmaX, sigmaY, n, M, alpha, squared);
fprintf("\n");

% ρ = 0.5
function5_1(0.5, mX, mY, sigmaX, sigmaY, n, M, alpha, squared);
%------------------------------ Question (c) ------------------------------
fprintf("\n\n");
n = 200;
% ρ = 0
function5_1(0, mX, mY, sigmaX, sigmaY, n, M, alpha, squared);
fprintf("\n");
% ρ = 0.5
function5_1(0.5, mX, mY, sigmaX, sigmaY, n, M, alpha, squared);

%------------------------------ Question (d) ------------------------------
fprintf("\n\n");
squared = 1;
n = 20;
% ρ = 0
function5_1(0, mX, mY, sigmaX, sigmaY, n, M, alpha, squared);
fprintf("\n");
% ρ = 0.5
function5_1(0.5, mX, mY, sigmaX, sigmaY, n, M, alpha, squared);

fprintf("\n\n");
squared = 1;
n = 200;
% ρ = 0
function5_1(0, mX, mY, sigmaX, sigmaY, n, M, alpha, squared);
fprintf("\n");
% ρ = 0.5
function5_1(0.5, mX, mY, sigmaX, sigmaY, n, M, alpha, squared);


