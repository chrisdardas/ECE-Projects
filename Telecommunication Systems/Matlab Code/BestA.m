SNR = 0:20;

alpha_opt = zeros(1,length(SNR));


for i = 1:length(SNR)

    alpha_opt(i) = fminbnd(@(alpha) maxSEP(alpha, SNR(i)), 0, 1);

end

alpha_opt;
plot(SNR,alpha_opt);