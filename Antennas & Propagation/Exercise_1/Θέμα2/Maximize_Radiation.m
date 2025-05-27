clear;
f = @(x)-cos(pi/2*sin(x))/cos(x);

x1 = 0;
x2 = pi;

solution = fminbnd(f,x1,x2);
