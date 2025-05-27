clear;

Zs = 73.1 + j*42.5;

h = 120*pi;
d_over_lamda1 = 0.25;
k = (2*pi);
u0 = k.*d_over_lamda1;
u1 = k.*(sqrt(d_over_lamda1.^2 + 1/4) + 1/2);
u2 = k.*(sqrt(d_over_lamda1.^2 + 1/4) - 1/2);

Rm1 = (h/(4*pi)).*(2.*cosint(u0) - cosint(u1) - cosint(u2));
Xm1 = -(h/(4*pi)).*(2.*sinint(u0) - sinint(u1) - sinint(u2));
Zm1 = Rm1 + j*Xm1;


d_over_lamda2 = 0.5;
u0 = k.*d_over_lamda2;
u1 = k.*(sqrt(d_over_lamda2.^2 + 1/4) + 1/2);
u2 = k.*(sqrt(d_over_lamda2.^2 + 1/4) - 1/2);

Rm2 = (h/(4*pi)).*(2.*cosint(u0) - cosint(u1) - cosint(u2));
Xm2 = -(h/(4*pi)).*(2.*sinint(u0) - sinint(u1) - sinint(u2));
Zm2 = Rm2 + j*Xm2;

Zin = Zs -(2*Zm1^2)/(Zs+Zm2);

I1 = -(Zm1/(Zs+Zm2));
I2 = 1;

phi = 0:0.01:2*pi;
AF = abs(I2  -2*(Zm1/(Zs+Zm2)).*cos(k*d_over_lamda1.*cos(phi)));

polarplot(phi,AF);
title('Οριζόντιο Διάγραμμα Ακτινοβολίας')