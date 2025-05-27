% Broadside for x and z array
clear;
Nx = 16;
Nz = 12;

Dx = Nx;
Dz = Nz;
HPBWx = (2*48.4)/Nx;
HPBWz = (2*48.4)/Nz;

D0 = pi*cos(0)*Dx*Dz;

D0_alt = 32400/(HPBWx*HPBWz);

% Broadside for z array and 30 degree diversion from broadside for x array

deltax1 = -pi/2;

Dx_1 = 14;%(Nx*kd)/(val11 - val21 + val31);

D1 = pi*cos(pi/6)*Dz*Dx_1;
HPBWx1 = 8;
D1_alt = (32400*cos(pi/6))/(HPBWx1*HPBWz);



% Broadside for z array and 60 degree diversion from broadside for x array

deltax2 = -(pi*sqrt(3))/2;

Dx_2 = (16*7/17);%(Nx*kd)/(val12 - val22 + val32);

D2 = pi*cos(pi/3)*Dz*Dx_2;
HPBWx2 = 17;
D2_alt = (32400*cos(pi/3))/(HPBWx2*HPBWz);

% Broadside for z array and endfire for x array

Dx_3 = 4*(Nx/2);
HPBWx_end = 105.4*sqrt(2/Nx);
D3 = 32400/(HPBWx_end*HPBWz); % No other way to calculate directivity

