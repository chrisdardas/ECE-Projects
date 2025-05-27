clear;

syms x y
f(x,y) = sin(x+y)*sin(y^2);
%10000gen.mat -> 10000 generations  % 15000gen.mat -> 15000 generations
folder = 'C:\Users\chris\OneDrive\Υπολογιστής\Δαρδαμπούνης_Χρήστος_Αλέξανδρος_10335_Project\Matlab Code'; % Για να μπορέσετε να εκτελέσετε το .mat αρχείο και για να υπολογιστεί το άθροισμα που αναφέρω στην αναφορά μου(δηλαδή το ολοκήρωμα)
%πρέπε να δοθεί η κατάλληλη διαδρομή για να τρέξει το .mat αρχείο
fullMatFileName = fullfile(folder,  '10000gen.mat');
if ~exist(fullMatFileName, 'file')
  message = sprintf('%s does not exist', fullMatFileName);
  uiwait(warndlg(message));
else
  s = load(fullMatFileName);
end
%12003
figure
plot(1:s.maxgenerations,s.err)
title('Best Fitness')
xlabel('Generations')
ylabel('ΜSE')
figure

nexttile
fsurf(s.best_function,[-1 2 -2 1])
xlabel('X');
ylabel('Y');
title('Αποτέλεσμα του γενετικού αλγορίθμου')

nexttile
fsurf(f,[-1 2 -2 1])
xlabel('X');
ylabel('Y');
title('Πραγματική συνάρτηση')
colorbar


figure

nexttile
fsurf(s.best_function)
xlabel('X');
ylabel('Y');
title('Αποτέλεσμα του γενετικού αλγορίθμου')
best = s.best_function;
nexttile
fsurf(f)
xlabel('X');
ylabel('Y');
title('Πραγματική συνάρτηση')
colorbar

u1 = linspace(-1,2,100);
u2 = linspace(-2,1,100);

values = zeros(length(u1),length(u2));


n = 1;
   for i = 1:5:75
    
     const(n) = s.best_chromosome(i);
     c1(n) = s.best_chromosome(i+1);
     c2(n) = s.best_chromosome(i+2);
     s1(n) = s.best_chromosome(i+3);
     s2(n) = s.best_chromosome(i+4);
     n = n + 1;

   end

MSE = 0;
value = 0;
n=1;

for u1=linspace(-1,2,100)
    m=1;
   for u2=linspace(-2,1,100)
       for i=1:15
            part1 = 0.5 * ((u1-c1(i))^2)/(s1(i)^2);
            
            part2 = 0.5 * ((u2-c2(i))^2)/(s2(i)^2);

            power = part1 + part2;
            value = value + const(i)*exp(-power);
       end
        values(n,m)=(sin(u1+u2)*sin(u2^2)-value)^2;
        value = 0;
        m=m+1;
   end
   n=n+1;
end


Sum = 0;
 for i=1:100
    for j=1:100
         Sum = Sum + values(i,j);
     end
 end


