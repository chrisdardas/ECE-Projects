clear;

G = 0.01*eye(4);
K = 200*eye(2);
L = 4*eye(2);

m1  = 10;
m2 = 8;
l1 = 0.5;
l2 = 0.4;
g = 9.81;
lc1 = 0.3;
lc2 = 0.2;
I1 = 0.2125;
I2 = 0.155;

a_1 = m1*lc1^2 + m2*lc2^2 + m2*l1^2 + I1 + I2;
a_2 = m2*lc2^2 + I2;
a_3 = m2*l1*lc2;
a_4 = g*(m2*l1 + m1*lc1);
initial = [0 0 0 0 a_1 a_2 a_3 a_4];

[t,x] = ode45(@(t,x) myfun(t,x,K,L,G),[0 45],initial);
qd1 = (pi/6)*square(t);
qd2 = (pi/6)*square(t);

figure


for k=1:length(t)
    qe1 = x(k,1) - qd1(k);
    qe2 = x(k,2) - qd2(k);

    qe = [qe1;qe2];
    qr = 0 - L * qe;
    qr_der = 0 - L*[x(k,3);x(k,4)];

    u{k} = ControllerFunction(x(k,1),x(k,2),x(k,3),x(k,4),qr,qr_der,x(k,5),x(k,6),x(k,7),x(k,8),K);
end

for i=1:length(u)
    u1(i)=double(u{i}(1)); 
    u2(i)=double(u{i}(2));    
end


plot(t,u1,'b',t,u2,'r');
xlabel('Time(sec)');
ylabel('Torque(Nm)');
title('Μεταβολές του Ελεγκτή για Τετραγωνικό Παλμό');
legend('u_1','u_2');


q1 = x(:,1);
q2 = x(:,2);
a1 = x(:,5);
a2 = x(:,6);
a3 = x(:,7);
a4 = x(:,8);
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

figure
tc2 = tiledlayout(2,1);
nexttile
plot(t,a1,'r',t,a2,'b',t,a3,'g')
legend('a_1','a_2','a_3')
title('Aπόκριση των αγνώστων παραμέτρων a_1,a_2,a_3 στον χρόνο')
ylabel('a_1,a_2,a_3(kgm^{2})')
xlabel('t(sec)')
nexttile
plot(t,a4,'r')
title('Aπόκριση της άγνωστης παραμέτρου a_4 στον χρόνο')
ylabel('a_4(kgm^{2})')
xlabel('t(sec)')
title(tc2,'Aπόκριση των αγνώστων παραμέτρων')





