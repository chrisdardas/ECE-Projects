clear;
seg = 41;
% Read txt into cell A
fid = fopen('C:\4nec2\out\test_2.nec','r');
i = 1;
tline = fgetl(fid);
A{i} = tline;
while ischar(tline)
    i = i+1;
    tline = fgetl(fid);
    A{i} = tline;
end
fclose(fid);
% Change cell A
lamda = 10;
d = 0.05*lamda:0.05*lamda:3*lamda;
Zm = zeros(1,length(d));
for j = 1:length(d)
    
    A{1} = sprintf('CM');
    A{2} = sprintf('CE');
    A{3} = sprintf('GW 1 41 0 0 -2.5 0 0 2.5 0.01');
    A{4} = sprintf('GW 2 41 %.2f 0 -2.5 %.2f 0 2.5 0.01',d(j),d(j));
    A{5} = sprintf('GE 0');
    A{6} = sprintf('GN -1');
    A{7} = sprintf('EK');
    A{8} = sprintf('EX 0 1 21 0 1 0 0 0');
    A{9} = sprintf('FR 0 0 0 0 30 0');
    A{10} = sprintf('RP 0 37 73 1003 -180 0 5 5 0 0');
    A{11} = sprintf('EN');
    % Write cell A into txt
    fid = fopen('C:\4nec2\out\test_2.nec', 'w');
    for i = 1:numel(A)
        if A{i+1} == -1
            fprintf(fid,'%s', A{i});
            break
        else
            fprintf(fid,'%s\n', A{i});
        end
    end
    
    

    %RUN 4NEC2 TO GET Zin
    system('nec2dXS1K5.exe<thema3a.txt');
    fout = fopen('C:\4nec2\out\new.out');
    filename = 'C:\4nec2\out\new.out';
    Zm(j) = getCurrents(fout,seg,filename);
    %CALCULATE Zm FROM Zin AND STORE ITS VALUE IN A MATRIX TO PLOT IT
    %plot(d(j),Re(Zm)) && plot(d(j),Im(Zm))
    %MOVE TO THE NEXT COORDINATES
    
    fclose(fid);
    
    %type 'C:\4nec2\out\new.out'
end

plot(d,real(Zm),'b');
hold on
plot(d,imag(Zm),'r');
xlabel("d")
ylabel("Zm")


