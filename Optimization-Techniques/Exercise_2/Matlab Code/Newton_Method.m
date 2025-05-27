function [k,min_x,min_y,a,b] = Newton_Method(f,gamma,x1)

syms x y

epsilon = 0.001;
k = 1;

gradf(x,y) = gradient(f,[x,y]);
Hessian(x,y) = hessian(f,[x,y]);

a = [];
b = [];
a(1) = x1(1);
b(1) = x1(2);

while(norm(gradf(a(k),b(k))) >= epsilon && k < 2000)
    
    A = Hessian(a(k),b(k));

    %if (det(A) > 0 && A(1,1) > 0)
        d = -inv(A)*gradf(a(k),b(k));

        a(k+1) = a(k) + gamma*d(1);
        b(k+1) = b(k) + gamma*d(2);

        k = k + 1;
        disp(k)
    %else
       % break;
    %end
end

min_x = a(k);
min_y = b(k);

end


