clearvars;
clc;
close all;

N = 5000; % Number of experiments
n = 10; % Number of samples for a given experiment 

lamda = 2;
%1.1. ypologismos toy katotatou oriou tis diasporas tis ektimisis toy λ
lb_var_lamda = (lamda^2)/n; % CRLB variance


%create n x N random variables from an exponential distribution 
X = exprnd(1/lamda,n,N) ;
x_vector = zeros(n,1);
lamda_estimator = sqrt(lb_var_lamda)*randn(1,N) + lamda;
figure();
%1.1. Apeikonizoume to istogramma enos ameroliptou ektimiti 
histogram(lamda_estimator);
grid on
title('Unbiased Estimator for Lambda(n=10)')
xlabel('Values of Lambda')

var_lamda_estimator = var(lamda_estimator);
mean_lamda_estimator = mean(lamda_estimator);


%================================================================
%1.2 briskoume ton MLE toy λ kai apeikonizoume to istogramma toy 
%gia 5000 diaforetika peiramata metrisis me 10 metriseis ana peirama
mle_estimator = (n*(1./sum(X)));
var_mle_estimator = var(mle_estimator);
mean_mle_estimator = mean(mle_estimator);
figure();
histogram(mle_estimator);
title("MLE for λ(n=10)");
xlabel("λ values");
grid on;


mean_value_diff1 = mean_mle_estimator - mean_lamda_estimator;
var_value_diff1 = var_mle_estimator - var_lamda_estimator;

%===============================================================
%1.3 epanalmbanoume ta proigoumena 2 erotimata gia 20,50, kai 100 metriseis 
%ana peirama. Ara to n ginetai 20,50,100
N = 5000; % Number of experiments
n = 20; % Number of samples for a given experiment 

lamda = 2;
%1.1. ypologismos toy katotatou oriou tis diasporas tis ektimisis toy λ
lb_var_lamda = (lamda^2)/n; % CRLB variance


%create n x N random variables from an exponential distribution 
X = exprnd(1/lamda,n,N) ;
x_vector = zeros(n,1);
lamda_estimator = sqrt(lb_var_lamda)*randn(1,N) + lamda;
figure();
%1.1. Apeikonizoume to istogramma enos ameroliptou ektimiti 
histogram(lamda_estimator);
grid on
title('Unbiased Estimator for Lambda(n=20)')
xlabel('Values of Lambda')

var_lamda_estimator = var(lamda_estimator);
mean_lamda_estimator = mean(lamda_estimator);


%================================================================
mle_estimator = (n*(1./sum(X)));
var_mle_estimator = var(mle_estimator);
mean_mle_estimator = mean(mle_estimator);
figure();
histogram(mle_estimator);
title("MLE for λ(n=20)");
xlabel("λ values");
grid on;


mean_value_diff2 = mean_mle_estimator - mean_lamda_estimator;
var_value_diff2 = var_mle_estimator - var_lamda_estimator;
%================================================================
%1.3 epanalmbanoume ta proigoumena 2 erotimata gia 20,50, kai 100 metriseis 
%ana peirama. Ara to n ginetai 20,50,100
N = 5000; % Number of experiments
n = 50; % Number of samples for a given experiment 

lamda = 2;
%1.1. ypologismos toy katotatou oriou tis diasporas tis ektimisis toy λ
lb_var_lamda = (lamda^2)/n; % CRLB variance


%create n x N random variables from an exponential distribution 
X = exprnd(1/lamda,n,N) ;
x_vector = zeros(n,1);
lamda_estimator = sqrt(lb_var_lamda)*randn(1,N) + lamda;
figure();
%1.1. Apeikonizoume to istogramma enos ameroliptou ektimiti 
histogram(lamda_estimator);
grid on
title('Unbiased Estimator for Lambda(n=50)')
xlabel('Values of Lambda')

var_lamda_estimator = var(lamda_estimator);
mean_lamda_estimator = mean(lamda_estimator);


%================================================================
mle_estimator = (n*(1./sum(X)));
var_mle_estimator = var(mle_estimator);
mean_mle_estimator = mean(mle_estimator);
figure();
histogram(mle_estimator);
title("MLE for λ(n=50)");
xlabel("λ values");
grid on;


mean_value_diff3 = mean_mle_estimator - mean_lamda_estimator;
var_value_diff3 = var_mle_estimator - var_lamda_estimator;
%================================================================
%1.3 epanalmbanoume ta proigoumena 2 erotimata gia 20,50, kai 100 metriseis 
%ana peirama. Ara to n ginetai 20,50,100
N = 5000; % Number of experiments
n = 100; % Number of samples for a given experiment 

lamda = 2;
%1.1. ypologismos toy katotatou oriou tis diasporas tis ektimisis toy λ
lb_var_lamda = (lamda^2)/n; % CRLB variance


%create n x N random variables from an exponential distribution 
X = exprnd(1/lamda,n,N) ;
x_vector = zeros(n,1);
lamda_estimator = sqrt(lb_var_lamda)*randn(1,N) + lamda;
figure();
%1.1. Apeikonizoume to istogramma enos ameroliptou ektimiti 
histogram(lamda_estimator);
grid on
title('Unbiased Estimator for Lambda(n=100)')
xlabel('Values of Lambda')

var_lamda_estimator = var(lamda_estimator);
mean_lamda_estimator = mean(lamda_estimator);


%================================================================
mle_estimator = (n*(1./sum(X)));
var_mle_estimator = var(mle_estimator);
mean_mle_estimator = mean(mle_estimator);
figure();
histogram(mle_estimator);
title("MLE for λ(n=100)");
xlabel("λ values");
grid on;


mean_value_diff4 = mean_mle_estimator - mean_lamda_estimator;
var_value_diff4 = var_mle_estimator - var_lamda_estimator;

