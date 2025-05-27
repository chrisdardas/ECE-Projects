function [Y,s] = Ycalc(q,qdot,qr,qr_der)

g = 9.81;
l1 = 0.5;


Y11 = qr_der(1);
Y12 = qr_der(2);
Y13 = (2*qr_der(1) + qr_der(2))*cos(q(2)) - (qdot(2)*qr(1)+ qdot(1)*qr(2) + qdot(2)*qr(2))*sin(q(2)) + (g/l1)*cos(q(1) + q(2));
Y14 = cos(q(1));

Y21 = 0;
Y22 = qr_der(1)+qr_der(2);
Y23 = qr_der(1)*cos(q(2)) + qr(1)*qdot(1)*sin(q(2)) + (g/l1)*cos(q(1) + q(2));
Y24 = 0;

Y = [Y11 Y12 Y13 Y14; Y21 Y22 Y23 Y24];

s1 = qdot(1) - qr(1);
s2 = qdot(2) - qr(2);

s = [s1;s2];

end