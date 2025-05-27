clear;

syms x;
a = 0;
b = 3;

f1(x) = (x-1)^3 + (x-4)^2*cos(x);% Defining the functions of the problem
f2(x) = exp(-2*x) + (x-2)^2;
f3(x) = x^2*log(0.5*x) + sin(0.2*x)^2;




i = 0;

for lamda = linspace(0.0021,0.1,100)%Creating a vector lamda with 100 values ranging from 0.0021 up to 0.1
    i = i + 1;
    [~,~,k_1(i),l_1(i),calls_1(i)] = Fibonacci_Method(a,b,lamda,f1);% Calling the Fibonacci method so we can get the number of repetitions and
    %plot it with the different values of lamda
    
end

nexttile;
plot(l_1,calls_1);%Here we plot the number of function calls n = k + 3(because we have two calls of the function in the beginning and one when k=n-2)
%where k represents the as a function of the different lamdas
%so that we can observe the declining of function calls as our search scope
%get bigger
title('$f_1(x)$ = $(x-1)^{3}$ + $(x-4)^{2}*cos(x)$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('l');
ylabel('Number Of Function Calculations');

j = 0;
%We do the exact same process for the other two functions
for lamda = linspace(0.0021,0.1,100)
    j = j + 1;
    [~,~,k_2(j),l_2(j),calls_2(j)] = Fibonacci_Method(a,b,lamda,f2);
    
end

nexttile;
plot(l_2,calls_2,'r');
title('$f_2(x)$ = $e^{-2x}$ + $(x-2)^{2}$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('l');
ylabel('Number Of Function Calculations');

m = 0;

for lamda = linspace(0.0021,0.1,100)
    m = m + 1;
    [~,~,k_3(m),l_3(m),calls_3(m)] = Fibonacci_Method(a,b,lamda,f3);
    
end


nexttile;
plot(l_3,calls_3,'g');
title('$f_3(x)$ = $x^{2}ln{(0.5x)}$ + $sin(0.2x)^{2}$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('l');
ylabel('Number Of Function Calculations');