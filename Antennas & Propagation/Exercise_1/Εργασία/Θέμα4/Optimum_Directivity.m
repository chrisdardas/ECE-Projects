clear;

% Set nondefault solver options

lb = [1 1 1 1 1];
ub = [3 3 3 4 4];
a = 5;
options2 = optimoptions("ga","PopulationSize",200,"MaxGenerations",1000,...
    "MaxStallGenerations",500,"MaxStallTime",200,"PlotFcn","gaplotbestf");

% Solve
[p,D] = ga(@maxDirectivity,a,[],[],[],[],lb,ub,[],[],...
    options2);


I1 = p(1);
I2 = p(2);
I3 = p(3);
I4 = p(4);
I5 = p(5);
theta = 0:0.001:pi;
fz = pi*cos(theta);
A = I1*(1+exp(j*9*fz))+I2*(exp(j*fz)+exp(j*8*fz))+I3*(exp(j*2*fz)+exp(j*7*fz))+I4*(exp(j*3*fz)+exp(j*6*fz))+I5*(exp(j*4*fz)+exp(j*5*fz));

AF = abs(A);
figure
polarplot(theta,AF)
title('Kατακόρυφο Διάγραμμα Ακτινοβολίας')



