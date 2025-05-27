function [SelectedPop,index] = selection(population,chromosomes)
    

    n = size(chromosomes,2);
    Fitness=bestfitness(population,chromosomes);
    [~,index1] = maxk(Fitness,50);
    TotalFitness=sum(Fitness);
    ProbSelection=zeros(population,1);
    CumulativeProb=zeros(population,1);

    for i=1:population
        ProbSelection(i)=Fitness(i)/TotalFitness;
        if i==1
            CumulativeProb(i)=ProbSelection(i);
        else
            CumulativeProb(i)=CumulativeProb(i-1)+ProbSelection(i);
        end
    end

    SelectInd=rand(population,1);
    SelectedPop = zeros(population/2,n);

    for i=1:population/2
        flag=0;
        for j=1:population
            if(CumulativeProb(j)<SelectInd(i) && CumulativeProb(j+1)>=SelectInd(i))
                SelectedPop(i,1:n)= chromosomes(j+1,1:n);
                flag=1;
                break;
            end
        end
        if(flag==0)
            for k=1:length(index1)
                if(isempty(SelectedPop))
                    SelectedPop(i,:) = chromosomes(index2(k),:);
                    break;
                elseif(SelectedPop(1:i-1,:) ~= chromosomes(index1(k),:))
                        SelectedPop(i,1:n)= chromosomes(index1(k),1:n);
                        break;
                end
            end
        end
    end

    Fitness=bestfitness(population/2,SelectedPop);
    [~,index] = maxk(Fitness,50);


  

end