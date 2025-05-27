
    % Ramp Function
    opts = odeset('Refine',5);
    %Simulation 1
    [t,x] = ode45(@ramp3,[0 8],[2; 2],opts);
    r = 2*t;
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
    xlabel('Time(sec)');
    legend('r','y')
    title('Απόκριση Εξόδου και Εισόδου Αναφοράς')
    title(tc1,'Συνάρτηση Ράμπας κλίσης 2 για το δεύτερο σύστημα με αρχικές συνθήκες y(0)=-2,ydot(0) = 0')
    %============================================================================
    figure
    %Simulation 2
    [t,x] = ode45(@ramp3,[0 8],[-1; 2],opts);
    r = 2*t;
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
    xlabel('Time(sec)');
    legend('r','y')
    title('Απόκριση Εξόδου και Εισόδου Αναφοράς')
    title(tc1,'Συνάρτηση Ράμπας κλίσης 2 για το δεύτερο σύστημα με αρχικές συνθήκες y(0)=1,ydot(0) = 0')
    %============================================================================
    figure
    %Simulation 3
    [t,x] = ode45(@ramp3,[0 8],[0; 1.5],opts);
    r = 2*t;
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
    xlabel('Time(sec)');
    legend('r','y')
    title('Απόκριση Εξόδου και Εισόδου Αναφοράς')
    title(tc1,'Συνάρτηση Ράμπας κλίσης 2 για το δεύτερο σύστημα με αρχικές συνθήκες y(0)=0,ydot(0) = 0.5')
    %============================================================================
    figure
    %Simulation 4
    [t,x] = ode45(@ramp3,[0 8],[-2; 0],opts);
    r = 2*t;
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
    xlabel('Time(sec)');
    legend('r','y')
    title('Απόκριση Εξόδου και Εισόδου Αναφοράς')
    title(tc1,'Συνάρτηση Ράμπας κλίσης 2 για το δεύτερο σύστημα με αρχικές συνθήκες y(0)=2,ydot(0) = 2')
    %============================================================================
    figure
    %Simulation 5
    [t,x] = ode45(@ramp3,[0 8],[-2.5; 3],opts);
    r = 2*t;
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
    xlabel('Time(sec)');
    legend('r','y')
    title('Απόκριση Εξόδου και Εισόδου Αναφοράς')
    title(tc1,'Συνάρτηση Ράμπας κλίσης 2 για το δεύτερο σύστημα με αρχικές συνθήκες y(0)=2.5,ydot(0) = -1')
    %============================================================================
    figure
    %Simulation 6
    [t,x] = ode45(@ramp3,[0 8],[-1.1; 0],opts);
    r = 2*t;
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
    xlabel('Time(sec)');
    legend('r','y')
    title('Απόκριση Εξόδου και Εισόδου Αναφοράς')
    title(tc1,'Συνάρτηση Ράμπας κλίσης 2 για το δεύτερο σύστημα με αρχικές συνθήκες y(0)=1.1,ydot(0) = 2')
    %============================================================================

