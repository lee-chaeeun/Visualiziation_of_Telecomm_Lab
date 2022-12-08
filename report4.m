
snr_db_bpsk = [3 4 5 6 7 8 9];
ber_bpsk =[0.00229 0.0125 5.95*10^(-3) 2.39*10^(-3) 7.74*10^(-4) 1.19*10^(-4) 3.36*(10)^(-5)];

snr_s_db_qpsk = [6 7 8 9 10 11 12];
ber_qpsk = [2.294*10^(-2) 1.271*10^(-2) 6.041*10^(-3) 2.426*10^(-3) 7.887*10^(-4) 1.98*10^(-4) 3.450*10^(-5)];

snr_s_db_epsk = [8 9 10 11 12 13 14 15 16]; 
ber_epsk_t =[0.05936 0.04237 0.02090 0.01815 0.01045 0.005088 0.0002217 0.0008029 0.0002083];

snr_b_db_qpsk = snr_s_db_qpsk - 3;
snr_b_db_epsk = snr_s_db_epsk - 4.77;

%RAYLEIGH T4.16
snr_bdb_rayleigh = [6 8 10 12 14 16];
snr_b_rayleigh = zeros(1,6);
ber_rayleigh = [0.053046 0.035332 0.02330 0.015044 0.0096477 0.006178];
sigmaratio_rayleigh = zeros(1, 6);
for i=1:6
    snr_b_rayleigh(i) =  10^(snr_bdb_rayleigh(i)/10);
    sigmaratio_rayleigh(i) = sqrt(snr_b_rayleigh(i));
end

%Bit error ratio with gaussian channel and 8PSK mapping T4.13
snr_b_db_epsk_t = (3.2:1:11.2);
snr_s_db_epsk_t = snr_b_db_epsk_t - 4.77;
M_epsk = 3; 
snr_b_epsk_t = zeros(1,9);
snr_s_epsk_t = zeros(1,9);

sigma_epsk_t = [0 0 0 0 0 0 0 0 0];
ser_epsk_t = [0 0 0 0 0 0 0 0 0];
ber_epsk_t = [0 0 0 0 0 0 0 0 0]; 
temp = zeros (1, 9);

for i=1:9
    snr_b_epsk_t(i) = 10^(snr_b_db_epsk(i)/10);
    sigma_epsk_t(i) = sqrt(1/(M_epsk*2*snr_b_epsk_t(i)));
    temp(i) = (1/sigma_epsk_t(i))*sin(pi/8);
    ser_epsk_t(i) = 2*qfunc(temp(i));
    ber_epsk_t(i) = ser_epsk_t(i)/M_epsk;
end

%with channel coding 8SPK
snr_bdb_coding = (6.4:2:22.4);
ber_coding = [0.0766 0.051136 0.034060 0.020048 0.0010724 0.0051292 0.0020477 0.00066784 0.000023338];

%diversity techniques
snr_bdb_diversity = (6:2:14);
ber_diversity = [0.01124 0.003739 0.0010363 0.0002447 0.00005182];

%PLOT SNR SYMBOL
fig1 = figure(1);
scatter(snr_db_bpsk,ber_bpsk, 20, 'filled'); hold on;

scatter(snr_s_db_qpsk,ber_qpsk, 20, 'filled');

scatter(snr_s_db_epsk,ber_epsk, 20, 'filled');

scatter(snr_bdb_coding,ber_coding, 20, 'filled');

legend('$BPSK$', '$QPSK$','$8-PSK$','$8-PSK\,with\,channel\,coding$','interpreter','latex')

hold off;

xlabel('$\gamma_{S}[dB]$','interpreter','latex');
ylabel('$P_{eB}$','interpreter','latex');

grid on
set(gca, 'FontName','Times New Roman', 'YScale', 'log');

axis([3 16 10^(-7) 10^0]);

%PLOT SNR BIT \
fig2 = figure(2);
scatter(snr_db_bpsk,ber_bpsk, 20, 'filled'); hold on;

scatter(snr_b_db_qpsk,ber_qpsk, 20, 'filled');

scatter(snr_b_db_epsk,ber_epsk, 20, 'filled');

scatter(snr_b_db_epsk_t,ber_epsk_t, 20, 'filled');

scatter(snr_bdb_rayleigh,ber_rayleigh, 20, 'filled');

scatter(snr_bdb_diversity,ber_diversity, 20, 'filled');

legend('$BPSK$', '$QPSK$','$8-PSK$','$8-PSK\,with\,channel\,coding$','$Rayleigh,Q-PSK$','$Diversity\,technique,Q-PSK$','interpreter','latex')

hold off;

xlabel('$\gamma_{B}[dB]$','interpreter','latex');
ylabel('$P_{eB}$','interpreter','latex');
grid on
set(gca, 'YScale', 'log');

axis([3 16 10^(-7) 10^0]);
