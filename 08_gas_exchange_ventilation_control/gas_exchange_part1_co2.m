    clear all
close all
clc
Vlung = 2.5;
VD = 0.03;
Kco2 = 0.012;
Vtiss = 40;
alphaco2 = 0.001;
V0 = 0.12;
Fattore_guadagno = 0;
Gp = 0.02*Fattore_guadagno;
Gc = 0.04*Fattore_guadagno;
taup = 20;
tauc = 120;

thetap = 40;
thetac = 40;
tmax = 2000;
dt = 0.1;
t = [0:dt:tmax];
L = length(t);

failure = 1; %0.35;   % normale =1, riducendo failure si simula l'insufficienza cardiaca
Q = 0.083*failure;   % valore normale 0.083;
Tp = 6.1/failure;   % valore normale 6.1;
Tc = 7.1/failure;  % valore normale 7.1

Metabolismo = 1;    %normale =1, aumentando metabolismo si simula un aumento del metabolismo
Mco2 = 0.25/60*Metabolismo;
PIco2 = 0;

Paco2 = zeros(1,L);
Pvco2 = zeros(1,L);
DVp = zeros(1,L);
DVc = zeros(1,L);
V = zeros(1,L);
inizio = 0; %max([round(Tp/dt) round(Tc/dt)]);

Paco2(1:inizio+1) = 0; %40;
Pvco2(1:inizio+1) = 0; %44.1817;
V(1:inizio+1) = V0;



for j = inizio+1:L-1,

    DPaco2 = ( (V(j) - VD)*( PIco2-Paco2(j) )+863*Q*Kco2*(Pvco2(j) - Paco2(j)) )/Vlung;
    DPvco2 = (Q*Kco2*( Paco2(j) - Pvco2(j) ) + Mco2) / Vtiss/alphaco2;
%     DDVp = (-DVp(j) + Gp*( Paco2(j-round(Tp/dt)) - thetap))/taup;
%     DDVc = (-DVc(j) + Gc*( Paco2(j-round(Tc/dt)) - thetac))/tauc;
    
    Paco2(j+1) = Paco2(j) + dt*DPaco2;
    Pvco2(j+1) = Pvco2(j) + dt*DPvco2;
%     DVp(j+1) = DVp(j) + dt*DDVp;
%     DVc(j+1) = DVc(j) + dt*DDVc;   
    V(j+1) = V0 + DVp(j) + DVc(j);
    if V(j+1) < 0  V(j+1) = 0; end
end
V(L) = V0 + DVp(L) + DVc(L);

plot(t,Paco2,'b',t,Pvco2,'r','linewidth',1.5)
title('Paco2: blue; PvCO2: red','fontsize',18)
xlabel('tempo (s)','fontsize',18)
ylabel('pressione CO2 (mHg)','fontsize',18)
set(gca,'fontsize',18)
figure
plot(t,V*60,'r','linewidth',2)
hold on
plot(t,DVp*60,'--b',t,DVc*60,'--g','linewidth',1.5)
title('ventilazione: red; DVP: blue; DVC: green','fontsize',18)
xlabel('tempo (s)','fontsize',18)
ylabel('ventilazione (l/min)','fontsize',18)
set(gca,'fontsize',18)


    
    
