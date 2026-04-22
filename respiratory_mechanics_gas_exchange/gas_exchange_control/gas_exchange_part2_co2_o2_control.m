<<<<<<<< HEAD:08_gas_exchange_ventilation_control/gas_exchange_part2_co2_o2_control.m
﻿clear all
========
clear all
>>>>>>>> 7c2f5a5 (Merge respiratory modules into a single project):respiratory_mechanics_gas_exchange/gas_exchange_control/Exercise8_II_vent.m
close all
clc
Vlung = 2.5;
VD = 0.03;
Kco2 = 0.012;
ko2 = 0.1;
Phalf = 30;
Vtiss = 40;
alphaco2 = 0.001;
alphao2 = 0.0031*10/1000;
V0 = 0.12;
Fattore_guadagno = 1;
Fattore_guadagno_o2 = 1;
Gpc = 0.02*Fattore_guadagno;
Gpo  = 1*Fattore_guadagno_o2;
Gc = 0.04*Fattore_guadagno;
taup = 20;
tauc = 120;

thetap = 40;
thetac = 40;
tmax = 1000;
dt = 0.1;
t = [0:dt:tmax];
L = length(t);

failure = 1;   % normale =1, riducendo failure si simula l'insufficienza cardiaca
Q = 0.083*failure;   % valore normale 0.083;
Tp = 6.1/failure;   % valore normale 6.1;
Tc = 7.1/failure;  % valore normale 7.1

Metabolismo = 1.0;    %normale =1, aumentando metabolismo si simula un aumento del metabolismo
Mco2 = 0.25/60*Metabolismo;
Mo2 = - 16/3600*Metabolismo;
PIco2 = 30;
PIo2 =  100;

Paco2 = zeros(1,L);
Pvco2 = zeros(1,L);
Pao2 = zeros(1,L);
Pvo2 = zeros(1,L);
DVp = zeros(1,L);
DVc = zeros(1,L);
V = zeros(1,L);
inizio = max([round(Tp/dt) round(Tc/dt)]);
fao2_vett = zeros(1,L);

Paco2(1:inizio+1) = 40;
Pvco2(1:inizio+1) = 44.1817;
Pao2(1:inizio+1) = 107.34;
Pvo2(1:inizio+1) = 40;
V(1:inizio+1) = V0;




for j = inizio+1:L-1,

    DPaco2 = ( (V(j) - VD)*( PIco2-Paco2(j) )+863*Q*Kco2*(Pvco2(j) - Paco2(j)) )/Vlung;
    DPvco2 = (Q*Kco2*( Paco2(j) - Pvco2(j) ) + Mco2) / Vtiss/alphaco2;
    fao2 = 20/100/(1+exp(-ko2*(Pao2(j)-Phalf)));
    fvo2 = 20/100/(1+exp(-ko2*(Pvo2(j)-Phalf)));
    fao2_rit = 20/100/(1+exp(-ko2*(Pao2(j-round(Tp/dt))-Phalf)));
    DPao2 = ( (V(j) - VD)*( PIo2-Pao2(j) )+863*Q*(fvo2-fao2))/Vlung;
    DPvo2 = (Q*(fao2 - fvo2) + Mo2) / Vtiss/alphao2;
    DDVp = (-DVp(j) + Gpc*( Paco2(j-round(Tp/dt)) - thetap))/taup - Gpo*(fao2_rit - 20/100)/taup;
    DDVc = (-DVc(j) + Gc*( Paco2(j-round(Tc/dt)) - thetac))/tauc;
    
    Paco2(j+1) = Paco2(j) + dt*DPaco2;
    Pvco2(j+1) = Pvco2(j) + dt*DPvco2;
    Pao2(j+1) = Pao2(j) + dt*DPao2;
    Pvo2(j+1) = Pvo2(j) + dt*DPvo2;
    DVp(j+1) = DVp(j) + dt*DDVp;
    DVc(j+1) = DVc(j) + dt*DDVc;   
    V(j+1) = V0 + DVp(j) + DVc(j);
    if V(j+1) < 0  V(j+1) = 0; end
end
V(L) = V0 + DVp(L) + DVc(L);
fao2_vett = 20/100./(1+exp(-ko2*(Pao2-Phalf)));

plot(t,Paco2,'b',t,Pvco2,'r','linewidth',1.5)
title('Paco2: blue; PvCO2: red','fontsize',18)
xlabel('tempo (s)','fontsize',18)
ylabel('pressione CO2 (mHg)','fontsize',18)
set(gca,'fontsize',18)
figure
plot(t,Pao2,'b',t,Pvo2,'r','linewidth',1.5)
title('Pao2: blue; PvO2: red','fontsize',18)
xlabel('tempo (s)','fontsize',18)
ylabel('pressione O2 (mHg)','fontsize',18)
set(gca,'fontsize',18)
figure
plot(t,fao2_vett,'b','linewidth',1.5)
title('fao2: blue','fontsize',18)
xlabel('tempo (s)','fontsize',18)
ylabel('fractio of O2 (mHg)','fontsize',18)
set(gca,'fontsize',18)
figure
plot(t,V*60,'r','linewidth',2)
hold on
plot(t,DVp*60,'--b',t,DVc*60,'--g','linewidth',1.5)
title('ventilazione: red; DVP: blue; DVC: green','fontsize',18)
xlabel('tempo (s)','fontsize',18)
ylabel('ventilazione (l/min)','fontsize',18)
set(gca,'fontsize',18)


    
<<<<<<<< HEAD:08_gas_exchange_ventilation_control/gas_exchange_part2_co2_o2_control.m
    

========
    
>>>>>>>> 7c2f5a5 (Merge respiratory modules into a single project):respiratory_mechanics_gas_exchange/gas_exchange_control/Exercise8_II_vent.m
