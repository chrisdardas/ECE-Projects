function Zm = getCurrents(fid,seg,filename)

i = 1;
tline = fgetl(fid);
A{i} = tline;
while ischar(tline)
    i = i+1;
    tline = fgetl(fid);
    A{i} = tline;
    if strcmp(A{i}, '                             - - - CURRENTS AND LOCATION - - -')
        break;
    end
end
fclose(fid);
if seg == 11
    searchI1 = i + 12;
    searchI2 = i + 22;
else
    searchI1 = i + 27;
    searchI2 = i + 67;
end

fout = fopen(filename);
fileContent = textscan(fout, '%s', 'Delimiter', '\n');
B = fileContent{1,1}(searchI1);
C = fileContent{1,1}(searchI2);
fclose(fout);

B1 = cell2mat(B);
B2 = str2num(B1);
I1_Re = B2(7);
I1_Im = B2(8);

C1 = cell2mat(C);
C2 = str2num(C1);
I2_Re = C2(7);
I2_Im = C2(8);


I1 = I1_Re + j*I1_Im;
I2 = I2_Re + j*I2_Im;

Zs = 73.1 + j*42.5;

Zm = -Zs*(I2/I1);

end