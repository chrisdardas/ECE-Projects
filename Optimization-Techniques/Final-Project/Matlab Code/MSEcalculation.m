function MSE = MSEcalculation(chromosome)


   n = 1;
   for i = 1:5:75
    
     const(n) = chromosome(i);
     c1(n) = chromosome(i+1);
     c2(n) = chromosome(i+2);
     s1(n) = chromosome(i+3);
     s2(n) = chromosome(i+4);
     n = n + 1;

   end

MSE = 0;
value = 0;
  
for u1=linspace(-1,2,40)
   for u2=linspace(-2,1,40)
       for i=1:15
            part1 = 0.5 * ((u1-c1(i))^2)/(s1(i)^2);
            
            part2 = 0.5 * ((u2-c2(i))^2)/(s2(i)^2);

            power = part1 + part2;
            value = value + const(i)*exp(-power);
       end
        MSE=MSE+(sin(u1+u2)*sin(u2^2)-value)^2;
        value = 0;
   end
end



end

