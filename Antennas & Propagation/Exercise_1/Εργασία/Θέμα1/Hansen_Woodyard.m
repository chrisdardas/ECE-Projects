clear;

kdx = pi/2;
kdz = pi;

Nx = 16;
Nz = 12;

deltax = -pi/2-(2.92/Nx);

[theta,phi] = meshgrid(linspace(0,pi,200),linspace(0,2*pi,200));

fx = kdx.*cos(phi).*sin(theta)+deltax;
fz = kdz.*cos(theta); 

Ax = abs(sin(8.*fx)./sin(fx./2));
Az = abs(sin(6.*fz)./sin(fz./2));

E = 60*cos(pi*0.5.*cos(theta))./sin(theta);
AF = Ax.*Az.*E;

X=sin(theta).*cos(phi).*AF;
Y=sin(theta).*sin(phi).*AF;
Z=cos(theta).*AF;
surf(X,Y,Z)

HPBW_HW = 2*acosd(1-0.1398*(4/Nx));
HPBWz = (2/Nz)*48.4;

D = 32400/(HPBW_HW*HPBWz);




theta_value = 0.0001:0.011:pi;
phi_value = 0.0001:0.011:2*pi;


Sum = 0;

for n = 1:length(phi_value)
    for m = 1:length(theta_value)
        
        phi = phi_value(n);
        theta = theta_value(m);
        
        fx1 = pi*0.5*cos(phi)*sin(theta)+deltax;
        fz1 = pi*cos(theta);

        AF1 = abs(sin(0.5*Nx*fx1)/sin(fx1*0.5))*abs(sin(0.5*Nz*fz1)/sin(fz1*0.5));
       
      
        
        Sum =Sum + (AF1^2)*(cos(pi/2*cos(theta)))^2/(sin(theta))*(0.017)^2;
        
        
    end
end

Numerator = (4*pi*Nx*Nx*Nz*Nz);

D1 = Numerator/Sum;


