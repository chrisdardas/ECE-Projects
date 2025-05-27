function Gaussian = fittingFunction(chromosome)
syms x y

gaussianFunctions = cell(1,15);

   n = 1;
   for i = 1:5:75
    
     const = chromosome(i);
     c1 = chromosome(i+1);
     c2 = chromosome(i+2);
     s1 = chromosome(i+3);
     s2 = chromosome(i+4);

     power = (x-c1)^2/(2*(s1)^2) + (y-c2)^2/(2*(s2)^2);
     G(x,y) = const*exp(-power);
     gaussianFunctions{n} = G;
     n = n + 1;

   end

Gaussian = gaussianFunctions{1};
    for j=2:15 
        Gaussian = Gaussian + gaussianFunctions{j};
    end



end