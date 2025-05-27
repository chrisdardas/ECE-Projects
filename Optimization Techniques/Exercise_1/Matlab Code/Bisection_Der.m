%Here I implement the Bisection with the use of the first derivative
%method exactly as mentioned in the book. The arguments of the function are
%the starting boundaries a and b the search scope lamda and the first
%derivative of the function. The function returns two vectors containing the change of
%boundaries for a given lamda and the number of repetitions of the process


function [a,b,k,lamda] = Bisection_Der(a,b,lamda,f)

n = 0;

while( (1/2)^n > (lamda/(b-a)))
    n = n + 1;
end

k = 1;

ak = [];
bk = [];
ak(1) = a;
bk(1) = b;


for k=1:n
    
    xk = (ak(k)+bk(k))/2;

    if (f(xk) > 0)

        ak(k+1) = ak(k);
        bk(k+1) = xk;

    elseif (f(xk) < 0)

        ak(k+1) = xk;
        bk(k+1) = bk(k);

    else
        return;
    end
end

a = ak;
b = bk;
end




