clear;
syms x;
a = 0;
b = 3;
f1(x) = (x-1)^3 + (x-4)^2*cos(x);% Defining the functions of the problem
f2(x) = exp(-2*x) + (x-2)^2;
f3(x) = x^2*log(0.5*x) + sin(0.2*x)^2;
epsilon = 0.001;


i = 0;

for lamda = linspace(0.0021,0.1,100)%For a constant epsilon we try 100 different values of lamda ranging from 0.0021 to 0.1
    i = i + 1;
    [~,~,k_1(i),~,l_1(i)] = Bisection_Method(a,b,epsilon,lamda,f1);% That gives us a vector for the diffent lamdas and number k of repetitions 
    
end

nexttile;
plot(l_1,2*(k_1-1));% Here we plot the number of function calls which is n = 2*(k-1) where k represents the number of repetitions to get the desired accurancy
title('$f_1(x)$ = $(x-1)^{3}$ + $(x-4)^{2}*cos(x)$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('l');
ylabel('Number Of Function Calculations');

%We do the exact same process for the other two functions

j = 0;

for lamda = linspace(0.0021,0.1,100)
    j = j + 1;
    [~,~,k_2(j),~,l_2(j)] = Bisection_Method(a,b,epsilon,lamda,f2);
    
end

nexttile;
plot(l_2,2*(k_2-1),'r');
title('$f_2(x)$ = $e^{-2x}$ + $(x-2)^{2}$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('l');
ylabel('Number Of Function Calculations');

n = 0;

for lamda = linspace(0.0021,0.1,100)
    n = n + 1;
    [~,~,k_3(n),~,l_3(n)] = Bisection_Method(a,b,epsilon,lamda,f3);
    
end


nexttile;
plot(l_3,2*(k_3-1),'g');
title('$f_3(x)$ = $x^{2}ln{(0.5x)}$ + $sin(0.2x)^{2}$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('l');
ylabel('Number Of Function Calculations');