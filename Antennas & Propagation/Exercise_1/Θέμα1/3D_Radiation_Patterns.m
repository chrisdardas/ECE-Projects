clear;

figure
% Radiation Pattern for dx = 0 and theta = 0
kd_1 = pi;
[theta,phi] = meshgrid(linspace(0,pi,500),linspace(0,2*pi,500));
E = cos(pi.*0.5.*cos(theta))./sin(theta);
%E = 60.*cos(pi/2.*cos(theta))./sin(theta);

fx1 = kd_1.*cos(phi).*sin(theta);
Ax1 = abs(sin(8.*fx1)./sin(fx1./2));

fz1 = kd_1.*cos(theta);
Az1 = abs(sin(6.*fz1)./sin(fz1./2));

AF1 = Ax1.*Az1.*E;

X=sin(theta).*cos(phi).*AF1;%.*E;
Y=sin(theta).*sin(phi).*AF1;%.*E;
Z=cos(theta).*AF1;%.*E;
surf(X,Y,Z)
figure

% Radiation Pattern for dx = -pi/2 and theta = pi/6
[theta,phi] = meshgrid(linspace(0,pi,500),linspace(0,2*pi,500));

fx2 = kd_1.*cos(phi).*sin(theta) - pi/2;
Ax2 = abs(sin(8.*fx2)./sin(fx2./2));

fz2 = kd_1.*cos(theta);
Az2 = abs(sin(6.*fz2)./sin(fz2./2));

AF2 = Ax2.*Az2.*E;

X=sin(theta).*cos(phi).*AF2;
Y=sin(theta).*sin(phi).*AF2;
Z=cos(theta).*AF2;
surf(X,Y,Z)
figure

% Radiation Pattern for dx = -pi*sqrt(3)/2 and theta = pi/3
[theta,phi] = meshgrid(linspace(0,pi,500),linspace(0,2*pi,500));

fx3 = kd_1.*cos(phi).*sin(theta) - pi*sqrt(3)*0.5;
Ax3 = abs(sin(8.*fx3)./sin(fx3./2));

fz3 = kd_1.*cos(theta);
Az3 = abs(sin(6.*fz3)./sin(fz3./2));

AF3 = Ax3.*Az3.*E;

X=sin(theta).*cos(phi).*AF3;
Y=sin(theta).*sin(phi).*AF3;
Z=cos(theta).*AF3;
surf(X,Y,Z)
figure


% Radiation Pattern for dx = -pi and theta = pi/2
[theta,phi] = meshgrid(linspace(0,pi,500),linspace(0,2*pi,500));

fx4 = kd_1.*cos(phi).*sin(theta)-pi;
Ax4 = abs(sin(8.*fx4)./sin(fx4./2));

fz4 = kd_1.*cos(theta);
Az4 = abs(sin(6.*fz4)./sin(fz4./2));

AF4 = Ax4.*Az4.*E;

X=sin(theta).*cos(phi).*AF4;
Y=sin(theta).*sin(phi).*AF4;
Z=cos(theta).*AF4;
surf(X,Y,Z)
figure


% Radiation Pattern for dx = 0 and theta = 0
kd_2 = 1.5*pi;
[theta,phi] = meshgrid(linspace(0,pi,500),linspace(0,2*pi,500));

fx5 = kd_2*cos(phi).*sin(theta);
Ax5 = abs(sin(8.*fx5)./sin(fx5./2));

fz5 = kd_2*cos(theta);
Az5 = abs(sin(6.*fz5)./sin(fz5./2));

AF5 = Ax5.*Az5.*E;

X=sin(theta).*cos(phi).*AF5;
Y=sin(theta).*sin(phi).*AF5;
Z=cos(theta).*AF5;
surf(X,Y,Z)
figure

% Radiation Pattern for dx = -pi/2 and theta = pi/6
[theta,phi] = meshgrid(linspace(0,pi,500),linspace(0,2*pi,500));

fx6 = kd_2*cos(phi).*sin(theta) - 3*pi*0.25;
Ax6 = abs(sin(8.*fx6)./sin(fx6./2));

fz6 = kd_2*cos(theta);
Az6 = abs(sin(6.*fz6)./sin(fz6./2));

AF6 = Ax6.*Az6.*E;

X=sin(theta).*cos(phi).*AF6;
Y=sin(theta).*sin(phi).*AF6;
Z=cos(theta).*AF6;
surf(X,Y,Z)
figure

% Radiation Pattern for dx = -pi*sqrt(3)/2 and theta = pi/3
[theta,phi] = meshgrid(linspace(0,pi,500),linspace(0,2*pi,500));

fx7 = kd_2*cos(phi).*sin(theta) - 3*pi*sqrt(3)*0.25;
Ax7 = abs(sin(8.*fx7)./sin(fx7./2));

fz7 = kd_2*cos(theta);
Az7 = abs(sin(6.*fz7)./sin(fz7./2));

AF7 = Ax7.*Az7.*E;

X=sin(theta).*cos(phi).*AF7;
Y=sin(theta).*sin(phi).*AF7;
Z=cos(theta).*AF7;
surf(X,Y,Z)
figure


% Radiation Pattern for dx = -pi and theta = pi/2
[theta,phi] = meshgrid(linspace(0,pi,500),linspace(0,2*pi,500));

fx8 = kd_2.*cos(phi).*sin(theta)-3*pi*0.5;
Ax8 = abs(sin(8.*fx8)./sin(fx8./2));

fz8 = kd_2.*cos(theta);
Az8 = abs(sin(6.*fz8)./sin(fz8./2));

AF8 = Ax8.*Az8.*E;

X=sin(theta).*cos(phi).*AF8;
Y=sin(theta).*sin(phi).*AF8;
Z=cos(theta).*AF8;
surf(X,Y,Z)

