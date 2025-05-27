clear;


syms x y
f = 1/3*x^2+3*y^2;


gamma = 0.1;
epsilon = 0.001;
x0 = [1 1];

[k1,min_x1,min_y1,gamma1,a1,b1]=Steepest_Descent(f,gamma,x0,epsilon);
plot(a1,b1,'r--*')
axis equal
hold on
fcontour(f,'--','LineWidth',2)
legend('Number of Iterations')
xlabel('X')
ylabel('Y')
title('Constant γk')

gamma = 0.3;

[k2,min_x2,min_y2,gamma2,a2,b2]=Steepest_Descent(f,gamma,x0,epsilon);
figure
plot(a2,b2,'r--*')
axis equal
hold on
fcontour(f,'--','LineWidth',2)
legend('Number of Iterations')
xlabel('X')
ylabel('Y')
title('Constant γk')

gamma = 3;

[k3,min_x3,min_y3,gamma3,a3,b3]=Steepest_Descent(f,gamma,x0,epsilon);

gamma = 5;

[k4,min_x4,min_y4,gamma4,a4,b4]=Steepest_Descent(f,gamma,x0,epsilon);


