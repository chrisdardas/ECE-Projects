function [Sum] = optimizeCurrents2(p)

I1 = p(1); 
I2 = p(2);
I3 = p(3);
I4 = p(4);
I5 = p(5);

theta = 0:(pi/180):70*(pi/180);

Sum = 0 ;
w = linspace(1,27.5,71);
for i=1:length(theta)
    theta1 = theta(i);
    fz = pi*cos(theta1);
    A = I1*(1+exp(j*9*fz))+I2*(exp(j*fz)+exp(j*8*fz))+I3*(exp(j*2*fz)+exp(j*7*fz))+I4*(exp(j*3*fz)+exp(j*6*fz))+I5*(exp(j*4*fz)+exp(j*5*fz));

    AF = abs(A);
    

    Sum = Sum + (w(i))*AF;
   
end

end



