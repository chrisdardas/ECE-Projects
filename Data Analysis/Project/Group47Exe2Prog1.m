clc;
clearvars;
close all;

% 1->Octari
% rng(42);
data = readtable("TMS.xlsx");
mask = (data.TMS == 1);
coilCodes = data.CoilCode(mask);
coilCodes = cell2mat(coilCodes);

mask2 = (coilCodes == '1');

octari = data.EDduration(mask2);
stroggylo = data.EDduration(~mask2);

alpha = 0.05;

mean_oct = mean(octari);
mean_strogg = mean(stroggylo);
M = 1000;

h1 = Group47Exe2Func1(octari, alpha, M);
h2 = Group47Exe2Func1(stroggylo, alpha, M);


[parametric_h1, p1]= chi2gof(octari, "CDF", {@expcdf, mean_oct}, "Alpha", alpha);
[parametric_h2, p2] = chi2gof(stroggylo, "CDF", {@expcdf, mean_oct}, "Alpha", alpha);

% We observe that the two types of hypothesis testing gives us the same
% result, and we can accept the hypothesis that both these samples follow
% an exponential probability distribution function. Even though the samples
% of stroggylo are very few, it still seems to be well within our bounds
% in order to accept the hypothesis.However the number of samples 
% in the case of stroggylo is very small and we can't use the parametric test
% to safely assess that its distribution is exponential.
% We conclude that the type of
% hypothesis testing described in the excercise is a valid way to get an
% answer on whether a data sample follows a specific distribution and can
% be used without much effort.