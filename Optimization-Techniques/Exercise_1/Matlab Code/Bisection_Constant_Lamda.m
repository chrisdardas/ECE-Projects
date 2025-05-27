clear;
syms x;
a = 0;
b = 3;
f1(x) = (x-1)^3 + (x-4)^2*cos(x);% Defining the functions of the problem
f2(x) = exp(-2*x) + (x-2)^2;
f3(x) = x^2*log(0.5*x) + sin(0.2*x)^2;
lamda = 0.01;% Setting the desired accurancy equal to 0.01


i = 0;

for epsilon = linspace(0.0001,0.0049,100)% Creating a vector epsilon which takes 100 values from 0.0001 up to 0.0049 and 
    %calls the Bisection Method so that we can observe how does the
    %different number of epsilon changes the number of function calls
    i = i + 1;
    [~,~,k_1(i),e_1(i),l_1(i)] = Bisection_Method(a,b,epsilon,lamda,f1);
    
end

nexttile;
plot(e_1,2*(k_1-1));% Here we plot the different values of epsilon with the number of function calls
title('$f_1(x)$ = $(x-1)^{3}$ + $(x-4)^{2}*cos(x)$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('ε');
ylabel('Number Of Function Calculations');

% We do the exact same process for the rest two functions
j = 0;

for epsilon = linspace(0.0001,0.0049,100)
    j = j + 1;
    [~,~,k_2(j),e_2(j),l_2(j)] = Bisection_Method(a,b,epsilon,lamda,f2);
    
end

nexttile;
plot(e_2,2*(k_2-1),'r');
title('$f_2(x)$ = $e^{-2x}$ + $(x-2)^{2}$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('ε');
ylabel('Number Of Function Calculations');

n = 0;

for epsilon = linspace(0.0001,0.0049,100)
    n = n + 1;
    [~,~,k_3(n),e_3(n),l_3(n)] = Bisection_Method(a,b,epsilon,lamda,f3);
    
end


nexttile;
plot(e_3,2*(k_3-1),'g');
title('$f_3(x)$ = $x^{2}ln{(0.5x)}$ + $sin(0.2x)^{2}$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('ε');
ylabel('Number Of Function Calculations');