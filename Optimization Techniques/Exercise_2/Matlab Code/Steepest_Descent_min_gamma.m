function [k,min_x,min_y,a,b] = Steepest_Descent_min_gamma(f,x1)
syms x y w

epsilon = 0.001;
lamda = 0.001;


k = 1;
a = [];
b = [];
a = x1(1); % a is the x variable
b = x1(2); % b is the y variable
gradf(x,y) = gradient(f,[x,y]);

z = zeros(2,5000);
z(:,1) = x1;

while(norm(gradf(a(k),b(k))) >= epsilon && k < 2000)
    
    
    d = -gradf(a(k),b(k));
    h(w) = f(z(1,k) + w*d(1),z(2,k) + w*d(2));
    gamma = Golden_Section_Modified(h,lamda,0,1);

    a(k+1) = a(k) + gamma*d(1);
    b(k+1) = b(k) + gamma*d(2);
    z(:,k+1) = [a(k+1),b(k+1)];
    disp(k)
    k = k + 1;
    
end

min_x = a(k);% get the smallest x value
min_y = b(k);% get the smallest y value

end