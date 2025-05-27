function [u,Kp,Kpm] = ControllerFunctionMRCA(x,r,ye,kp,kpm)

b_gain1 = -[2500 0;0 2500]*[1 0 1 0;0 1 0 1];
b_gain2 = [2500 0;0 2500]*[1 0 1 0;0 1 0 1];

Kp = kp + b_gain1*ye*x';
Kpm = kpm + b_gain2*ye*r';
u = - Kp*x + Kpm*r;


end