clear;

M = 4;
a = 0.25;
c = 0.5;
N = 100000;

Es1 = a;
Es2 = 1-a;

Eg1 = (3*Es1)/(M*M - 1); % a/5
Eg2 = (3*Es2)/(M*M - 1); % (1-a)/5

SNR = 0:20;
N0 = 10.^(-SNR/10);

Errcnt1 = zeros(1,length(SNR));
Errcnt2 = zeros(1,length(SNR));

for i = 1:length(SNR)
    for jj=1:N
        x = randsrc(1,1,[-3,-1,1,3] * sqrt(Eg1)) + j*randsrc(1,1,[-3,-1,1,3] * sqrt(Eg2));

        n1_real = sqrt((N0(i)/4))*randn();
        n1_imag = sqrt((N0(i)/4))*randn();
        n1 = complex(n1_real,n1_imag);

        n2_real = sqrt((c*N0(i)/4)).*randn();
        n2_imag = sqrt((c*N0(i)/4)).*randn();
        n2 = complex(n2_real,n2_imag);

        r1 = x + n1;
        r2 = x + n2;
    
        x_re = real(x);
        x_im = imag(x);

        y1 = real(r1);
        y2 = imag(r2);
       
      
        if(y1  < -2*sqrt(Eg1))
            k = -3*sqrt(Eg1);

            if (abs(x_re - k) > 0.1)
                Errcnt1(i) = Errcnt1(i) + 1;
                
            end
        end

        if((y1 >= -2*sqrt(Eg1)) && (y1 < 0))
            k = -1*sqrt(Eg1);

            if (abs(x_re - k) > 0.1)
                Errcnt1(i) = Errcnt1(i) + 1;
        
            end
        end

        if((y1 >= 0) && (y1 < 2*sqrt(Eg1)))
            k = 1*sqrt(Eg1);

            if (abs(x_re - k) > 0.1)
                Errcnt1(i) = Errcnt1(i) + 1;
            end
        end

        if(y1  >= 2*sqrt(Eg1))
            k = 3*sqrt(Eg1);

            if (abs(x_re - k) > 0.1)
                Errcnt1(i) = Errcnt1(i) + 1;
            end
        end


       

        if(y2  < -2*sqrt(Eg2))
            m = -3*sqrt(Eg2);

            if (abs(x_im - m) > 0.1)
                Errcnt2(i) = Errcnt2(i) + 1;
            end
        end

        if((y2 >= -2*sqrt(Eg2)) && (y2 < 0))
            m = -1*sqrt(Eg2);

            if (abs(x_im - m) > 0.1)
                Errcnt2(i) = Errcnt2(i) + 1;
            end
        end

        if((y2 >= 0) && (y2 < 2*sqrt(Eg2)))
            m = 1*sqrt(Eg2);

            if (abs(x_im - m) > 0.1)
                Errcnt2(i) = Errcnt2(i) + 1;
            end
        end

        if(y2  >= 2*sqrt(Eg2))
            m = 3*sqrt(Eg2);

            if (abs(x_im - m) > 0.1)
                Errcnt2(i) = Errcnt2(i) + 1;
            end
        end



    end
 
end

SimSep1 = Errcnt1/N;
SimSep2 = Errcnt2/N;
SEP1 = 1.5*qfunc(sqrt(4*Eg1./N0));
SEP2 = 1.5*qfunc(sqrt((8*Eg2)./N0));
semilogy(SNR,SEP1,'r');
hold on
semilogy(SNR,SimSep1,'b');
semilogy(SNR,SimSep2,'m');
semilogy(SNR,SEP2,'g');
xlabel('SNR(dB)');
ylabel('SEP');
legend('SEP1(Theory)','SEP1(Sim)','SEP2(Sim)','SEP2(Theory)');


