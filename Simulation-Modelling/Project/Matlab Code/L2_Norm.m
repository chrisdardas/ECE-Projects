function l2_norm = L2_Norm(e, t)
    
    dt = t(2) - t(1);
    l2_norm = sqrt(sum(e.^2) * dt);

end