SNR = 0:20;

theta_opt = zeros(1,length(SNR));


for i = 1:length(SNR)

    theta_opt(i) = fminbnd(@(theta) maxtheta(theta, SNR(i)), 0, pi/4);

end

plot(SNR,theta_opt*(180/pi));