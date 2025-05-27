function [maxF,minF,upperlim1,downlim1,upperlim2,downlim2] = calculateBoundaries

f = @(u1,u2) sin(u1 + u2)*sin(u2^2);

u1 = linspace(-1,2,25);
u2 = linspace(-2,1,25);

for i=1:length(u1)
    for j=1:length(u2)
        val(i,j) = f(u1(i),u2(j));
    end
end

maxF = max(max(val));
minF = min(min(val));

upperlim1 = 2 + 3;
downlim1 = -1 - 3;

upperlim2 = 1 + 3;
downlim2 = -2 - 3;



end