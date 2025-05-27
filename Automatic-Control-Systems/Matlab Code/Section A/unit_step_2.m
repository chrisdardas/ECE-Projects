function dxdt = unit_step_2(t,x)

T = 0.5;
K = 10;
r = 2;
r_der = 0;
r_sec_der = 0;
u0 = 0.15;
e0 = 0.1;

dxdt = [x(2);-1/T*x(2)-K/T*u0*sat(x(1)/e0)+r_sec_der+1/T*r_der];
end