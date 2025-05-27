%This function implements the Bisection method as presented in the book.
%The function arguments are: a,b which represent the boundaries for which
%we search the minimum, epsilon  which is the distance from the bisector
%lamda which is the search scope where we look for the minimum and finally f is
%the function on which we want to implement the Bisection method
%This function returns the number k of repetitions to get the desired
%accurancy, two vectors an,bn representing the values that the boundaries
%get throught the process

function [an,bn,k,epsilon,lamda] = Bisection_Method(a,b,epsilon,lamda,f)

ak = [];
bk = [];
ak(1) = a;
bk(1) = b;
k = 1;


while (bk(k) - ak(k) > lamda)

    %k = k + 1;
    x1 = ((ak(k)+bk(k))/2) - epsilon;
    x2 = ((ak(k)+bk(k))/2) + epsilon;

    if (f(x1) < f(x2))
        bk(k+1) = x2;
        ak(k+1) = ak(k);
        k = k + 1;
        
    elseif(f(x1) >= f(x2))
        ak(k+1) = x1;
        bk(k+1) = bk(k);
        k = k + 1;
    end

end
an = ak;
bn = bk;
end

