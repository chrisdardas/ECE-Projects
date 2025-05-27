   
    % Unit Step Function
    r = 2;
    opts = odeset('Refine',5);
    %Simulation 1
    tc1 = tiledlayout(3,1);
    nexttile;
    [t,x] = ode45(@unit_step_1,[0 5],[4; 0],opts);
    plot(t,x(:,1),'-bo',t,x(:,2),'-r*')
    legend('x_1','x_2')
    ylabel('x_1,x_2');
    xlabel('t(sec)');
    title('Διάγραμμα Εξισώσεων κατάστασης')
    nexttile;
    x1 = x(:, 1);
    x2 = x(:, 2);
    plot(x1, x2);
    xlabel('x_1');
    ylabel('x_2');
    title('Phase Plane Plot');
    grid on;
    nexttile;
    y = r - x1;
    plot(t,r,'-bo',t,y,'-r*');
    xlabel('t(sec)');
    legend('r','y')
    title('Απόκριση Εξόδου και Εισόδου Αναφοράς')
    
    title(tc1,'Βηματική Συνάρτηση για το πρώτο σύστημα με αρχικές συνθήκες y(0)=-2,ydot(0) = 0')
    %============================================================================
    figure
    %Simulation 2
    tc1 = tiledlayout(3,1);
    [t,x] = ode45(@unit_step_1,[0 5],[1; 0],opts);
    nexttile;
    plot(t,x(:,1),'-bo',t,x(:,2),'-r*')
    legend('x_1','x_2')
    ylabel('x_1,x_2');
    xlabel('t(sec)');
    title('Διάγραμμα Εξισώσεων κατάστασης')
    nexttile;
    x1 = x(:, 1);
    x2 = x(:, 2);
    plot(x1, x2);
    xlabel('x_1');
    ylabel('x_2');
    title('Phase Plane Plot');
    grid on;
    nexttile;
    y = r - x1;
    plot(t,r,'-bo',t,y,'-r*');
    legend('r','y');
    xlabel('Time(sec)');
    title('Απόκριση Εξόδου και Εισόδου Αναφοράς')
    title(tc1,'Βηματική Συνάρτηση για το πρώτο σύστημα με αρχικές συνθήκες y(0)=1,ydot(0) = 0')
    %============================================================================
    figure
    %Simulation 3
    [t,x] = ode45(@unit_step_1,[0 5],[2; -0.5],opts);
    tc1 = tiledlayout(3,1);
    nexttile;
    plot(t,x(:,1),'-bo',t,x(:,2),'-r*')
    legend('x_1','x_2')
    ylabel('x_1,x_2');
    xlabel('t(sec)');
    title('Διάγραμμα Εξισώσεων κατάστασης')
    nexttile;
    x1 = x(:, 1);
    x2 = x(:, 2);
    plot(x1, x2);
    xlabel('x_1');
    ylabel('x_2');
    title('Phase Plane Plot');
    grid on;
    nexttile;
    y = r - x1;
    plot(t,r,'-bo',t,y,'-r*');
    legend('r','y');
    xlabel('Time(sec)');
    title('Απόκριση Εξόδου και Εισόδου Αναφοράς')
    title(tc1,'Βηματική Συνάρτηση για το πρώτο σύστημα με αρχικές συνθήκες y(0)=0,ydot(0) = 0.5')
    %============================================================================
    figure
    %Simulation 4
    [t,x] = ode45(@unit_step_1,[0 5],[0; -2],opts);
    tc1 = tiledlayout(3,1);
    nexttile;
    plot(t,x(:,1),'-bo',t,x(:,2),'-r*')
    legend('x_1','x_2')
    ylabel('x_1,x_2');
    xlabel('t(sec)');
    title('Διάγραμμα Εξισώσεων κατάστασης')
    nexttile;
    x1 = x(:, 1);
    x2 = x(:, 2);
    plot(x1, x2);
    xlabel('x_1');
    ylabel('x_2');
    title('Phase Plane Plot');
    grid on;
    nexttile;
    y = r - x1;
    plot(t,r,'-bo',t,y,'-r*');
    legend('r','y');
    xlabel('Time(sec)');
    title('Απόκριση Εξόδου και Εισόδου Αναφοράς')
    title(tc1,'Βηματική Συνάρτηση για το πρώτο σύστημα με αρχικές συνθήκες y(0)=2,ydot(0) = 2')
    %============================================================================
    figure
    %Simulation 5
    [t,x] = ode45(@unit_step_1,[0 5],[-0.5; 1],opts);
    tc1 = tiledlayout(3,1);
    nexttile;
    plot(t,x(:,1),'-bo',t,x(:,2),'-r*')
    legend('x_1','x_2')
    ylabel('x_1,x_2');
    xlabel('t(sec)');
    title('Διάγραμμα Εξισώσεων κατάστασης')
    nexttile;
    x1 = x(:, 1);
    x2 = x(:, 2);
    plot(x1, x2);
    xlabel('x_1');
    ylabel('x_2');
    title('Phase Plane Plot');
    grid on;
    nexttile;
    y = r - x1;
    plot(t,r,'-bo',t,y,'-r*');
    legend('r','y');
    xlabel('Time(sec)');
    title('Απόκριση Εξόδου και Εισόδου Αναφοράς')
    title(tc1,'Βηματική Συνάρτηση για το πρώτο σύστημα με αρχικές συνθήκες y(0)=2.5,ydot(0) = -1')
    %============================================================================
    figure
    %Simulation 6
    [t,x] = ode45(@unit_step_1,[0 5],[0.9; -2],opts);
    tc1 = tiledlayout(3,1);
    nexttile;
    plot(t,x(:,1),'-bo',t,x(:,2),'-r*')
    legend('x_1','x_2')
    ylabel('x_1,x_2');
    xlabel('t(sec)');
    title('Διάγραμμα Εξισώσεων κατάστασης')
    nexttile;
    x1 = x(:, 1);
    x2 = x(:, 2);
    plot(x1, x2);
    xlabel('x_1');
    ylabel('x_2');
    title('Phase Plane Plot');
    grid on;
    nexttile;
    y = r - x1;
    plot(t,r,'-bo',t,y,'-r*');
    legend('r','y');
    xlabel('Time(sec)');
    title('Απόκριση Εξόδου και Εισόδου Αναφοράς')
    title(tc1,'Βηματική Συνάρτηση για το πρώτο σύστημα με αρχικές συνθήκες y(0)=1.1,ydot(0) = 2')
    %============================================================================

