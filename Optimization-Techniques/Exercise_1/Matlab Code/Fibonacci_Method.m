%Here I implement the Fibonacci method as a separate function exactly as
%mentioned in the book. The function arguments are the initial boundaries
%of the problem, the search scope lamda and the convex function f for which we
%search the minimum. It returns two vectors containing the change of
%boundaries for a given lamda and the number of repetitions of the process


function [ak,bk,k,lamda,calls] = Fibonacci_Method(a,b,lamda,f)

k = 1;
n = 0;
an = [];
bn = [];
x1 = [];
x2 = [];
an(1) = a;
bn(1) = b;
epsilon =0.0001;
calls = 2;

while (Fib(n) <= (b-a)/lamda)
    n = n + 1;
end

x1(k) = (Fib(n-k-1)/Fib(n-k+1)) * (bn(k)-an(k)) + an(k);
x2(k) = (Fib(n-k)/Fib(n-k+1)) * (bn(k)-an(k)) + an(k);
calls = 2;

for k=1:n-1

    if (f(x2(k)) >= f(x1(k)))

        an(k+1) = an(k);
        bn(k+1) = x2(k);
        x2(k+1) = x1(k);
        x1(k+1) = an(k+1) + (Fib(n-k-2)/Fib(n-k)) * (bn(k+1) - an(k+1));

        if(k == n -2)
            x1(n) = x1(n-1);
            x2(n) = x1(n-1) + epsilon;

            if (f(x1(n)) > f(x2(n)))

                an(n) = x1(n);
                bn(n) = bn(n-1);
                break;

            else 

                an(n) = an(n-1);
                bn(n) = x2(n);
                break;
            
            end
        end
        

    elseif(f(x2(k)) < f(x1(k)))

        an(k+1) = x1(k);
        bn(k+1) = bn(k);
        x1(k+1) = x2(k);
        x2(k+1) = an(k+1) + (Fib(n-k-1)/Fib(n-k))*(bn(k+1) - an(k+1));

        if(k == n -2)

            x1(n) = x1(n-1);
            x2(n) = x1(n-1) + epsilon;

            if (f(x1(n)) > f(x2(n)))

                an(n) = x1(n);
                bn(n) = bn(n-1);
                break;

            else 

                an(n) = an(n-1);
                bn(n) = x2(n);
                break;

            end
        end

       
    end

end

ak = an;
bk = bn;
calls = n;

end

    