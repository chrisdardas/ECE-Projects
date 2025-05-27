clear;
syms x;
a = 0;
b = 3;
f1(x) = (x-1)^3 + (x-4)^2*cos(x);% Defining the functions of the problem
f2(x) = exp(-2*x) + (x-2)^2;
f3(x) = x^2*log(0.5*x) + sin(0.2*x)^2;

g1(x) = diff(f1,x);%Finding the first derivative of the function which will be used in the method
g2(x) = diff(f2,x);
g3(x) = diff(f3,x);

[a1,b1,k] = Bisection_Der(a,b,0.0021,g1);
%Calling the Bisection_Der method for a specific lamda = 0.0021 so we 
%can plot how the boundaries change with these parameters as a function of
%the repetitions. However this time we use the method in the first
%derivative of the function instead of the function itself


nexttile

for i = 0:k
    plot(i,a1(i+1),'bo')
    hold on
    plot(i,b1(i+1),'r*')
end

% We plot the change for boundaries on the same graph for the value of
% lamda = 0.0021

title('$f_1(x)$ = $(x-1)^{3}$ + $(x-4)^{2}*cos(x)$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('Number of Iterations')
ylabel('[ak,bk]')
legend('L=0.0021')
hold off
nexttile

% We plot the change for boundaries on the same graph for the value of
% lamda = 0.005

[a1,b1,k] = Bisection_Der(a,b,0.005,g1);

for i = 0:k
    plot(i,a1(i+1),'bo')
    hold on
    plot(i,b1(i+1),'r*')
end

title('$f_1(x)$ = $(x-1)^{3}$ + $(x-4)^{2}*cos(x)$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('Number of Iterations')
ylabel('[ak,bk]')
legend('L=0.005')
hold off
nexttile

% We plot the change for boundaries on the same graph for the value of
% lamda = 0.01

[a1,b1,k] = Bisection_Der(a,b,0.01,g1);

for i = 0:k
    plot(i,a1(i+1),'bo')
    hold on
    plot(i,b1(i+1),'r*')
end

title('$f_1(x)$ = $(x-1)^{3}$ + $(x-4)^{2}*cos(x)$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('Number of Iterations')
ylabel('[ak,bk]')
legend('L=0.01')
hold off
nexttile

% We plot the change for boundaries on the same graph for the value of
% lamda = 0.02

[a1,b1,k] = Bisection_Der(a,b,0.02,g1);

for i = 0:k
    plot(i,a1(i+1),'bo')
    hold on
    plot(i,b1(i+1),'r*')
end

title('$f_1(x)$ = $(x-1)^{3}$ + $(x-4)^{2}*cos(x)$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('Number of Iterations')
ylabel('[ak,bk]')
legend('L=0.02')
hold off

figure

%We do the exact foretold process for the other two function to observe how
%the boundaries  change with the same lamdas we did for function f1(x)

nexttile

[a2,b2,k] = Bisection_Der(a,b,0.0021,g2);
for i = 0:k
    plot(i,a2(i+1),'bo')
    hold on
    plot(i,b2(i+1),'r*')
end

title('$f_2(x)$ = $e^{-2x}$ + $(x-2)^{2}$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('Number of Iterations')
ylabel('[ak,bk]')
legend('L=0.0021')
hold off
nexttile

[a2,b2,k] = Bisection_Der(a,b,0.005,g2);

for i = 0:k
    plot(i,a2(i+1),'bo')
    hold on
    plot(i,b2(i+1),'r*')
end

title('$f_2(x)$ = $e^{-2x}$ + $(x-2)^{2}$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('Number of Iterations')
ylabel('[ak,bk]')
legend('L=0.005')
hold off
nexttile

[a2,b2,k] = Bisection_Der(a,b,0.01,g2);

for i = 0:k
    plot(i,a2(i+1),'bo')
    hold on
    plot(i,b2(i+1),'r*')
end

title('$f_2(x)$ = $e^{-2x}$ + $(x-2)^{2}$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('Number of Iterations')
ylabel('[ak,bk]')
legend('L=0.01')
hold off
nexttile

[a2,b2,k] = Bisection_Der(a,b,0.02,g2);

for i = 0:k
    plot(i,a2(i+1),'bo')
    hold on
    plot(i,b2(i+1),'r*')
end

title('$f_2(x)$ = $e^{-2x}$ + $(x-2)^{2}$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('Number of Iterations')
ylabel('[ak,bk]')
legend('L=0.02')
hold off

figure

nexttile

[a3,b3,k] = Bisection_Der(a,b,0.0021,g3);
for i = 0:k
    plot(i,a3(i+1),'bo')
    hold on
    plot(i,b3(i+1),'r*')
end

title('$f_3(x)$ = $x^{2}ln{(0.5x)}$ + $sin(0.2x)^{2}$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('Number of Iterations')
ylabel('[ak,bk]')
legend('L=0.0021')
hold off
nexttile

[a3,b3,k] = Bisection_Der(a,b,0.005,g3);

for i = 0:k
    plot(i,a3(i+1),'bo')
    hold on
    plot(i,b3(i+1),'r*')
end

title('$f_3(x)$ = $x^{2}ln{(0.5x)}$ + $sin(0.2x)^{2}$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('Number of Iterations')
ylabel('[ak,bk]')
legend('L=0.005')
hold off
nexttile

[a3,b3,k] = Bisection_Der(a,b,0.01,g3);

for i = 0:k
    plot(i,a3(i+1),'bo')
    hold on
    plot(i,b3(i+1),'r*')
end

title('$f_3(x)$ = $x^{2}ln{(0.5x)}$ + $sin(0.2x)^{2}$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('Number of Iterations')
ylabel('[ak,bk]')
legend('L=0.01')
hold off
nexttile

[a3,b3,k] = Bisection_Der(a,b,0.02,g3);

for i = 0:k
    plot(i,a3(i+1),'bo')
    hold on
    plot(i,b3(i+1),'r*')
end

title('$f_3(x)$ = $x^{2}ln{(0.5x)}$ + $sin(0.2x)^{2}$','Interpreter', 'latex',FontSize=15,FontWeight='bold')
xlabel('Number of Iterations')
ylabel('[ak,bk]')
legend('L=0.02')
hold off
