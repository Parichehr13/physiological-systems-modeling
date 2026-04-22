<<<<<<<< HEAD:06_respiratory_spontaneous_breathing/respiratory_spontaneous_breathing.m
﻿
========

>>>>>>>> 7c2f5a5 (Merge respiratory modules into a single project):respiratory_mechanics_gas_exchange/spontaneous_breathing/Exercise6.m
clear
close all
clc

Cl = 0.00127;
Ct = 0.00238;
Cb = 0.0131;
CA = 0.2;
Ccw = 0.2445;
Vul = 34.4/1000;
Vut = 6.63/1000;
Vub = 18.7/1000;
VuA = 1263/1000;
Rml = 1.021;
Rlt = 0.3369;
Rtb = 0.3063;
RbA = 0.0817;
dt = 0.0002;
t = (0:dt:20);
L = length(t);
P1 = zeros(1,L);
P2 = zeros(1,L);
P3 = zeros(1,L);
P4 = zeros(1,L);
P5 = zeros(1,L);
Pl = zeros(1,L);
Ppl = zeros(1,L);
Pt = zeros(1,L);
Pb = zeros(1,L);
PA = zeros(1,L);
    
dV = zeros(1,L);
dVA = zeros(1,L);
dVd = zeros(1,L);
Vl = zeros(1,L);
Vt = zeros(1,L);
Vb = zeros(1,L);
VA = zeros(1,L);
VD = zeros(1,L);

P5(1) = -5;
P4(1) = (2.3 - VuA) /CA;

T=5;
Pa0 = 0; %  normal ventilation
Amus = 3;
Pmus = (Amus*cos(2*pi/T*t)-Amus);

    
for j = 1: L
    Pl(j) = P1(j);
    Ppl(j) = P5(j) + Pmus(j);   %Pmus va calcolata fuori;
    Pt(j) = P2(j) + Ppl(j);
    Pb(j) = P3(j) + Ppl(j);
    PA(j) = P4(j) + Ppl(j);
    
    dV(j) = (Pa0 - Pl(j))/Rml;   % instantaneous total ventilation
    dVA(j) = (Pb(j) - PA(j))/RbA;  % instantaneous alveolar ventialtion 
    Vl(j) = Cl*Pl(j) + Vul;
    Vt(j) = Ct*(Pt(j) - Ppl(j)) + Vut;
    Vb(j) = Cb*(Pb(j) - Ppl(j)) + Vub;
    VA(j) = CA*(PA(j) - Ppl(j)) + VuA;
    VD(j) = Vl(j) + Vt(j) + Vb(j);
    
    dP1 = 1/Cl* ( (Pa0 - Pl(j))/Rml - (Pl(j) - Pt(j))/Rlt );
    dP2 = 1/Ct* ( (Pl(j) - Pt(j))/Rlt - (Pt(j) - Pb(j))/Rtb );
    dP3 = 1/Cb* ( (Pt(j) - Pb(j))/Rtb - (Pb(j) - PA(j))/RbA );
    dP4 = 1/CA* (Pb(j) - PA(j))/RbA;
    dP5 = 1/Ccw* (Pl(j) - Pt(j))/Rlt;
    
    P1(j+1) = P1(j) + dP1*dt;
    P2(j+1) = P2(j) + dP2*dt;
    P3(j+1) = P3(j) + dP3*dt;
    P4(j+1) = P4(j) + dP4*dt;
    P5(j+1) = P5(j) + dP5*dt;
    
end

Width = 1.5;
Font = 18;

    figure(1)
    subplot(221)
    plot(t, Pmus,'b','linewidth',Width);
    title('muscle pressure (b)','fontsize',Font)
    ylabel('cmH_2O','fontsize',Font)
    xlabel('time (s)','fontsize',Font)
    set(gca,'fontsize',Font)
    subplot(222)
    plot(t,Ppl,'linewidth',Width)
    title('pleural pressure','fontsize',Font)
    xlabel('time (s)','fontsize',Font)
    ylabel('cmH_2O','fontsize',Font)
    set(gca,'fontsize',Font)
    subplot(223)
    plot(t,PA','linewidth',Width)
    title('alveolar pressure','fontsize',Font)
    xlabel('time (s)','fontsize',Font)
    ylabel('cmH_2O','fontsize',Font)
    set(gca,'fontsize',Font)
    subplot(224)
    plot(t(100:end),dVA(100:end),'linewidth',Width)
    title('total ventilation','fontsize',Font)
    xlabel('time (s)','fontsize',Font)
    ylabel('L/s','fontsize',Font)
    set(gca,'fontsize',Font)
    
    figure(2)
    subplot(221)
    plot(t, VA+VD,'linewidth',Width);
    title('total volume','fontsize',Font)
    xlabel('time (s)','fontsize',Font)
    ylabel('L','fontsize',Font)
    set(gca,'fontsize',Font)
    subplot(222)
    plot(t,VA,'linewidth',Width)
    title('alveolar volume','fontsize',Font)
    xlabel('time (s)','fontsize',Font)
    ylabel('L','fontsize',Font)
    set(gca,'fontsize',Font)
    axis([0 20 2.1 3.3])
    subplot(223)
    plot(t,VD,'linewidth',Width)
    title('dead volume','fontsize',Font)
    xlabel('time (s)','fontsize',Font)
    ylabel('L','fontsize',Font)
    set(gca,'fontsize',Font)

        
Alveolar_Vent = (max(VA(round(10/dt):end)) - min(VA(round(10/dt):end)))*60/T;
Vmin = VA  + VD;
Minute_Vent = (max(Vmin(round(10/dt):end)) - min(Vmin(round(10/dt):end)))*60/T;
disp(Alveolar_Vent)
disp(Minute_Vent)
<<<<<<<< HEAD:06_respiratory_spontaneous_breathing/respiratory_spontaneous_breathing.m


========
>>>>>>>> 7c2f5a5 (Merge respiratory modules into a single project):respiratory_mechanics_gas_exchange/spontaneous_breathing/Exercise6.m
