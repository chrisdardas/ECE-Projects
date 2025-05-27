clc;
clearvars;
close all;

alpha = 0.05;
data = readtable("TMS.xlsx");
% mask = (data.TMS == 1);
% 
% TMS = data.TMS(mask);
% notTMS = data.TMS(~mask);

mask = (data.TMS == 1);
%read the data of ED duration with and without TMS
EDduration_TMS = data.EDduration(mask);
EDduration_no_TMS = data.EDduration(~mask);


%Plot the histograms of the data
figure('Name', 'ED Duration histogram with TMS');
histogram(EDduration_TMS, 'FaceColor', 'blue');
grid on;
title('ED Duration histogram with TMS');
xlabel('Values');
ylabel('Count Of Frequencies');
xlim([0 110]);
ylim([0 80]);

figure('Name', 'ED Duration histogram without TMS');
histogram(EDduration_no_TMS, 'FaceColor', 'red');
grid on;
title('ED Duration histogram without TMS');
xlabel('Values');
ylabel('Count Of Frequencies');
xlim([0 110]);
ylim([0 80]);


%We can see that the data follows a probability distribution function that
%looks a lot like the exponential. On this next experiment, we are going to
%confirm that the exponential probability distribution is the best fit,
%compared to other pds that we know.


%We check the fits of different distributions that are well known.
distribution_names = {'Exponential', 'Gamma','Half Normal' ,'InverseGaussian','Lognormal','Normal','Rayleigh','Weibull'};

n = size(distribution_names, 2);

p_values_NO_TMS = zeros(n, 1);
p_values_TMS = zeros(n, 1);
pd_TMS = cell(n, 1);
pd_NO_TMS = cell(n, 1);


for i=1:n
    pd_NO_TMS{i} = fitdist(EDduration_no_TMS, distribution_names{i});
    [~, p_values_NO_TMS(i)]  = chi2gof(EDduration_no_TMS, 'CDF', pd_NO_TMS{i}, 'Alpha', alpha);
     pd_TMS{i} = fitdist(EDduration_TMS, distribution_names{i});
    [~, p_values_TMS(i)]  = chi2gof(EDduration_TMS, 'CDF', pd_TMS{i}, 'Alpha', alpha);
end

%On each of the distributions, the one with the biggest p-value is the one
%that we accept as more likely to be the best fit. This happens to be the
%exponential distribution.

[~, index_NO_TMS] = max(p_values_NO_TMS);
[~, index_TMS] = max(p_values_TMS);

best_fit_pd_TMS = pd_TMS{index_TMS};
best_fit_pd_NO_TMS = pd_NO_TMS{index_NO_TMS};


%We plot the distributions next to our data histogram in order to
%visuallize the fit. The visualization confirms that our data follows an
%exponential pdf

figure('Name', 'Best Fit for ED with TMS');
h = plot(best_fit_pd_TMS, "PlotType", "pdf");
lines = findobj(gca, 'Type', 'Line');
set(lines, 'Color', 'r');
title("Best Fit for ED with TMS");

figure('Name', 'Best Fit for ED without TMS');
plot(best_fit_pd_NO_TMS);
lines = findobj(gca, 'Type', 'Line');
set(lines, 'Color', 'r');
title("Best Fit for ED without TMS");

%It seems that both the ED duration with TMS, and the ED duration without
%TMS follow the same type of distribution, exponential. However, their mean
%values are not the same. We can easily see that the mean value of the pdf
%for ED duration without TMS is larger than the one with TMS. This is
%important for our experiment. It looks like the use of TMS does not affect
%the type of pdf that the ED duration follows, but it certainly affects
%its mean parameter, lowering it. That means that it is more likely for the
%duration of an epileptic discharce to be lower when we use TMS, and that
%is exactly the result expected, that follows previous scientific findings.

fprintf("The mean of the exp distribution without TMS is %.2f\n",best_fit_pd_NO_TMS.mean);
fprintf("The mean of the exp distribution with TMS is %.2f\n",best_fit_pd_TMS.mean);

