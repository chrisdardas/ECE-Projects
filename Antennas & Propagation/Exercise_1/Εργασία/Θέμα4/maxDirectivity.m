function [D] = maxDirectivity(p)

I1 = p(1); 
I2 = p(2);
I3 = p(3);
I4 = p(4);
I5 = p(5);

I10 = I1; 
I9 = I2;
I8 = I3;
I7 = I4;
I6 = I5;

kd = pi;

I = [I1 I2 I3 I4 I5 I6 I7 I8 I9 I10];

Sum1 = 0;
Sum2 = 0;

for i = 1:10
    Sum1 = Sum1 + I(i);
end




for n = 1:10
    for m = 1:10
        if(n == m)
            Sum2 = Sum2 + I(n)*conj(I(m))*kd;
        else
            Sum2 = Sum2 + I(n)*conj(I(m))*(sin(kd*(n-m))/(n-m));
        end

    end
end


D = -kd*(Sum1)^2/Sum2;
end