function dthetadt = myfun2(t,x,K,L,G)


qd1 = (pi/3) + (pi/3)*sin(0.4*pi*t);
qd2 = (-pi/4) + (pi/6)*sin(0.3*pi*t);

g = 9.81;
m1  = 10;
m2 = 8;
l1 = 0.5;
l2 = 0.4;
g = 9.81;
lc1 = 0.25;
lc2 = 0.1;
I1 = 0.23;
I2 = 0.2;

a1 = m1*lc1^2 + m2*lc2^2 + m2*l1^2 + I1 + I2;
a2 = m2*lc2^2 + I2;
a3 = m2*l1*lc2;
a4 = g*(m2*l1 + m1*lc1);


x1 = x(1);
x2 = x(2);
x3 = x(3);
x4 = x(4);

approx_theta1 = x(5);
approx_theta2 = x(6);
approx_theta3 = x(7);
approx_theta4 = x(8);
theta_hat = [approx_theta1;approx_theta2;approx_theta3;approx_theta4];


h11 = a1 + 2*a3*cos(x2);
h22 = a2;
h12 = a2 + a3*cos(x2);
H = [h11 h12;h12 h22];

h = a3*sin(x2);

C = [-h*x4 -h*(x3 + x4); h*x3 0];
grav = [a3*(g/l1)*cos(x1 + x2)+a4*cos(x1);a3*(g/l1)*cos(x1 + x2)];

qe1 = x1 - qd1;
qe2 = x2 - qd2;

qe = [qe1;qe2];

qr = [(4*pi^2/30)*cos(0.4*pi*t);(pi^2/20)*cos(0.3*pi*t)] - L * qe;
qr_der = [(-16*pi^3/300)*sin(0.4*pi*t);(-3*pi^3/200)*sin(0.3*pi*t)] - L*[x3-(4*pi^2/30)*cos(0.4*pi*t);x4-(pi^2/20)*cos(0.3*pi*t)];

[Y,s] = Ycalc([x1 x2],[x3 x4],qr',qr_der');
u = Y*theta_hat - K*s;
qdotdot = inv(H)*(u-C*[x3;x4]-grav);

delta_theta_dot =  -inv(G)*Y'*s;



dthetadt = [x3;x4;qdotdot(1);qdotdot(2);delta_theta_dot(1);delta_theta_dot(2);delta_theta_dot(3);delta_theta_dot(4)];



end