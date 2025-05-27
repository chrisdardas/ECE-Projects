clc;
clearvars;
close all;

%------------------------------ Question (a) ------------------------------
sigma_side = 5;
width = 300;
height = 500;

sigma_area = sigma_side * sqrt(width^2 + height^2);

fprintf("The uncertainty of the area for width=%d and height=%d is : %.4f\n", width,height,sigma_area);
height_vector_1 = 1:1:1000;
width = real(sqrt((sigma_area / sigma_side)^2 - height_vector_1.^2));
figure("Name", "Sides");
plot(width,'b');
hold on ;
plot(height_vector_1, 'r');
legend('Width', 'Height');
hold off;

%------------------------------ Question (b) ------------------------------
width_vector = 1:50:10000;
height_vector = 1:50:10000;
size = length(height_vector);
sigma_area_surf = zeros(size, size);

for i=1:size
    for j=1:size
        sigma_area_surf(i, j) = sigma_side*sqrt(width_vector(i)^2 + height_vector(j)^2);
    end
end

figure('Name', "Values of Uncertainty");
surf(sigma_area_surf);
title("Values of Uncertainty");
xlabel("Width");
ylabel('Height');
zlabel('Uncertainty');