function [gamma] = Armijo(f,d,a,b)

syms x y
alpha = 0.001;
beta = 0.3;
s = 1;
m = 0;
gradf(x,y) = gradient(f,[x,y]);

d_transpose = transpose(d);

gamma = s*beta^(m);
value = alpha*(beta^(m))*s*d_transpose*gradf(a,b);


f1 = double(f(a,b));
f2 = double(f(a+gamma*d(1),b+gamma*d(2)));

while ((f1 - f2 + value < 0)  && m < 300)
            disp(m)
            m = m + 1;
            gamma = s*beta^(m);
            f1 = double(f(a,b));
            f2 = double(f(a+gamma*d(1),b+gamma*d(2)));
            value = alpha*(beta^(m))*s*d_transpose*gradf(a,b);
end


end
