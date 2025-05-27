function [optimal_value] = Golden_Section_Modified(f,lamda,a,b)


gamma = (sqrt(5)-1)/2;
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

optimal_value = (x1+x2)/2;

end
