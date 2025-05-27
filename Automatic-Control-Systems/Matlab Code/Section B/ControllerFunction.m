function u = ControllerFunction(x1,x2,x3,x4,qr,qr_der,a1,a2,a3,a4,K)

theta_hat = [a1;a2;a3;a4];
[Y,s] = Ycalc([x1 x2],[x3 x4],qr',qr_der');
u = Y*theta_hat - K*s;


end