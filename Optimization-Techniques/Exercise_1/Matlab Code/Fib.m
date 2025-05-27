%Here I create a function which it will give me the needed terms of the
%Fibonacci sequence whenever it is called during the Fibonacci
%optimization method



function [Fibonacci] = Fib(n)

prev = 1;
current = 1;


if n == 0
    Fibonacci = 1;

elseif n == 1
    Fibonacci = 1;

else
    for i = 2:n
        next = current + prev;
        prev = current;
        current = next;
    end
end

Fibonacci = current;

end

