clear;
% Set nondefault solver options
lb = [1 1 1 1 1];
ub = [3 3 3 4 4];
a = 5;
options = optimoptions("ga","MaxGenerations",1000,"MaxStallGenerations",500,...
    "MaxStallTime",200,"PopulationSize",200,"PlotFcn","gaplotbestf");

% Solve
[p,Sum] = ga(@optimizeCurrents,a,[],[],[],[],lb,ub,[],[],...
    options);

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
plot(theta,20*log10(abs(A)))
title('Διαφορά σε dB των λοβών')
figure
polarplot(theta,AF)
title('Κατακόρυφο Διάγραμμα Ακτινοβολίας')
figure
semilogy(theta,AF)
title('Διαφορά σε dB των λοβών σε ημιλογαριθμική κλίμακα')

peaks = findpeaks(20*log10(abs(A)));
peaks = sort(peaks,"descend");
main_lobe = peaks(1);
side_lobe = peaks(2);

dB_difference = side_lobe-main_lobe;