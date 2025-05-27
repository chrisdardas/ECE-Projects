function mutated = mutation(selectedChromosomes,population)
% function to perform mutations on the population

[maxF,minF,upperlim1,downlim1,upperlim2,downlim2] = calculateBoundaries;


for i=1:population
    mutated_gene = randi(population);
    prob = rand;
    if prob < 0.1
        index(i) = i;
        for j = 1:5:75
            selectedChromosomes(mutated_gene,j)   = minF + (maxF-minF)*rand;
            selectedChromosomes(mutated_gene,j+1) = downlim1 + (upperlim1-downlim1)*rand;
            selectedChromosomes(mutated_gene,j+2) = downlim2 + (upperlim2-downlim2)*rand;
            selectedChromosomes(mutated_gene,j+3) = 0.3 + (1.4-0.3)*rand;
            selectedChromosomes(mutated_gene,j+4) = 0.3 + (1.4-0.3)*rand;
        %Perform a mutation
        end
    end
  

end
    
mutated = selectedChromosomes;


end


