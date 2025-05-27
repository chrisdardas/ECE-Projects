clc;
close all;
clearvars;


lf = 0.3;
lu = 0.3;

p_0B = [0.5 -0.5 0.5]';

R_0B = eye(3);
g_0B = [R_0B p_0B;0 0 0 1];
g_B0 = inv(g_0B);

g_0B = SE3(g_0B);
g_B0 = SE3(g_B0);

q0 = [-1.5692 -0.9318 1.211 -1.85 -1.5708 -0.522];

HA = human_arm();
robot = ur5robot();

length = size(0:0.01:5, 2);
q = zeros(length, 6);
q(1,:) = q0;
i = 1;
T = 10; % seconds per segment
Ts = 0.01; % sampling period
time = 0:Ts:T; % total time for one segment
p_s = [0; 0; 0];
e_p = zeros(3, length);
theta = zeros(1, length);
pd = zeros(3, 1000);
p = zeros(3, 1000);
Q = zeros(4,1000);
Qd = zeros(4,1000);
e_i = zeros(3, 1000);
Qe = zeros(4, 1000);

%myR = zeros(3, 3, length);
%myR(:,:,1) = eye(3);

for t = 0.01 : Ts : T
    [p_w, Q_w, dotp_w, omega_w] = HA.get_arm_posture(t); % get the position, orientation, linear and angular velocity of the human arm
    % for a period of 5 seconds with step 0.01 seconds
    
    g_06 = robot.fkine(q(i,:));
    g_B6 = g_B0*g_06;
    p_we = [-lf; 0; 0];
    %R_w = UnitQuaternion.q2r(Q_w);
    R_w = quat2rotm(Q_w');
    p_e = R_w * p_we + p_w;

    omega_w_skew = skew(omega_w);
    dotR_w = omega_w_skew * R_w;
    dotp_e = dotR_w * p_we + dotp_w;

    p(:,i) = g_06.t;
    if t <= 5
        tf = 5;
%------------------------------------------------------------ Linear Interpolation -------------------------------------------------------------------------
        %pd(:,i) = p_w + (p_e - p_w)*(t/5);
        %dot_pd = dotp_w + (dotp_e - dotp_w)*(t/5) + (p_e - p_w) * (1/5);
%------------------------------------------------------------------------------------------------------------------------------------------------------------




%------------------------------------------------------------- 3 grade  Polynomial --------------------------------------------------------------------------
         pd(:,i) = p_w + (3/tf^2)*(p_e - p_w)*t^2 - (2/tf^3)*(p_e - p_w)*t^3;
         dot_pd = dotp_w + (3/tf^2)*(dotp_e - dotp_w)*t^2 + (6/tf^2)*(p_e - p_w)*t - (2/tf^3)*(dotp_e - dotp_w)*t^3 - (6/tf^3)*(p_e -p_w)*t^2;

%------------------------------------------------------------------------------------------------------------------------------------------------------------  

        e_p(:,i) = p(:,i) - pd(:,i);
    
    
        Rot = [g_06.n g_06.o g_06.a];
        Q(:,i) = rotm2quat(Rot)';
    

        Qd(:,i) = Q_w;
        Q_inv = quatinv(Q_w');
        Qe(:,i) = quatmultiply(Q(:,i)', Q_inv)';
    
    
        e_i(:,i) = Qe(2:4,i);

    
        Kp = 4*eye(3);
        Ko = 4*eye(3);

        he = Qe(1,i);
        ee = Qe(2:4,i);
    
        Ree = eye(3) + 2*he*skew(ee) + 2*skew(ee)*skew(ee);
        K = [Kp zeros(3); zeros(3) Ko];
        u = [dot_pd; Ree*omega_w] - K * [e_p(:,i); e_i(:,i)];
    
        Jacobian = robot.jacob0(q(i,:));
      
        q_dot = (Jacobian\u)';
   %-------------------------------------Comment out this part if you want to see the graphs with the trajectory for theta----------------------------------------------------------------
  
        if t == 5
            OB = p_e;
            OA = p_w;
            AB = -OA + OB;
            cos_theta = ((-OB)' * AB)/(norm((-OB))  * norm(AB));
            theta_d = -acos(cos_theta);

            theta(1, i+ 1 - 500) = theta_d; % Normal theta as found from the cosine
        end
  %-------------------------------------  Comment out until this line   ---------------------------------------------------------------------------------------------------------------
  
    else
%------------------------------------------------------------ Linear Interpolation --------------------------------------------------------------------------

        %pd(:,i) = p_e + (p_s - p_e)*((t-5)/5);
        %dot_pd = dotp_e + (0 - dotp_e)*((t-10)/5) + (p_s - p_e) * (1/5);

%-------------------------------------------------------------------------------------------------------------------------------------------------------------




%------------------------------------------------------------- 3 grade  Polynomial --------------------------------------------------------------------------        
         tf = 5;
         pd(:,i) = p_e + (3/tf^2)*(p_s - p_e)*(t-5)^2 -  (2/tf^3)*(p_s - p_e)*(t-5)^3;
         dot_pd = dotp_e + (3/tf^2)*(0 - dotp_e)*(t-5)^2 + (6/tf^2)*(p_s - p_e)*(t-5) - (2/tf^3)*(0 - dotp_e)*(t-5)^3 - (6/tf^3)*(p_s - p_e)*(t-5)^2;

%------------------------------------------------------------------------------------------------------------------------------------------------------------        
        e_p(:,i) = p(:,i) - pd(:,i);
        Rot = [g_06.n g_06.o g_06.a];
        Q(:,i) = rotm2quat(Rot)';
        

        OB = p_e;
        OA = p_w;
        AB = -OA + OB;
        cos_theta = ((-OB)' * AB)/(norm((-OB))  * norm(AB));
        theta_d = -acos(cos_theta);

        theta(1, i+ 1 - 500) = theta_d; % Normal theta as found from the cosine



%------------------------------------------------------------ Linear Interpolation for theta ----------------------------------------------------------------
        %if t<=7
        %    theta(1, i + 1 - 500)  = theta_d*((t-5)/2);
        %else
        %    theta(1, i + 1 - 500) = theta_d;
        %end

%------------------------------------------------------------------------------------------------------------------------------------------------------------





%------------------------------------------------------------- 3 grade  Polynomial -------------------------------------------------------------------------- 
        % if t <= 6
        %     theta(1, i + 1 - 500)  = (3)*(theta_d)*(t - 5)^2 - (2)*(theta_d)*(t - 5)^3;
        % else
        %     theta(1,i + 1 - 500) = theta_d;
        % end


%------------------------------------------------------------------------------------------------------------------------------------------------------------


        dot_theta = (theta(1, i + 1 - 500) - theta(1, i + 1 - 500 - 1)) / Ts ;

        R = [cos(theta(1, i + 1 - 500)) 0 sin(theta(1, i + 1 - 500)); 0 1 0; -sin(theta(1, i + 1 - 500)) 0 cos(theta(1, i + 1 - 500))];
        dot_R = [-sin(theta(1, i + 1 - 500)) 0 cos(theta(1, i + 1 - 500)); 0 0 0 ; -cos(theta(1, i + 1 - 500)) 0 -sin(theta(1, i + 1 - 500))]*dot_theta;

        R_e = R_w * R;
        dotR_e = dotR_w * R + R_w * dot_R;
        omega_e =  dotR_e * R_e'  ;

        omega_e = [omega_e(3,2); omega_e(1,3); omega_e(2,1)];
        Qd(:,i) = rotm2quat(R_e)';
        Q_d_inv = quatinv(Qd(:,i)');
        Qe(:,i) = quatmultiply(Q(:,i)', Q_d_inv);
        e_i(:,i) = Qe(2:4,i)';

    
        Kp = 4*eye(3);
        Ko = 4*eye(3);
        
        he = Qe(1,i);
        ee = Qe(2:4,i);

        

    
        Ree = eye(3) + 2*he*skew(ee) + 2*skew(ee)*skew(ee);
        K = [Kp zeros(3); zeros(3) Ko];
        u = [dot_pd; Ree*omega_e] - K * [e_p(:,i); e_i(:,i)];
    
        Jacobian = robot.jacob0(q(i,:));
      
        q_dot = (Jacobian\u)';
    end

    q(i+1, :) = q(i, :) + q_dot*Ts;
    
    hold on;
    robot.plot(q(i,:));

    x_forearm = [p_e(1), p_w(1)];
    y_forearm = [p_e(2), p_w(2)];
    z_forearm = [p_e(3), p_w(3)];
    h1 = plot3(x_forearm, y_forearm, z_forearm,'-x');

    x_upperarm = [p_s(1), p_e(1)];
    y_upperarm = [p_s(2), p_e(2)];
    z_upperarm = [p_s(3), p_e(3)];
    h2 = plot3(x_upperarm, y_upperarm, z_upperarm,'-x');
    grid on;
    pause(0.000001*Ts);
    if i < 1000
        delete(h1);
        delete(h2);
    end
     i = i + 1;
     
end



figure('Name','Joints of the Robot')
tc1 = tiledlayout(2,3);
nexttile
plot(time,q(:,1),'b')
xlabel('Time(sec)')
ylabel('Position in Rads')
title('Joint 1')
grid on; 
xlim([0 10]);
nexttile
plot(time,q(:,2),'r')
xlabel('Time(sec)')
ylabel('Position in Rads')
title('Joint 2')
grid on; 
xlim([0 10]);
nexttile
plot(time,q(:,3),'g')
xlabel('Time(sec)')
ylabel('Position in Rads')
title('Joint 3')
grid on; 
xlim([0 10]);
nexttile
plot(time,q(:,4),'c')
xlabel('Time(sec)')
ylabel('Position in Rads')
title('Joint 4')
grid on; 
xlim([0 10]);
nexttile
plot(time,q(:,5),'y')
xlabel('Time(sec)')
ylabel('Position in Rads')
title('Joint 5')
grid on; 
xlim([0 10]);
nexttile
plot(time,q(:,6),'m')
xlabel('Time(sec)')
ylabel('Position in Rads')
title('Joint 6')
grid on; 
xlim([0 10]);
title(tc1,'\bf Joints');

figure('Name','Position Erros')
tc2 = tiledlayout(3,1);
time = 0.01:Ts:T;
nexttile;
plot(time, e_p(1,:));
xlabel('Time(sec)')
ylabel('Position Error in X axis')
legend('e_p = x - x_d')
grid on;  

nexttile;
plot(time, e_p(2,:),'r');
xlabel('Time(sec)')
ylabel('Position Error in Y axis')
legend('e_p = y - y_d')
grid on;  

nexttile;
plot(time, e_p(3,:),'g');
xlabel('Time(sec)')
ylabel('Position Error in Z axis')
legend('e_p = z - z_d')
grid on; 
title(tc2,'\bf Position Errors');

figure('Name','Positions')
tc3 = tiledlayout(3,1);
nexttile;
time = 0.01:Ts:T;
hold on
plot(time, p(1,:),'r');
plot(time, pd(1,:),'b');
legend('X of the end of arm', 'Desired X_d')
xlabel('Time(sec)')
ylabel('X Position')
grid on;
hold off;

nexttile;
time = 0.01:Ts:T;
hold on
plot(time, p(2,:),'r');
plot(time, pd(2,:),'b');
legend('Y of the end of arm', 'Desired Y_d')
xlabel('Time(sec)')
ylabel('Y Position')
grid on;
hold off;

nexttile;
time = 0.01:Ts:T;
hold on
plot(time, p(3,:),'r');
plot(time, pd(3,:),'b');
legend('Z of the end of arm', 'Desired Z_d')
xlabel('Time(sec)')
ylabel('Z Position')
grid on;
hold off;
title(tc3,'\bf Positions');

figure('Name',"Quaternions")
tc4 = tiledlayout(2,2);
nexttile;
hold on
plot(time,Q(1,:),'b');
plot(time,Qd(1,:),'r');
legend('First Coordinate of Arm Quaternion', 'Desired First Coordinate of Arm Quaternion')
xlabel('Time(sec)')
ylabel('First Quaternion Coordinate')
grid on;
hold off;

nexttile;
hold on
plot(time,Q(2,:),'b');
plot(time,Qd(2,:),'r');
legend('Second Coordinate of Arm Quaternion', 'Desired Second Coordinate of Arm Quaternion')
xlabel('Time(sec)')
ylabel('Second Quaternion Coordinate')
grid on;
hold off;

nexttile;
hold on
plot(time,Q(3,:),'b');
plot(time,Qd(3,:),'r');
legend('Third Coordinate of Arm Quaternion', 'Desired Third Coordinate of Arm Quaternion')
xlabel('Time(sec)')
ylabel('Third Quaternion Coordinate')
grid on;
hold off;

nexttile;
hold on
plot(time,Q(4,:),'b');
plot(time,Qd(4,:),'r');
legend('Fourth Coordinate of Arm Quaternion', 'Desired Fourth Coordinate of Arm Quaternion')
xlabel('Time(sec)')
ylabel('Fourth Quaternion Coordinate')
grid on;
hold off;
title(tc4,'\bf Quaternions');


figure('Name','Orientation Errors')
tc5 = tiledlayout(3,1);
time = 0.01:Ts:T;
nexttile;
plot(time, e_i(1,:));
xlabel('Time(sec)')
ylabel('First Coordinate Of Orientation Error')
grid on;  

nexttile;
plot(time, e_i(2,:),'r');
xlabel('Time(sec)')
ylabel('Second Coordinate Of Orientation Error')
grid on;  

nexttile;
plot(time, e_i(3,:),'g');
xlabel('Time(sec)')
ylabel('Third Coordinate Of Orientation Error')
grid on; 
title(tc5,'\bf Orientation Errors');


figure('Name',"Quaternion Error")
tc6 = tiledlayout(2,2);
nexttile;
hold on
plot(time,Qe(1,:),'b');
xlabel('Time(sec)')
ylabel('First Quaternion Coordinate Q_e')
grid on;
hold off;

nexttile;
hold on
plot(time,Qe(2,:),'r');
xlabel('Time(sec)')
ylabel('Second Quaternion Coordinate Q_e')
grid on;
hold off;

nexttile;
hold on
plot(time,Qe(3,:),'g');
xlabel('Time(sec)')
ylabel('Third Quaternion Coordinate Q_e')
grid on;
hold off;

nexttile;
hold on
plot(time,Qe(4,:),'y');
xlabel('Time(sec)')
ylabel('Fourth Quaternion Coordinate Q_e')
grid on;
hold off;
title(tc6,'\bf Quaternion Error');



