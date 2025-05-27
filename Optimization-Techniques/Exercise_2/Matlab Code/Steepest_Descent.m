function [k,min_x,min_y,gamma,a,b] = Steepest_Descent(f,gamma,x1,epsilon)

syms x y



k = 1;
a = [];
b = [];
a = x1(1); % a is the x variable
b = x1(2); % b is the y variable
gradf(x,y) = gradient(f,[x,y]);




while(norm(gradf(a(k),b(k))) >= epsilon && k < 2000)

    d = -gradf(a(k),b(k));
  
    a(k+1) = a(k) + gamma*d(1);
    b(k+1) = b(k) + gamma*d(2);
    disp(k)
    k = k + 1;
    
end

min_x = a(k);% get the smallest x value
min_y = b(k);% get the smallest y value


end

