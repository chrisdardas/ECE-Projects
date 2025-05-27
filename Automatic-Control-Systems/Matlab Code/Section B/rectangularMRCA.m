clear;
m1  = 10;
m2 = 8;
l1 = 0.5;
l2 = 0.4;
g = 9.81;
lc1 = 0.25;
lc2 = 0.1;
I1 = 0.23;
I2 = 0.2;

a1 = m1*lc1^2 + m2*lc2^2 + m2*l1^2 + I1 + I2;
a2 = m2*lc2^2 + I2;
a3 = m2*l1*lc2;
a4 = g*(m2*l1 + m1*lc1);
Q = eye(4);

Am = [0 0 1 0;0 0 0 1;-16 0 -8 0; 0 -16 0 -8];
Bm = [zeros(2,2);16*eye(2)];
a = [a1 a2 a3 a4];


P = lyap(Am',Q);
initial = zeros(20,1);

[t,x] = ode45(@(t,x) MRAC (t,x,a,Am,Bm,P),[0 45],initial);

%qd1 = (pi/6)*square(t);
qd1 = (pi/6)*square(t);
qd2 = (pi/6)*square(t);

for k=1:length(t)
    x_new = [x(k,1);x(k,2);x(k,3);x(k,4)];
    xm = [x(k,5);x(k,6);x(k,7);x(k,8)];
    xe = xm - x_new;
    ye = P*xe;
    r=[qd1(k);qd2(k)];
    kp = x(k,9:16);
    kp = reshape(kp,[2,4]);
    kpm = x(k,17:20);
    kpm = reshape(kpm,[2,2]);


    [u{k},Kp_cell{k},Kpm_cell{k}] = ControllerFunctionMRCA(x_new,r,ye,kp,kpm);
end

figure()
for i=1:length(u)
    u1(i)=double(u{i}(1)); 
    u2(i)=double(u{i}(2));
    Kp(i) = norm(double(Kp_cell{i}));
    Kpm(i) = norm(double(Kpm_cell{i}));
end



plot(t,u1,'b',t,u2,'r');
xlabel('Time(sec)');
ylabel('Torque(Nm)');
title('Μεταβολές του Ελεγκτή');
legend('u_1','u_2');


figure()
plot(t,Kp,'b',t,Kpm,'r');
xlabel('Time(sec)');
ylabel('Norm of Gains');
title('Μεταβολές των Προσαρμοστικών Κερδών');
legend('K_p','K_p_m');



q1 = x(:,1);
q2 = x(:,2);

qe1 = q1 - qd1;
qe2 = q2 - qd2;

figure()
tcl = tiledlayout(2,2);

nexttile
plot(t,qe1,'r',t,qe2,'b')
ylabel('q_e_1,q_e_2');
xlabel('t(sec)');
title('Σφάλμα q_e στον χρόνο')
legend('q_e_1','q_e_2')
nexttile
plot(qe1,qe2)
title('Σφάλμα q_e στο φασικό επίπεδο')
xlabel('q_e_1');
ylabel('q_e_2');
nexttile
plot(t,qd1,'r',t,q1,'b');
ylabel('q_d_1,q_1');
xlabel('t(sec)')
legend('q_d_1','q_1')
title("Σύγκλιση της γωνίας q_1 στην επιθυμητή τροχιά")
nexttile
plot(t,qd2,'r',t,q2,'b');
ylabel('q_d_2,q_2');
xlabel('t(sec)')
legend('q_d_2','q_2')
title("Σύγκλιση της γωνίας q_2 στην επιθυμητή τροχιά")
title(tcl,'Aπόκριση q_1 και q_2 και των σφαλμάτων τους')