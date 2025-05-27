clear;

syms x y

f(x,y) = x^3*exp(-x^2-y^4);


x1 = [0 0]; % Converges Perfectly while x = {-1,-1}, % Diverges when the initial condition is x = {1,1} % Is static when the initial condition is x = {0,0}
x2 = [-1 -1];
x3 = [1 1];

[p,min_x_1,min_y_1,a,b] = LM_method_min_gamma(f,x1);

hold on
for i=1:p
    plot(i,f(a(i),b(i)),'r--*')
end
xlabel('Number of Iterations')
ylabel('$f(x_{k},y_{k})$','Interpreter','latex',Fontsize = 15)
title('Convergence of f','Interpreter','latex',Fontsize=20,FontWeight='bold')

figure
plot(a,b,'r--*')
axis equal
hold on
fcontour(f,'--','LineWidth',2)
legend('Number of Iterations')
xlabel('X')
ylabel('Y')
title('Minimum γk')
figure

[p,min_x_2,min_y_2,a,b] = LM_method_min_gamma(f,x2);

hold on
for i=1:p
    plot(i,f(a(i),b(i)),'r--*')
end
xlabel('Number of Iterations')
ylabel('$f(x_{k},y_{k})$','Interpreter','latex',Fontsize = 15)
title('Convergence of f','Interpreter','latex',Fontsize=20,FontWeight='bold')

figure
plot(a,b,'r--*')
axis equal
hold on
fcontour(f,'--','LineWidth',2)
legend('Number of Iterations')
xlabel('X')
ylabel('Y')
title('Minimum γk')
figure


[p,min_x_3,min_y_3,a,b] = LM_method_min_gamma(f,x3);

hold on
for i=1:p
    plot(i,f(a(i),b(i)),'r--*')
end
xlabel('Number of Iterations')
ylabel('$f(x_{k},y_{k})$','Interpreter','latex',Fontsize = 15)
title('Convergence of f','Interpreter','latex',Fontsize=20,FontWeight='bold')

figure
plot(a,b,'r--*')
axis equal
hold on
fcontour(f,'--','LineWidth',2)
legend('Number of Iterations')
xlabel('X')
ylabel('Y')
title('Minimum γk')
