clear;

phi = 0:0.01:2*pi;
figure
% d = l/2

% theta = 0
nexttile

fx = pi.*cos(phi);
AF = 12*abs(sin(8.*fx)./sin(fx./2));

polarplot(phi,AF)
title('Οριζόντιο διάγραμμα ακτινοβολίας')
legend('Θ = 0 & d = λ/2')

nexttile
% vertical for phi = pi/2;

theta = 0:0.01:pi;
fz = pi.*cos(theta);
AF_ver = 16*abs(sin(6.*fz)./sin(fz./2)).*(cos(pi*0.5*cos(theta))./sin(theta));
polarplot(theta,AF_ver)
title('Κατακόρυφο διάγραμμα ακτινοβολίας')
legend('Θ = 0 & d = λ/2')

figure

%theta = pi/6
nexttile
fx = (pi.*cos(phi) - pi/2);
AF = 12*abs(sin(8.*fx)./sin(fx./2));

polarplot(phi,AF)
title('Οριζόντιο διάγραμμα ακτινοβολίας')
legend('Θ = π/6 & d = λ/2')

nexttile
% vertical for phi = pi/3;
theta = 0:0.01:pi;
fz = pi.*cos(theta);
fx_ver = pi/2.*(sin(theta)-1);
AF_ver = abs(sin(8.*fx_ver)./sin(fx_ver./2)).*abs(sin(6.*fz)./sin(fz./2)).*(cos(pi*0.5*cos(theta))./sin(theta));
polarplot(theta,AF_ver)
title('Κατακόρυφο διάγραμμα ακτινοβολίας')
legend('Θ = π/6 & d = λ/2')

figure

%theta = pi/3
nexttile
fx = pi.*cos(phi) - pi*sqrt(3)*0.5;
AF = 12*abs(sin(8.*fx)./sin(fx./2));

polarplot(phi,AF)
title('Οριζόντιο διάγραμμα ακτινοβολίας')
legend('Θ = π/3 & d = λ/2')

nexttile
% vertical for phi = pi/6;
theta = 0:0.01:pi;
fz = pi.*cos(theta);
fx_ver = pi*sqrt(3)*0.5.*(sin(theta)-1);
AF_ver = abs(sin(8.*fx_ver)./sin(fx_ver./2)).*abs(sin(6.*fz)./sin(fz./2)).*(cos(pi*0.5*cos(theta))./sin(theta));
polarplot(theta,AF_ver)
title('Κατακόρυφο διάγραμμα ακτινοβολίας')
legend('Θ = π/3 & d = λ/2')

figure

%theta = pi/2
nexttile
fx = pi.*(cos(phi) - 1);
AF = 12*abs(sin(8.*fx)./sin(fx./2));

polarplot(phi,AF)
title('Οριζόντιο διάγραμμα ακτινοβολίας')
legend('Θ = π/2 & d = λ/2')

nexttile
% vertical for phi = 0;
theta = 0:0.01:pi;
fz = pi.*cos(theta);
fx_ver = pi.*(sin(theta)-1);
AF_ver = abs(sin(8.*fx_ver)./sin(fx_ver./2)).*abs(sin(6.*fz)./sin(fz./2)).*(cos(pi*0.5*cos(theta))./sin(theta));
polarplot(theta,AF_ver)
title('Κατακόρυφο διάγραμμα ακτινοβολίας')
legend('Θ = π/2 & d = λ/2')

figure

% d = 3l/4

% theta = 0

nexttile
fx = 1.5*pi.*cos(phi);
AF = 12*abs(sin(8.*fx)./sin(fx./2));

polarplot(phi,AF)
title('Οριζόντιο διάγραμμα ακτινοβολίας')
legend('Θ = 0 & d = 3λ/4')

%vertical for phi = pi/2
nexttile
theta = 0:0.01:pi;
fz = 1.5*pi.*cos(theta);
AF_ver = 16.*abs(sin(6.*fz)./sin(fz./2)).*(cos(pi*0.5*cos(theta))./sin(theta));
polarplot(theta,AF_ver)
title('Κατακόρυφο διάγραμμα ακτινοβολίας')
legend('Θ = 0 & d = 3λ/4')



figure

%theta = pi/6
nexttile
fx = 1.5*pi.*cos(phi) - pi*0.75;
AF = 12*abs(sin(8.*fx)./sin(fx./2));

polarplot(phi,AF)
title('Οριζόντιο διάγραμμα ακτινοβολίας')
legend('Θ = π/6 & d = 3λ/4')


%vertical for phi = pi/3
nexttile
theta = 0:0.01:pi;
fz = 1.5*pi.*cos(theta);
fx_ver = 1.5*pi*0.5.*(sin(theta) - 1);
AF_ver = abs(sin(8.*fx_ver)./sin(fx_ver./2)).*abs(sin(6.*fz)./sin(fz./2)).*(cos(pi*0.5*cos(theta))./sin(theta));
polarplot(theta,AF_ver)
title('Κατακόρυφο διάγραμμα ακτινοβολίας')
legend('Θ = π/6 & d = 3λ/4')


figure

%theta = pi/3
nexttile
fx = 1.5*pi*(cos(phi) - sqrt(3)*0.5);
AF = 12*abs(sin(8.*fx)./sin(fx./2));

polarplot(phi,AF)
title('Οριζόντιο διάγραμμα ακτινοβολίας')
legend('Θ = π/3 & d = 3λ/4')


%vertical for phi = pi/6
nexttile
theta = 0:0.01:pi;
fz = 1.5*pi*cos(theta);
fx_ver = 1.5*pi*0.5*sqrt(3).*(sin(theta) - 1);
AF_ver = abs(sin(8.*fx_ver)./sin(fx_ver./2)).*abs(sin(6.*fz)./sin(fz./2)).*(cos(pi*0.5*cos(theta))./sin(theta));
polarplot(theta,AF_ver)
title('Κατακόρυφο διάγραμμα ακτινοβολίας')
legend('Θ = π/3 & d = 3λ/4')


figure

%theta = pi/2
nexttile
fx = 1.5*pi.*(cos(phi) - 1);
AF = 12*abs(sin(8.*fx)./sin(fx./2));

polarplot(phi,AF)
title('Οριζόντιο διάγραμμα ακτινοβολίας')
legend('Θ = π/2 & d = 3λ/4')


%vertical for phi = pi/2

nexttile
theta = 0:0.01:pi;
fz = 1.5*pi*cos(theta);
fx_ver = 1.5*pi.*(sin(theta) - 1);
AF_ver = abs(sin(8.*fx_ver)./sin(fx_ver./2)).*abs(sin(6.*fz)./sin(fz./2)).*(cos(pi*0.5*cos(theta))./sin(theta));
polarplot(theta,AF_ver)
title('Κατακόρυφο διάγραμμα ακτινοβολίας')
legend('Θ = π/2 & d = 3λ/4')


