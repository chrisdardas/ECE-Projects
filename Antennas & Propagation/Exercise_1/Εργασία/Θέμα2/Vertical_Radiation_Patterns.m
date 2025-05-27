clear;

% h = l/4

kh = pi/2;
phi = pi/2;
theta = 0:0.01:pi;
%===================================================================================================================================================================================
% theta0 = 0 degrees
theta0 = 0;

r1 = sin(theta).*cos(theta-theta0).*cos(theta0)-sin(theta).*sin(theta-theta0).*sin(theta0)-cos(theta).*cos(theta-theta0).*sin(theta0)-sin(theta-theta0).*cos(theta0).*cos(theta);
u1 = cos(theta).*cos(theta-theta0).*cos(theta0)-cos(theta).*sin(theta-theta0).*sin(theta0)+sin(theta).*cos(theta-theta0).*sin(theta0)+sin(theta).*sin(theta-theta0).*cos(theta0);

r2 = cos(theta+theta0).*cos(theta0).*sin(theta)+sin(theta).*sin(theta+theta0).*sin(theta0)+cos(theta).*cos(theta+theta0).*sin(theta0)-cos(theta).*sin(theta+theta0).*cos(theta0);
u2 = cos(theta+theta0).*cos(theta0).*cos(theta)+sin(theta+theta0).*sin(theta0).*cos(theta)-sin(theta).*cos(theta+theta0).*sin(theta0)+sin(theta).*sin(theta+theta0).*cos(theta0);

I = 1;
E0 = 60*I;
Er1 = E0.*exp(j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta-theta0))./sin(theta-theta0)).*r1;
Eu1 = E0.*exp(j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta-theta0))./sin(theta-theta0)).*u1;


Er2 = -E0.*exp(-j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta+theta0))./sin(theta+theta0)).*r2;
Eu2 = -E0.*exp(-j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta+theta0))./sin(theta+theta0)).*u2;

Er = Er1 + Er2;
Eu = Eu1 + Eu2;

ax = polaraxes;
polarplot(ax,theta,abs(Eu))
ax.ThetaZeroLocation = 'top';
ax.ThetaDir = 'clockwise';
title('Κατακόρυφο Διάγραμμα Ακτινοβολίας')
legend('θο=0 & h=λ/4')
figure

%===================================================================================================================================================================================
%theta0 = 30 degrees
theta0=pi/6;

r1 = sin(theta).*cos(theta-theta0).*cos(theta0)-sin(theta).*sin(theta-theta0).*sin(theta0)-cos(theta).*cos(theta-theta0).*sin(theta0)-sin(theta-theta0).*cos(theta0).*cos(theta);
u1 = cos(theta).*cos(theta-theta0).*cos(theta0)-cos(theta).*sin(theta-theta0).*sin(theta0)+sin(theta).*cos(theta-theta0).*sin(theta0)+sin(theta).*sin(theta-theta0).*cos(theta0);

r2 = cos(theta+theta0).*cos(theta0).*sin(theta)+sin(theta).*sin(theta+theta0).*sin(theta0)+cos(theta).*cos(theta+theta0).*sin(theta0)-cos(theta).*sin(theta+theta0).*cos(theta0);
u2 = cos(theta+theta0).*cos(theta0).*cos(theta)+sin(theta+theta0).*sin(theta0).*cos(theta)-sin(theta).*cos(theta+theta0).*sin(theta0)+sin(theta).*sin(theta+theta0).*cos(theta0);


I = 1;
E0 = 60*I;
Er1 = E0.*exp(j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta-theta0))./sin(theta-theta0)).*r1;
Eu1 = E0.*exp(j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta-theta0))./sin(theta-theta0)).*u1;

Er2 = -E0.*exp(-j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta+theta0))./sin(theta+theta0)).*r2;
Eu2 = -E0.*exp(-j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta+theta0))./sin(theta+theta0)).*u2;

Er = Er1 + Er2;
Eu = Eu1 + Eu2;

ax = polaraxes;
polarplot(ax,theta,abs(Eu))
ax.ThetaZeroLocation = 'top';
ax.ThetaDir = 'clockwise';
title('Κατακόρυφο Διάγραμμα Ακτινοβολίας')
legend('θο=30 & h=λ/4')
figure

%===================================================================================================================================================================================
%theta0 = 60 degrees

theta0 = pi/3;

r1 = sin(theta).*cos(theta-theta0).*cos(theta0)-sin(theta).*sin(theta-theta0).*sin(theta0)-cos(theta).*cos(theta-theta0).*sin(theta0)-sin(theta-theta0).*cos(theta0).*cos(theta);
u1 = cos(theta).*cos(theta-theta0).*cos(theta0)-cos(theta).*sin(theta-theta0).*sin(theta0)+sin(theta).*cos(theta-theta0).*sin(theta0)+sin(theta).*sin(theta-theta0).*cos(theta0);

r2 = cos(theta+theta0).*cos(theta0).*sin(theta)+sin(theta).*sin(theta+theta0).*sin(theta0)+cos(theta).*cos(theta+theta0).*sin(theta0)-cos(theta).*sin(theta+theta0).*cos(theta0);
u2 = cos(theta+theta0).*cos(theta0).*cos(theta)+sin(theta+theta0).*sin(theta0).*cos(theta)-sin(theta).*cos(theta+theta0).*sin(theta0)+sin(theta).*sin(theta+theta0).*cos(theta0);


I = 1;
E0 = 60*I;
Er1 = E0.*exp(j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta-theta0))./sin(theta-theta0)).*r1;
Eu1 = E0.*exp(j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta-theta0))./sin(theta-theta0)).*u1;

Er2 = -E0.*exp(-j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta+theta0))./sin(theta+theta0)).*r2;
Eu2 = -E0.*exp(-j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta+theta0))./sin(theta+theta0)).*u2;

Er = Er1 + Er2;
Eu = Eu1 + Eu2;

ax = polaraxes;
polarplot(ax,theta,abs(Eu))
ax.ThetaZeroLocation = 'top';
ax.ThetaDir = 'clockwise';
title('Κατακόρυφο Διάγραμμα Ακτινοβολίας')
legend('θο=60 & h=λ/4')
figure



%===================================================================================================================================================================================
%theta0 = 90 degrees

theta0 = pi/2;

r1 = sin(theta).*cos(theta-theta0).*cos(theta0)-sin(theta).*sin(theta-theta0).*sin(theta0)-cos(theta).*cos(theta-theta0).*sin(theta0)-sin(theta-theta0).*cos(theta0).*cos(theta);
u1 = cos(theta).*cos(theta-theta0).*cos(theta0)-cos(theta).*sin(theta-theta0).*sin(theta0)+sin(theta).*cos(theta-theta0).*sin(theta0)+sin(theta).*sin(theta-theta0).*cos(theta0);

r2 = cos(theta+theta0).*cos(theta0).*sin(theta)+sin(theta).*sin(theta+theta0).*sin(theta0)+cos(theta).*cos(theta+theta0).*sin(theta0)-cos(theta).*sin(theta+theta0).*cos(theta0);
u2 = cos(theta+theta0).*cos(theta0).*cos(theta)+sin(theta+theta0).*sin(theta0).*cos(theta)-sin(theta).*cos(theta+theta0).*sin(theta0)+sin(theta).*sin(theta+theta0).*cos(theta0);


I = 1;
E0 = 60*I;
Er1 = E0.*exp(j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta-theta0))./sin(theta-theta0)).*r1;
Eu1 = E0.*exp(j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta-theta0))./sin(theta-theta0)).*u1;

Er2 = -E0.*exp(-j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta+theta0))./sin(theta+theta0)).*r2;
Eu2 = -E0.*exp(-j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta+theta0))./sin(theta+theta0)).*u2;

Er = Er1 + Er2;
Eu = Eu1 + Eu2;

ax = polaraxes;
polarplot(ax,theta,abs(Eu))
ax.ThetaZeroLocation = 'top';
ax.ThetaDir = 'clockwise';
title('Κατακόρυφο Διάγραμμα Ακτινοβολίας')
legend('θο=90 & h=λ/4')
figure

%===================================================================================================================================================================================
%===================================================================================================================================================================================
%===================================================================================================================================================================================


% h = l/2

kh = pi;
phi = pi/2;

%===================================================================================================================================================================================
% theta0 = 0 degrees
theta0 = 0;

r1 = sin(theta).*cos(theta-theta0).*cos(theta0)-sin(theta).*sin(theta-theta0).*sin(theta0)-cos(theta).*cos(theta-theta0).*sin(theta0)-sin(theta-theta0).*cos(theta0).*cos(theta);
u1 = cos(theta).*cos(theta-theta0).*cos(theta0)-cos(theta).*sin(theta-theta0).*sin(theta0)+sin(theta).*cos(theta-theta0).*sin(theta0)+sin(theta).*sin(theta-theta0).*cos(theta0);

r2 = cos(theta+theta0).*cos(theta0).*sin(theta)+sin(theta).*sin(theta+theta0).*sin(theta0)+cos(theta).*cos(theta+theta0).*sin(theta0)-cos(theta).*sin(theta+theta0).*cos(theta0);
u2 = cos(theta+theta0).*cos(theta0).*cos(theta)+sin(theta+theta0).*sin(theta0).*cos(theta)-sin(theta).*cos(theta+theta0).*sin(theta0)+sin(theta).*sin(theta+theta0).*cos(theta0);


I = 1;
E0 = 60*I;
Er1 = E0.*exp(j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta-theta0))./sin(theta-theta0)).*r1;
Eu1 = E0.*exp(j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta-theta0))./sin(theta-theta0)).*u1;

Er2 = -E0.*exp(-j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta+theta0))./sin(theta+theta0)).*r2;
Eu2 = -E0.*exp(-j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta+theta0))./sin(theta+theta0)).*u2;

Er = Er1 + Er2;
Eu = Eu1 + Eu2;

ax = polaraxes;
polarplot(ax,theta,abs(Eu))
ax.ThetaZeroLocation = 'top';
ax.ThetaDir = 'clockwise';
title('Κατακόρυφο Διάγραμμα Ακτινοβολίας')
legend('θο=0 & h=λ/2')
figure

%===================================================================================================================================================================================
%theta0 = 30 degrees

theta0 = pi/6;

r1 = sin(theta).*cos(theta-theta0).*cos(theta0)-sin(theta).*sin(theta-theta0).*sin(theta0)-cos(theta).*cos(theta-theta0).*sin(theta0)-sin(theta-theta0).*cos(theta0).*cos(theta);
u1 = cos(theta).*cos(theta-theta0).*cos(theta0)-cos(theta).*sin(theta-theta0).*sin(theta0)+sin(theta).*cos(theta-theta0).*sin(theta0)+sin(theta).*sin(theta-theta0).*cos(theta0);

r2 = cos(theta+theta0)*cos(theta0).*sin(theta)+sin(theta).*sin(theta+theta0).*sin(theta0)+cos(theta).*cos(theta+theta0).*sin(theta0)-cos(theta).*sin(theta+theta0).*cos(theta0);
u2 = cos(theta+theta0).*cos(theta0).*cos(theta)+sin(theta+theta0).*sin(theta0).*cos(theta)-sin(theta).*cos(theta+theta0).*sin(theta0)+sin(theta).*sin(theta+theta0).*cos(theta0);


I = 1;
E0 = 60*I;
Er1 = E0.*exp(j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta-theta0))./sin(theta-theta0)).*r1;
Eu1 = E0.*exp(j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta-theta0))./sin(theta-theta0)).*u1;

Er2 = -E0.*exp(-j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta+theta0))./sin(theta+theta0)).*r2;
Eu2 = -E0.*exp(-j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta+theta0))./sin(theta+theta0)).*u2;

Er = Er1 + Er2;
Eu = Eu1 + Eu2;

ax = polaraxes;
polarplot(ax,theta,abs(Eu))
ax.ThetaZeroLocation = 'top';
ax.ThetaDir = 'clockwise';
title('Κατακόρυφο Διάγραμμα Ακτινοβολίας')
legend('θο=30 & h=λ/2')
figure

%===================================================================================================================================================================================
%theta0 = 60 degrees

theta0 = pi/3;

r1 = sin(theta).*cos(theta-theta0).*cos(theta0)-sin(theta).*sin(theta-theta0).*sin(theta0)-cos(theta).*cos(theta-theta0).*sin(theta0)-sin(theta-theta0).*cos(theta0).*cos(theta);
u1 = cos(theta).*cos(theta-theta0).*cos(theta0)-cos(theta).*sin(theta-theta0).*sin(theta0)+sin(theta).*cos(theta-theta0).*sin(theta0)+sin(theta).*sin(theta-theta0).*cos(theta0);

r2 = cos(theta+theta0).*cos(theta0).*sin(theta)+sin(theta).*sin(theta+theta0).*sin(theta0)+cos(theta).*cos(theta+theta0).*sin(theta0)-cos(theta).*sin(theta+theta0).*cos(theta0);
u2 = cos(theta+theta0).*cos(theta0).*cos(theta)+sin(theta+theta0).*sin(theta0).*cos(theta)-sin(theta).*cos(theta+theta0).*sin(theta0)+sin(theta).*sin(theta+theta0).*cos(theta0);


I = 1;
E0 = 60.*I;
Er1 = E0.*exp(j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta-theta0))./sin(theta-theta0)).*r1;
Eu1 = E0.*exp(j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta-theta0))./sin(theta-theta0)).*u1;

Er2 = -E0.*exp(-j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta+theta0))./sin(theta+theta0)).*r2;
Eu2 = -E0.*exp(-j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta+theta0))./sin(theta+theta0)).*u2;

Er = Er1 + Er2;
Eu = Eu1 + Eu2;

ax = polaraxes;
polarplot(ax,theta,abs(Eu))
ax.ThetaZeroLocation = 'top';
ax.ThetaDir = 'clockwise';
title('Κατακόρυφο Διάγραμμα Ακτινοβολίας')
legend('θο=60 & h=λ/2')
figure


%===================================================================================================================================================================================
%theta0 = 90 degrees

theta0 = pi/2;

r1 = sin(theta).*cos(theta-theta0).*cos(theta0)-sin(theta).*sin(theta-theta0).*sin(theta0)-cos(theta).*cos(theta-theta0).*sin(theta0)-sin(theta-theta0).*cos(theta0).*cos(theta);
u1 = cos(theta).*cos(theta-theta0).*cos(theta0)-cos(theta).*sin(theta-theta0).*sin(theta0)+sin(theta).*cos(theta-theta0).*sin(theta0)+sin(theta).*sin(theta-theta0).*cos(theta0);

r2 = cos(theta+theta0).*cos(theta0).*sin(theta)+sin(theta).*sin(theta+theta0).*sin(theta0)+cos(theta).*cos(theta+theta0).*sin(theta0)-cos(theta).*sin(theta+theta0).*cos(theta0);
u2 = cos(theta+theta0).*cos(theta0).*cos(theta)+sin(theta+theta0).*sin(theta0).*cos(theta)-sin(theta).*cos(theta+theta0).*sin(theta0)+sin(theta).*sin(theta+theta0).*cos(theta0);


I = 1;
E0 = 60*I;
Er1 = E0*exp(j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta-theta0))./sin(theta-theta0)).*r1;
Eu1 = E0*exp(j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta-theta0))./sin(theta-theta0)).*u1;

Er2 = -E0*exp(-j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta+theta0))./sin(theta+theta0)).*r2;
Eu2 = -E0*exp(-j.*kh.*sin(theta)).*(cos(pi.*0.5.*cos(theta+theta0))./sin(theta+theta0)).*u2;

Er = Er1 + Er2;
Eu = Eu1 + Eu2;

ax = polaraxes;
polarplot(ax,theta,abs(Eu))
ax.ThetaZeroLocation = 'top';
ax.ThetaDir = 'clockwise';
title('Κατακόρυφο Διάγραμμα Ακτινοβολίας')
legend('θο=90 & h=λ/2')




