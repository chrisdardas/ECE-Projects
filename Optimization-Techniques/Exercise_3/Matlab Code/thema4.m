clear;

syms x y
f(x,y) = (1/3)*(x^2)+3*y^2;


gamma = 0.2;
epsilon = 0.01;
x0 = [8 -10];
s = 0.1;

[k1,min_x1,min_y1,gamma1,a1,b1]=Steepest_Descent_Projection(f,gamma,x0,epsilon,s);

hold on
for i=1:k1
    plot(i,f(a1(i),b1(i)),'r--*')
end

xlabel('Number of Iterations')
ylabel('$f(x_{k},y_{k})$','Interpreter','latex',Fontsize = 15)
title('Convergence of f','Interpreter','latex',Fontsize=20,FontWeight='bold')
figure

plot(a1,b1,'r--*')
axis equal
hold on
fcontour(f,'--','LineWidth',2)
legend('Number of Iterations')
xlabel('X')
ylabel('Y')
title('Constant γk')