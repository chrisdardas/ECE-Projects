%This file is for the comparison of the forementioned methods the process
%is the exact same but here we plot the 3 different function for all the 4
%different methods in order to compare the efficiency of the algorithms
clear;
syms x;
a = 0;
b = 3;
f1(x) = (x-1)^3 + (x-4)^2*cos(x);
f2(x) = exp(-2*x) + (x-2)^2;
f3(x) = x^2*log(0.5*x) + sin(0.2*x)^2;
epsilon = 0.001;

g1(x) = diff(f1,x);
g2(x) = diff(f2,x);
g3(x) = diff(f3,x);

i = 0;

for lamda = linspace(0.0021,0.1,100)%Creating a vector lamda with 100 values ranging from 0.0021 up to 0.1
    i = i + 1;
    [~,~,k_1(i),l_1(i)] = Bisection_Der(a,b,lamda,g1);
end
plot(l_1,k_1,'r');
title('$f_1(x)$ = $(x-1)^{3}$ + $(x-4)^{2}*cos(x)$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('l');
ylabel('Number Of Function Calculations');
hold on

j = 0;

for lamda = linspace(0.0021,0.1,100)%Creating a vector lamda with 100 values ranging from 0.0021 up to 0.1
    j = j + 1;
    [~,~,k_2(j),~,l_2(j)] = Bisection_Method(a,b,epsilon,lamda,f1);
end

plot(l_2,2*(k_2-1),'b');

n = 0;

for lamda = linspace(0.0021,0.1,100)%Creating a vector lamda with 100 values ranging from 0.0021 up to 0.1
    n = n + 1;
    [~,~,k_3(n),l_3(n)] = Golden_Section_Method(a,b,lamda,f1);
end

plot(l_3,k_3+1,'k');

m = 0;

for lamda = linspace(0.0021,0.1,100)%Creating a vector lamda with 100 values ranging from 0.0021 up to 0.1
    m = m + 1;
    [~,~,k_4(m),l_4(m),calls_1(m)] = Fibonacci_Method(a,b,lamda,f1);
end

plot(l_4,calls_1,'g');
hold off
legend('Bisection-Derivative','Bisection','Golden-Section','Fibonacci')

figure

i = 0;

for lamda = linspace(0.0021,0.1,100)%Creating a vector lamda with 100 values ranging from 0.0021 up to 0.1
    i = i + 1;
    [~,~,k_1(i),l_1(i)] = Bisection_Der(a,b,lamda,g2);
end
plot(l_1,k_1,'r');
title('$f_2(x)$ = $e^{-2x}$ + $(x-2)^{2}$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('l');
ylabel('Number Of Function Calculations');
hold on

j = 0;

for lamda = linspace(0.0021,0.1,100)%Creating a vector lamda with 100 values ranging from 0.0021 up to 0.1
    j = j + 1;
    [~,~,k_2(j),~,l_2(j)] = Bisection_Method(a,b,epsilon,lamda,f2);
end

plot(l_2,2*(k_2-1),'b');

n = 0;

for lamda = linspace(0.0021,0.1,100)%Creating a vector lamda with 100 values ranging from 0.0021 up to 0.1
    n = n + 1;
    [~,~,k_3(n),l_3(n)] = Golden_Section_Method(a,b,lamda,f2);
end

plot(l_3,k_3+1,'k');

m = 0;

for lamda = linspace(0.0021,0.1,100)%Creating a vector lamda with 100 values ranging from 0.0021 up to 0.1
    m = m + 1;
    [~,~,k_4(m),l_4(m),calls_2(m)] = Fibonacci_Method(a,b,lamda,f2);
end

plot(l_4,calls_2,'g');
hold off
legend('Bisection-Derivative','Bisection','Golden-Section','Fibonacci')

figure

i = 0;

for lamda = linspace(0.0021,0.1,100)%Creating a vector lamda with 100 values ranging from 0.0021 up to 0.1
    i = i + 1;
    [~,~,k_1(i),l_1(i)] = Bisection_Der(a,b,lamda,g3);
end
plot(l_1,k_1,'r');
title('$f_3(x)$ = $x^{2}ln{(0.5x)}$ + $sin(0.2x)^{2}$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('l');
ylabel('Number Of Function Calculations');
hold on

j = 0;

for lamda = linspace(0.0021,0.1,100)%Creating a vector lamda with 100 values ranging from 0.0021 up to 0.1
    j = j + 1;
    [~,~,k_2(j),~,l_2(j)] = Bisection_Method(a,b,epsilon,lamda,f3);
end

plot(l_2,2*(k_2-1),'b');

n = 0;

for lamda = linspace(0.0021,0.1,100)%Creating a vector lamda with 100 values ranging from 0.0021 up to 0.1
    n = n + 1;
    [~,~,k_3(n),l_3(n)] = Golden_Section_Method(a,b,lamda,f3);
end

plot(l_3,k_3+1,'k');

m = 0;

for lamda = linspace(0.0021,0.1,100)%Creating a vector lamda with 100 values ranging from 0.0021 up to 0.1
    m = m + 1;
    [~,~,k_4(m),l_4(m),calls_3(m)] = Fibonacci_Method(a,b,lamda,f3);
end

plot(l_4,calls_3,'g');
hold off
legend('Bisection-Derivative','Bisection','Golden-Section','Fibonacci')