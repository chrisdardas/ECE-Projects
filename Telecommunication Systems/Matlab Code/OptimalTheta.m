    clear;
    c = 0.5;
    N = 100000;

    SNR = 0:20;
    
    N0 = 10.^(-SNR/10);
    theta = (pi*26.565)/180;
    Errcnt1 = zeros(1,length(SNR));
    Errcnt2 = zeros(1,length(SNR));
    cnt = 0;

for i=1:length(SNR)
    for jj=1:N
            x = randsrc(1,1,[cos(theta)-sin(theta),-cos(theta)-sin(theta),sin(theta)-cos(theta),cos(theta)+sin(theta)]*sqrt(1/2)) + j*randsrc(1,1,[cos(theta)+sin(theta),cos(theta)-sin(theta),-cos(theta)-sin(theta),sin(theta)-cos(theta)]*sqrt(1/2) );

            n1_real = sqrt((N0(i)/4))*randn();
            n1_imag = sqrt((N0(i)/4))*randn();
            n1 = complex(n1_real,n1_imag);

            n2_real = sqrt((c*N0(i)/4))*randn();
            n2_imag = sqrt((c*N0(i)/4))*randn();
            n2 = complex(n2_real,n2_imag);

            r1 = x + n1;
            r2 = x + n2;
    
            x_re = real(x);
            x_im = imag(x);

            y1 = real(r1);
            y2 = imag(r2);
       
            mid_re1 = -cos(theta)/sqrt(2);

            mid_re2 = 0;

            mid_re3 = cos(theta)/sqrt(2);


            if(y1  < mid_re1)
                k = -(cos(theta)+sin(theta))*sqrt(1/2);

                if (abs(x_re - k) > 0.1)
                  Errcnt1(i) = Errcnt1(i) + 1;
                
                end
            end

            if((y1 >= mid_re1) && (y1 < mid_re2))
                k = (sin(theta) - cos(theta))*(sqrt(1/2));

                if (abs(x_re - k) > 0.1)
                    Errcnt1(i) = Errcnt1(i) + 1;
        
                end
            end

            if((y1 >= mid_re2) && (y1 < mid_re3))
              k = (cos(theta) - sin(theta))*sqrt(1/2);

                if (abs(x_re - k) > 0.1)
                    Errcnt1(i) = Errcnt1(i) + 1;
                end
            end

            if(y1  >= mid_re3)
                k = (cos(theta)+sin(theta))*sqrt(1/2);

                if (abs(x_re - k) > 0.1)
                    Errcnt1(i) = Errcnt1(i) + 1;
               end
            end

            mid_im1 = -cos(theta)/sqrt(2);

            mid_im2 = 0;

            mid_im3 = cos(theta)/sqrt(2);

            if(y2  < mid_im1)
                m = -(cos(theta)+sin(theta))*sqrt(1/2);

                if (abs(x_im - m) > 0.1)
                    Errcnt2(i) = Errcnt2(i) + 1;
                end
            end

            if((y2 >= mid_im1) && (y2 < mid_im2))
                m = (sin(theta) - cos(theta))*sqrt(1/2);

                if (abs(x_im - m) > 0.1)
                    Errcnt2(i) = Errcnt2(i) + 1;
                end
            end

            if((y2 >= mid_im2) && (y2 < mid_im3))
                m = (cos(theta)-sin(theta))*sqrt(1/2);

                if (abs(x_im - m) > 0.1)
                    Errcnt2(i) = Errcnt2(i) + 1;
                end
            end

            if(y2  >= mid_im3)
               m = (cos(theta) + sin(theta))*sqrt(1/2);

                if (abs(x_im - m) > 0.1)
                    Errcnt2(i) = Errcnt2(i) + 1;
                end
            end



    end
end

        SimSep1 = Errcnt1/N;
        SimSep2 = Errcnt2/N;
        legend
        semilogy(SNR,SimSep1);
        hold on
        
        semilogy(SNR,SimSep2);
        xlabel('SNR(dB)');
        ylabel('SEP');
        legend('SEP1','SEP2');
        