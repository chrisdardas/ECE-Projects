clear;

h = 120*pi;
d_over_lamda = 0:0.01:3;
k = (2*pi);
u0 = k.*d_over_lamda;
u1 = k.*(sqrt(d_over_lamda.^2 + 1/4) + 1/2);
u2 = k.*(sqrt(d_over_lamda.^2 + 1/4) - 1/2);

Rm = (h/(4*pi)).*(2.*cosint(u0) - cosint(u1) - cosint(u2));
Xm = -(h/(4*pi)).*(2.*sinint(u0) - sinint(u1) - sinint(u2));

plot(d_over_lamda,Rm,'b');
hold on
plot(d_over_lamda,Xm,'r');
ylabel('Mutual Impendance Z21m(ohms)')
xlabel('d/λ')
legend('Rm','Xm')
