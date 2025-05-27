function dxedt = MRACtrig(t,x,a,Am,Bm,P)

x1 = x(1);
x2 = x(2);
x3 = x(3);
x4 = x(4);
xm1 = x(5);
xm2 = x(6);
xm3 = x(7);
xm4 = x(8);


kp = x(9:16);
kp = reshape(kp,[2,4]);
kpm = x(17:20);
kpm = reshape(kpm,[2,2]);



x = [x1;x2;x3;x4];
xm = [xm1;xm2;xm3;xm4;];
xe = xm - x;



g = 9.81;
l1 = 0.5;
a1 = a(1);
a2 = a(2);
a3 = a(3);
a4 = a(4); 
h11 = a1 + 2*a3*cos(x2);
h22 = a2;
h12 = a2 + a3*cos(x2);
h = a3*sin(x2);

a_gain1 = -[270 0;0 270]*[1 0 1 0;0 1 0 1];%-230*[1 -1 1 -1;5 8 0 10;];
b_gain1 = -[2500 0;0 2500]*[1 0 1 0;0 1 0 1]; %-790*[3 -5 1 -1;1 0 5 1;];

a_gain2 = [270 0;0 270]*[1 0 1 0;0 1 0 1];%437*[-4 -5 8 9;10 2 -7 5;];
b_gain2 = [2500 0;0 2500]*[1 0 1 0;0 1 0 1];%563*[-3 2 4 1;1 0 0 1;];


qd1 =pi/3 + (pi/3)*sin(0.4*pi*t);
qd2 = -pi/4 + (pi/6)*sin(0.3*pi*t);
r = [qd1;qd2];


H = [h11 h12;h12 h22];
C = [-h*x4 -h*(x3 + x4); h*x3 0];
grav = [a3*(g/l1)*cos(x1 + x2)+a4*cos(x1);a3*(g/l1)*cos(x1 + x2)];


ye = P*xe;


Kp = kp + b_gain1*ye*x';
Kpm = kpm + b_gain2*ye*r';
u = - Kp*x + Kpm*r;

qdotdot = inv(H)*(u-C*[x3;x4]-grav);

xmdot = (Am*xm + Bm*r);


e = xmdot -[x3;x4;qdotdot(1);qdotdot(2)];
ye_dot = P*e;

Kpdot = a_gain1*ye*x';%+b_gain1*ye_dot*[x1;x2;x3;x4]'+b_gain1*ye*[x3;x4;qdotdot(1);qdotdot(2)]';
Kpmdot = a_gain2*ye*r';%+ b_gain2*P*e*r';



dxedt = [x3;x4;qdotdot(1);qdotdot(2);xmdot(1);xmdot(2);xmdot(3);xmdot(4);];
dxedt(9:16) = reshape(Kpdot,[1,8]);
dxedt(17:20) = reshape(Kpmdot,[1,4]);


end