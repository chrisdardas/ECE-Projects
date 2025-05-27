clear;

c0 = 3e8;
lamda = 0.125;
theta = pi/6;
d = lamda/20; % ONLY ONE SEGMENT FOR THIS PART
segments = 9;
radius = (lamda/200)*0.5;
f0 = c0/lamda;

length = lamda/4;

X1 = [0 0 0 0 0 0];
Y1 = [0 0 0 0 0 0];
Z1 = [d/2 d/2 d/2 d/2 d/2 d/2];

x21 = length*cos(0)*sin(theta);
y21 = length*sin(0)*sin(theta);
z21 = length*cos(theta)+d/2;

x22 = length*cos(0)*sin(-theta);
y22 = length*sin(0)*sin(-theta);
z22 = length*cos(-theta)+d/2;

x23 = length*cos(pi/3)*sin(theta);
y23 = length*sin(pi/3)*sin(theta);
z23 = length*cos(theta)+d/2;

x24 = length*cos(pi/3)*sin(-theta);
y24 = length*sin(pi/3)*sin(-theta);
z24 = length*cos(theta)+d/2;

x25 = length*cos(2*pi/3)*sin(theta);
y25 = length*sin(2*pi/3)*sin(theta);
z25 = length*cos(theta)+d/2;

x26 = length*cos(2*pi/3)*sin(-theta);
y26 = length*sin(2*pi/3)*sin(-theta);
z26 = length*cos(theta)+d/2;

X2 = [x21 x22 x23 x24 x25 x26];
Y2 = [y21 y22 y23 y24 y25 y26];
Z2 = [z21 z22 z23 z24 z25 z26];


fileID = fopen('thema1.nec','w');
fprintf(fileID,'CM\n');
fprintf(fileID,'CE\n');
for i = 1 : 6
    fprintf(fileID,'GW %12d %12d %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',i,segments,X1(i),Y1(i),Z1(i),X2(i),Y2(i),Z2(i),radius);
end

fprintf(fileID,'GW %12d %12d %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',7,1,0,0,-d/2,0,0,d/2,radius);

for i = 1 : 6
    fprintf(fileID,'GW %12d %12d %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',i+7,segments,X1(i),Y1(i),-Z1(i),X2(i),Y2(i),-Z2(i),radius);
end
fprintf(fileID,'GE 0\n');
fprintf(fileID,'GN -1\n');
fprintf(fileID,'EK\n');
fprintf(fileID,'EX	0	7	1	0	1	0	0\n');
fprintf(fileID,'FR	0	0	0	0	4800	0\n');
fprintf(fileID,'EN\n');


fclose(fileID);
%type C:\4nec2\out\newthema1.nec
type thema1.nec

