function dxdt = ramp_slope1(t,x)

T = 0.5;
K = 10;
r = 2;
r_der = 1;
r_sec_der = 0;

dxdt = [x(2);-1/T*x(2)-K/T*x(1)+r_sec_der+1/T*r_der];
end