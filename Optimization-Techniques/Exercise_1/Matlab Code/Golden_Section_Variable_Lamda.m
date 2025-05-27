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
    [~,~,k_1(i),l_1(i)] = Golden_Section_Method(a,b,lamda,f1);% Calling the method so we can get the number of repetitions and
    %plot it with the different values of lamda
    
end

nexttile;
plot(l_1,k_1+1);%Here we plot the number of function calls n = k + 1,where k represents the as a function of the different lamdas
%so that we can observe the declining of function calls as our search scope
%get bigger
title('$f_1(x)$ = $(x-1)^{3}$ + $(x-4)^{2}*cos(x)$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('l');
ylabel('Number Of Function Calculations');

j = 0;
%We do the exact same process for the other two functions
for lamda = linspace(0.0021,0.1,100)
    j = j + 1;
    [~,~,k_2(j),l_2(j)] = Golden_Section_Method(a,b,lamda,f2);
    
end

nexttile;
plot(l_2,k_2+1,'r');
title('$f_2(x)$ = $e^{-2x}$ + $(x-2)^{2}$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('l');
ylabel('Number Of Function Calculations');

n = 0;

for lamda = linspace(0.0021,0.1,100)
    n = n + 1;
    [~,~,k_3(n),l_3(n)] = Golden_Section_Method(a,b,lamda,f3);
    
end


nexttile;
plot(l_3,k_3+1,'g');
title('$f_3(x)$ = $x^{2}ln{(0.5x)}$ + $sin(0.2x)^{2}$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('l');
ylabel('Number Of Function Calculations');