function new_generation = intermediateCrossover(chromosomes,population)

selectedChromosomes = selection(population,chromosomes);

iterations = population/4;
% a(i) = parent1*b + parent2*(1-b)
b_A =  -0.25 + 1.5*rand(iterations,1);% b randomly in [-0.25,1.25]
b_c1 = -0.25 + 1.5*rand(iterations,1);% b randomly in [-0.25,1.25]
b_c2 = -0.25 + 1.5*rand(iterations,1);% b randomly in [-0.25,1.25]
b_s1 = -0.25 + 1.5*rand(iterations,1);% b randomly in [-0.25,1.25]
b_s2 = -0.25 + 1.5*rand(iterations,1);% b randomly in [-0.25,1.25]

for i=1:(iterations)
  
    parent1 = selectedChromosomes(randi(population/2),:);
    parent2 = selectedChromosomes(randi(population/2),:);

    k = 1;
    for j = 1 : 5 : 75
        parent1_A(k)  = parent1(j);
        parent1_c1(k) = parent1(j+1);
        parent1_c2(k) = parent1(j+2);
        parent1_s1(k) = parent1(j+3);
        parent1_s2(k) = parent1(j+4);

        parent2_A(k)  = parent2(j);
        parent2_c1(k) = parent2(j+1);
        parent2_c2(k) = parent2(j+2);
        parent2_s1(k) = parent2(j+3);
        parent2_s2(k) = parent2(j+4);
     

        offspring1_A(k)  = parent1_A(k)*b_A(i) + parent2_A(k)*(1-b_A(i));
        offspring1_c1(k) = parent1_c1(k)*b_c1(i) + parent2_c1(k)*(1-b_c1(i));
        offspring1_c2(k) = parent1_c2(k)*b_c2(i) + parent2_c2(k)*(1-b_c2(i));
        offspring1_s1(k) = parent1_s1(k)*b_s1(i) + parent2_s1(k)*(1-b_s1(i));
        offspring1_s2(k) = parent1_s2(k)*b_s2(i) + parent2_s2(k)*(1-b_s2(i));

        offspring2_A(k)  = parent2_A(k)*b_A(i) + parent1_A(k)*(1-b_A(i));
        offspring2_c1(k) = parent2_c1(k)*b_c1(i) + parent1_c1(k)*(1-b_c1(i));
        offspring2_c2(k) = parent2_c2(k)*b_c2(i) + parent1_c2(k)*(1-b_c2(i));
        offspring2_s1(k) = parent2_s1(k)*b_s1(i) + parent1_s1(k)*(1-b_s1(i));
        offspring2_s2(k) = parent2_s2(k)*b_s2(i) + parent1_s2(k)*(1-b_s2(i));

        k = k + 1;
    end

    m = 1;
    for n = 1: 5 :75
        offspring1(i,n)   = offspring1_A(m);
        offspring1(i,n+1) = offspring1_c1(m);
        offspring1(i,n+2) = offspring1_c2(m);
        offspring1(i,n+3) = offspring1_s1(m);
        offspring1(i,n+4) = offspring1_s2(m);

        offspring2(i,n)   = offspring2_A(m);
        offspring2(i,n+1) = offspring2_c1(m);
        offspring2(i,n+2) = offspring2_c2(m);
        offspring2(i,n+3) = offspring2_s1(m);
        offspring2(i,n+4) = offspring2_s2(m);

        m = m + 1;

    end

new_generation = [selectedChromosomes;offspring1;offspring2];

end
