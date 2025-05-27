function [y] = Discretize(X,numbins)
    y = histcounts(X,numbins,Normalization="probability");
end