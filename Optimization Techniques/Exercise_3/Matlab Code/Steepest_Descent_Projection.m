function [k,min_x,min_y,gamma,a,b] = Steepest_Descent_Projection(f,gamma,x1,epsilon,s)

syms x y


k = 1;
a = [];
b = [];
a = x1(1); % a is the x variable
b = x1(2); % b is the y variable
gradf(x,y) = gradient(f,[x,y]);




while(norm(gradf(a(k),b(k))) >= epsilon && k < 2000)
    

    proj = Projection(s,a(k),b(k));% finds the projection on the curve set X
    d = proj - [a(k),b(k)];% finds the feasible direction
    a(k+1) = a(k) + gamma*d(1);
    b(k+1) = b(k) + gamma*d(2);
    disp(k)
    k = k + 1;
    
end

min_x = a(k);% get the smallest x value
min_y = b(k);% get the smallest y value


end