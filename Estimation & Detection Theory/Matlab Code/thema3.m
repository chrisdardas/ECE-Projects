clc;
clearvars;
close all;
 
data = load('data.mat');
data = data.data';
histogram(data);
grid on
title("Histogram Of Data")
xlabel("Number of data");
ylabel("Value of data");

n_data = 1000;
%mle for lamda in exponential
mle_lamda_exp = (n_data*(1./sum(data)));

%mle for lamda in rayleigh
mle_lamda_ray = (1/sqrt(2*n_data))*sqrt(sum(data.^2));

%create the pdf of exponential using the mle_lamda_exp
x_exp = exprnd(1/mle_lamda_exp,n_data,1);

%create the pdf of rayleigh using the mle_lamda_ray
x_ray = raylrnd(mle_lamda_ray,n_data,1);

%exontas to figure() me ta dedomena, blepoume poio pdf apo tin
%rayleigh kai tin exponential tairiazei me to istogramma ton data

%figure() me to exponential
figure()
histogram(x_exp);
grid on
title("Exponential");
xlabel("Number of data");
ylabel("Value of data")

%figure() me tin rayleigh
figure();
histogram(x_ray);
grid on
title("Rayleigh");
xlabel("Number of data");
ylabel("Value of data");

figure()
histogram(data,FaceAlpha=1,FaceColor=[1 0 0]);
hold on
histogram(x_exp,FaceAlpha=0.2,FaceColor=[0 1 1]);
hold on
histogram(x_ray,FaceAlpha=0.6,FaceColor=[0 1 0]);

title("Comparison");
ylabel("Number of data");
xlabel("Values of data");


legend("data","exponential","rayleigh")