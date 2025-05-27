function [proj] = Projection(s,a,b)

proj = zeros(1,2);

if ((a*(1 - (2/3)*s)) <= -10)
    proj(1) = -10;

elseif ((a*(1 - (2/3)*s)) >= 5)
    proj(1) = 5;
    
else
    proj(1) = a*(1 - (2/3)*s);

end


if (b*(1 - 6*s) <=- 8)
    proj(2) = -8;

elseif (b*(1 - 6*s) >= 12)
    proj(2) = 12;
    
else
    proj(2) = b*(1 - 6*s) ;

end



end

