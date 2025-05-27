clear;
seg = 41;
% Read txt into cell A
fid = fopen('C:\4nec2\out\newthema3b.nec','r');
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
s = 0.05*lamda:0.05*lamda:3*lamda;
Zm = zeros(1,length(s));
for j = 1:length(s)
    
    z1 = s(j) + lamda/4;
    z2 = z1 + lamda/2;
    A{1} = sprintf('CM');
    A{2} = sprintf('CE');
    A{3} = sprintf('GW 1 41 0 0 -2.5 0 0 2.5 0.01');
    A{4} = sprintf('GW 2 41 0 0 %.2f 0 0 %.2f 0.01',z1,z2);
    A{5} = sprintf('GE 0');
    A{6} = sprintf('GN -1');
    A{7} = sprintf('EK');
    A{8} = sprintf('EX 0 1 21 0 1 0 0 0');
    A{9} = sprintf('FR 0 0 0 0 30 0');
    A{10} = sprintf('RP 0 37 73 1003 -180 0 5 5 0 0');
    A{11} = sprintf('EN');
    % Write cell A into txt
    fid = fopen('C:\4nec2\out\test_b.nec', 'w');
    for i = 1:numel(A)
        if A{i+1} == -1
            fprintf(fid,'%s', A{i});
            break
        else
            fprintf(fid,'%s\n', A{i});
        end
    end
    
    
    system('nec2dXS1K5.exe<thema3b.txt');
    fout = fopen('C:\4nec2\out\newb.out');
    filename = 'C:\4nec2\out\newb.out';
    Zm(j) = getCurrents(fout,seg,filename);
    fclose(fid);
end

plot(s,real(Zm),'b');
hold on
plot(s,imag(Zm),'r');
xlabel("s")
ylabel("Zm")


