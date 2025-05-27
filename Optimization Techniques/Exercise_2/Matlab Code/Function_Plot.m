clear;

syms x y


f(x,y) = x^3*exp(-x^2-y^4);

fsurf(f,[-2 2 -2 2],'ShowContours','on');
xlabel('x axis');
ylabel('y axis');
title('$f(x,y)$ = $x^{3}e^{-x^{2}-y^{4}}$','Interpreter', 'latex',FontSize=20,FontWeight='bold')

colorbar
box on;

%figure
%fcontour(f,'--','LineWidth',2)

