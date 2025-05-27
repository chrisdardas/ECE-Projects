clear;
clc;
maxgenerations = 10000;
population = 100; 
numberofGaussians = 15;
chromosomesize = numberofGaussians*5; 
err = zeros(maxgenerations,1);

syms u1 u2
f(u1,u2) = sin(u1+u2)*sin(u2^2);


    
    
chromosomes = zeros(population,chromosomesize); %100x75
    

for i=1:population
  chromosomes(i,:) = generateChromosome(chromosomesize);
  
end


crossovers = intermediateCrossover(chromosomes,population);
new_generation = mutation(crossovers,population);


    


  


for i=1:maxgenerations
  
       
        crossovers = intermediateCrossover(new_generation,population);
        new_generation = mutation(crossovers,population);
      
        best = bestfitness(population,new_generation);
        [~,index] = max(best);
        best_chromosome_generations(i,:)=new_generation(index,:);
        err(i) = MSEcalculation(best_chromosome_generations(i,:));
     

end





best = bestfitness(population,new_generation);


[~,index] = max(best);

best_chromosome=new_generation(index,:);

best_function = fittingFunction(best_chromosome);


figure
plot(1:maxgenerations,err)
title('Best Fitness')
xlabel('Generations')
ylabel('ΜSE')
figure

nexttile
fsurf(best_function,[-1 2 -2 1])
xlabel('X');
ylabel('Y');
title('Αποτέλεσμα του γενετικού αλγορίθμου')

nexttile
fsurf(f,[-1 2 -2 1])
xlabel('X');
ylabel('Y');
title('Πραγματική συνάρτηση')
colorbar


figure

nexttile
fsurf(best_function)
xlabel('X');
ylabel('Y');
title('Αποτέλεσμα του γενετικού αλγορίθμου')
nexttile
fsurf(f)
xlabel('X');
ylabel('Y');
title('Πραγματική συνάρτηση')
colorbar




