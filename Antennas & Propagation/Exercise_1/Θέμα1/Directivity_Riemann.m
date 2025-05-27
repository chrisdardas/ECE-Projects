clear;
Sum1 = 0;

N=192;
phi_value = 0.001:1:360;
theta_value = 0.001:1:180;
Sum_1 = zeros(length(phi_value),length(theta_value));




for n = 1:length(phi_value)
    for m = 1:length(theta_value)
        
        phi = phi_value(n);
        theta = theta_value(m);
        
        fx1 = pi*cosd(phi)*sind(theta);
        fz1 = pi*cosd(theta);

        AF1 = abs(sin(8*fx1)/sin(fx1/2))*abs(sin(6*fz1)/sin(fz1/2));
       
      
        
        Sum_1(n,m) =(AF1^2)*(cos(pi/2*cosd(theta)))^2/(sind(theta))*(pi/180)*(pi/180);
        
        
    end
end

for i = 1:length(phi_value)
    for j = 1:length(theta_value)
        Sum1 = (Sum1 + Sum_1(i,j));
    end
end


D1 = (4*pi*N^2)/Sum1;


Sum_2 = zeros(length(phi_value),length(theta_value));


for n = 1:length(phi_value)
    for m = 1:length(theta_value)
        
        phi = phi_value(n);
        theta = theta_value(m);
       
        fx2 = pi*cosd(phi)*sind(theta)-pi/2;
        fz2 = pi*cosd(theta);
        
        AF2 = abs(sin(8*fx2)/sin(fx2/2))*abs(sin(6*fz2)/sin(fz2/2));
        
        Sum_2(n,m) = (AF2^2)*(cos(0.5*pi*cosd(theta)))^2/(sind(theta))*(pi/180)*(pi/180);
        
        
    end
end

Sum2 = 0;

for i = 1:length(phi_value)
    for j = 1:length(theta_value)
        Sum2 = (Sum2 + Sum_2(i,j));
    end
end


D2 = (4*pi*N^2)/Sum2;

Sum_3 = zeros(length(phi_value),length(theta_value));


for n = 1:length(phi_value)
    for m = 1:length(theta_value)
        
        phi = phi_value(n);
        theta = theta_value(m);
       
        fx3 = pi*cosd(phi)*sind(theta)-pi*0.5*sqrt(3);
        fz3 = pi*cosd(theta);
        
        AF3 = abs(sin(8*fx3)/sin(fx3/2))*abs(sin(6*fz3)/sin(fz3/2));
        
        Sum_3(n,m) = (AF3^2)*(cos(0.5*pi*cosd(theta)))^2/(sind(theta))*(pi/180)*(pi/180);
        
        
    end
end

Sum3 = 0;

for i = 1:length(phi_value)
    for j = 1:length(theta_value)
        Sum3 = (Sum3 + Sum_3(i,j));
    end
end


D3 = (4*pi*N^2)/Sum3;


Sum_4 = zeros(length(phi_value),length(theta_value));


for n = 1:length(phi_value)
    for m = 1:length(theta_value)
        
        phi = phi_value(n);
        theta = theta_value(m);
       
        fx4 = pi*cosd(phi)*sind(theta)-pi;
        fz4 = pi*cosd(theta);
        
        AF4 = abs(sin(8*fx4)/sin(fx4/2))*abs(sin(6*fz4)/sin(fz4/2));
        
        Sum_4(n,m) = (AF4^2)*(cos(0.5*pi*cosd(theta)))^2/(sind(theta))*(pi/180)*(pi/180);
        
        
    end
end

Sum4 = 0;

for i = 1:length(phi_value)
    for j = 1:length(theta_value)
        Sum4 = (Sum4 + Sum_4(i,j));
    end
end


D4 = (4*pi*N^2)/Sum4;
