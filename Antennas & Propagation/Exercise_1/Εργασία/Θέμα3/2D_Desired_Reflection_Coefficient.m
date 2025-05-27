clear;

Zs = 73.1 + j*42.5;
Z0 = 50;

h = 120*pi;
[d_over_lamda,h_over_lamda] = meshgrid(linspace(0.1,1,100),linspace(0.1,1,100));
X = d_over_lamda;
Y = h_over_lamda;
k = (2*pi);

d1 = d_over_lamda;
d2 = 2.*d_over_lamda;
d3 = 2.*h_over_lamda;
d4 = sqrt(4.*h_over_lamda.^2 + d_over_lamda.^2);
d5 = sqrt(4.*h_over_lamda.^2 + 4.*d_over_lamda.^2);



        u0_b = k.*d1;
        u1_b = k.*(sqrt(d1.^2 + 1/4) + 1/2);
        u2_b = k.*(sqrt(d1.^2 + 1/4) - 1/2);

        Rm1 = (h/(4*pi)).*(2.*cosint(u0_b) - cosint(u1_b) - cosint(u2_b));
        Xm1 = -(h/(4*pi)).*(2.*sinint(u0_b) - sinint(u1_b) - sinint(u2_b));
        b = Rm1 + j*Xm1;



        u0_c = k.*d2;
        u1_c = k.*(sqrt((d2).^2 + 1/4) + 1/2);
        u2_c = k.*(sqrt((d2).^2 + 1/4) - 1/2);

        Rm2 = (h/(4*pi)).*(2.*cosint(u0_c) - cosint(u1_c) - cosint(u2_c));
        Xm2 = -(h/(4*pi)).*(2.*sinint(u0_c) - sinint(u1_c) - sinint(u2_c));
        c = Rm2 + j*Xm2;



        u0_d = k.*d3;
        u1_d = k.*(sqrt((d3).^2 + 1/4) + 1/2);
        u2_d = k.*(sqrt((d3).^2 + 1/4) - 1/2);

        Rm3 = (h/(4*pi)).*(2.*cosint(u0_d) - cosint(u1_d) - cosint(u2_d));
        Xm3 = -(h/(4*pi)).*(2.*sinint(u0_d) - sinint(u1_d) - sinint(u2_d));
        d = Rm3 + j*Xm3;



        u0_e = k.*d4;
        u1_e = k.*(sqrt(d4.^2 + 1/4) + 1/2);
        u2_e = k.*(sqrt(d4.^2 + 1/4) - 1/2);

        Rm4 = (h/(4*pi)).*(2.*cosint(u0_e) - cosint(u1_e) - cosint(u2_e));
        Xm4 = -(h/(4*pi)).*(2.*sinint(u0_e) - sinint(u1_e) - sinint(u2_e));
        e = Rm4 + j*Xm4;



        u0_f = k.*d5;
        u1_f = k.*(sqrt(d5.^2 + 1/4) + 1/2);
        u2_f = k.*(sqrt(d5.^2 + 1/4) - 1/2);

        Rm5 = (h/(4*pi)).*(2.*cosint(u0_f) - cosint(u1_f) - cosint(u2_f));
        Xm5 = -(h/(4*pi)).*(2.*sinint(u0_f) - sinint(u1_e) - sinint(u2_f));
        f = Rm5 + j*Xm5;

         Zin = -(2*(b-e).^2)./(Zs + c -d -f) + Zs-d;
         S11 = abs((Zin-Z0)./(Zin + Z0));



surf(X,Y,S11);
zlabel('Reflection Coeffiecient S11')
xlabel('d/λ')
ylabel('h/λ')
figure
contourfm(X,Y,S11);
contourcbar
xlabel('d/λ')
ylabel('h/λ')
title('Reflection Coefficient S11')
figure
contour(X,Y,S11,[0.1 0.2 0.3],'ShowText','on')
xlabel('d/λ')
ylabel('h/λ')
title('Reflection Coefficient S11')

        
         







