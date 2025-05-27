function chromosome = generateChromosome(genomesize)

genes = zeros(1,genomesize);
[maxF,minF,upperlim1,downlim1,upperlim2,downlim2] = calculateBoundaries;

for i = 1 : 5 : genomesize
    genes(i) = minF + (maxF-minF)*rand; % const in front of gaussian
    genes(i+1) = downlim1 + (upperlim1-downlim1)*rand; % expected value 1
    genes(i+2) = downlim2 + (upperlim2-downlim2)*rand; % expected value 2
    genes(i+3) = 0.3 + (1.4-0.3)*rand; % variance 1
    genes(i+4) = 0.3 + (1.4-0.3)*rand; % variance 2
end
chromosome = genes;

end