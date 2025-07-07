% function dxdt = parallel_noise(t, x, u, A, B, G, h)
  
%     h_t = feval(h, t);
%     xV = [x(1) + h_t; x(2)];
%     xhat = [x(3); x(4)];
%     Ahat = [0 1; x(5) x(6)];
%     Bhat = [0; x(7)];
%     u_t = feval(u, t);
%     xdot = A*xV + B*u_t;
%     xhatdot = Ahat*xhat + Bhat*u_t;

%     e = xV - xhat;
    
%     Ahatdot = G(1) * e * xhat';
%     adot = [Ahatdot(2, 1); Ahatdot(2, 2)];
%     Bhatdot = G(2) * e * u_t;
%     bdot = Bhatdot(2);
%     dxdt = [xdot; xhatdot; adot; bdot];
% end

function dxdt = parallel_noise(t, x, u, A, B, G, h)
    
    h_t = feval(h, t);
    x1 = x(1) + h_t;
    x2 = x(2);
    xhat1 = x(3);
    xhat2 = x(4);
   
    a1 = x(5);
    a2 = x(6);
    b = x(7);
    Ahat = [0 1; a1 a2];
    Bhat = [0; b];
    u_t = feval(u, t);
    x1dot = A(1, 1) * x1 + A(1, 2) * x2 + B(1) * u_t;
    x2dot = A(2, 1) * x1 + A(2, 2) * x2 + B(2) * u_t;

    xhatdot1 = Ahat(1, 1) * xhat1 + Ahat(1, 2) * xhat2 + Bhat(1) * u_t ;
    xhatdot2 = Ahat(2, 1) * xhat1 + Ahat(2, 2) * xhat2 + Bhat(2) * u_t ;
    

    % e1 = x1 - xhat1;
    e2 = x2 - xhat2;
    
    a1dot = G(1) * e2 * x1;
    a2dot = G(1) * e2 * x2;
    bdot = G(2) * e2 * u_t;
    dxdt = [x1dot; x2dot; xhatdot1; xhatdot2; a1dot; a2dot; bdot];
end