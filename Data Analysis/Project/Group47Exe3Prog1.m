clc;
clearvars;
close all;


data = readtable("TMS.xlsx");
mask = (data.TMS == 0);

ED_NO_TMS = data.EDduration(mask);
ED_TMS = data.EDduration(~mask);
Setup_NO_TMS = data.Setup(mask);
Setup_TMS = data.Setup(~mask);

mu_0 = mean(ED_NO_TMS); % mean value of the whole set
alpha = 0.05;
B = 1e4;
figure();
for i=1:6
    subplot(2, 3, i);
    histogram(ED_NO_TMS(Setup_NO_TMS == i));
    title(sprintf("Setup %d", i));
    grid on;
    xlabel("Values");
    ylabel("Count Of Frequencies");
    sgtitle("Histograms for each Setup value withoutTMS");
end

figure();
for i=1:6
    subplot(2, 3, i);
    boxplot(ED_NO_TMS(Setup_NO_TMS == i));
    title(sprintf("Setup %d", i));
    sgtitle("Boxplots for each Setup value without TMS");
end

figure();
for i=1:6
    subplot(2, 3, i);
    histogram(ED_TMS(Setup_TMS == i));
    title(sprintf("Setup %d", i));
    grid on;
    xlabel("Values");
    ylabel("Count Of Frequencies");
    sgtitle("Histograms for each Setup value with TMS");
end

figure();
for i=1:6
    subplot(2, 3, i);
    boxplot(ED_TMS(Setup_TMS == i));
    title(sprintf("Setup %d", i));
    sgtitle("Boxplots for each Setup value with TMS");
end

% From the above histograms and boxplots we can clearly see that none of
% the given samples can be assumed to follow a Normal Distribution.
% We used chi^2 testing to assess whether the samples follow normal
% distributions and the test came positive for some. However, this result
% is misleading. Chi^2 testing is dependant on the partioning of the sample
% and the sample size. For the test to work well we need to have a
% relatively sample size(n>30). So we can disregard these results as
% invalid. Therefore we will use Bootstrap analysis to check the means for
% all samples.


[h_normal1, h1, CI_1] = Group47Exe3Func1(ED_NO_TMS, Setup_NO_TMS, alpha, B);
[h_normal2, h2, CI_2] = Group47Exe3Func1(ED_TMS, Setup_TMS, alpha, B);


% We created a function that returns 0 if the mean value 
% mu_0 (as described in the excercise) is inside the confidence
% interval and 1 if not. If 1 is returned, that means that the hypothesis
% that mu_0 is the mean of the specific sample can be rejected.

fprintf("Hypothesis testing for Setup 1-6 without TMS\n");
disp(h1);
fprintf("Hypothesis testing for Setup 1-6 with TMS\n");
disp(h2);













