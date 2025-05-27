%Here we implement the Golden section method exactly as mentioned in the
%book. Τhe arguments of the function are : the starting boundaries a and b,
%the desired accurancy lamda and the function on which we will implement
%the method. The function returns two vectors an and bn which contain the
%change of boundaries for different lamdas and the number function
%repetition as well as the lamda which will be useful for the following
%question of the problem





function [an,bn,k,lamda] = Golden_Section_Method(a,b,lamda,f)


gamma = 0.618;%(sqrt(5)-1)/2;
ak = [];
bk = [];
ak(1) = a;
bk(1) = b;
x1 = a + (1-gamma)*(b-a);
x2 = a + gamma*(b-a);

k = 1;


while((bk(k)-ak(k)) >= lamda)
   

    if (f(x1) > f(x2))

        ak(k+1) = x1;
        bk(k+1) = bk(k);
        x1 = x2;
        x2 = ak(k+1) + gamma*(bk(k+1)-ak(k+1));
        k = k + 1;
      

    elseif(f(x1) <= f(x2))
        bk(k+1) = x2;
        ak(k+1) = ak(k);
        x2 = x1;
        x1 = ak(k+1) + (1-gamma)*(bk(k+1)-ak(k+1));
        k = k + 1;
       

    end
end

an = ak;
bn = bk;

end


