<<<<<<<< HEAD:07_respiratory_assisted_controlled/respiratory_controlled_breathing.m
﻿ clear all
========
 clear all
>>>>>>>> 7c2f5a5 (Merge respiratory modules into a single project):respiratory_mechanics_gas_exchange/assisted_ventilation/Exercise7_II.m
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
dt = 0.0001;
t = [0:dt:20];
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
dVa = zeros(1,L);
dVd = zeros(1,L);
Vl = zeros(1,L);
Vt = zeros(1,L);
Vb = zeros(1,L);
VA = zeros(1,L);
VD = zeros(1,L);
Pa0=zeros(1,L);


P5(1) = -5;
P4(1) = (2.3 - VuA) /CA;


T=5;        
Amus = 2;
fi = 0.75*2*pi;
Pmus = (Amus*cos(2*pi/T*t+fi)-Amus)/2;
tauv = 2;
Vent_ref = 8.0;   %  8.0 l/min
dVref = Vent_ref*pi/60*sin(2*pi/T*t);  % computed to have the correct volume entering the alveoli
kcontrol = 22;   % try 0, 10, 30, 25, 22
    
for j = 1: L,
    Pl(j) = P1(j);
    Ppl(j) = P5(j) + Pmus(j);   %Pmus va calcolata fuori;
    Pt(j) = P2(j) + Ppl(j);
    Pb(j) = P3(j) + Ppl(j);
    PA(j) = P4(j) + Ppl(j);
%     dPa0 =  kcontrol*(dVref(j) - dV(j))/tauv; 
    dPa0 = (-Pa0(j) + kcontrol*(dVref(j) - dV(j)))/tauv;   %dVref va calcolata fuori;
    dV(j) = (Pa0(j)-Pl(j))/Rml;
    dVA(j) = (Pb(j) - PA(j))/RbA;
    dVd(j) = dV(j) - dVa(j);    % ventilazione nello spazio morto;
    Vl(j) = Cl*Pl(j) + Vul;
    Vt(j) = Ct*(Pt(j) - Ppl(j)) + Vut;
    Vb(j) = Cb*(Pb(j) - Ppl(j)) + Vub;
    VA(j) = CA*(PA(j) - Ppl(j)) + VuA;
    VD(j) = Vl(j) + Vt(j) + Vb(j);
    
    dP1 = 1/Cl* ( dV(j) - (Pl(j) - Pt(j))/Rlt );
    dP2 = 1/Ct* ( (Pl(j) - Pt(j))/Rlt - (Pt(j) - Pb(j))/Rtb );
    dP3 = 1/Cb* ( (Pt(j) - Pb(j))/Rtb - (Pb(j) - PA(j))/RbA );
    dP4 = 1/CA* (Pb(j) - PA(j))/RbA;
    dP5 = 1/Ccw* (Pl(j) - Pt(j))/Rlt;
    
    P1(j+1) = P1(j) + dP1*dt;
    P2(j+1) = P2(j) + dP2*dt;
    P3(j+1) = P3(j) + dP3*dt;
    P4(j+1) = P4(j) + dP4*dt;
    P5(j+1) = P5(j) + dP5*dt;
    Pa0(j+1) = Pa0(j)+dPa0*dt;
    
end

Width = 1.5;
Font = 18;

    figure(1)
    subplot(221)
    plot(t, Pmus,'b', t, Pa0(1:end-1),'r','linewidth',Width);
    title('muscle pressure (b) mouth pressure (r)','fontsize',Font)
    set(gca,'fontsize',Font)
    subplot(222)
    plot(t,Ppl,'linewidth',Width)
    title('pleural pressure','fontsize',Font)
    set(gca,'fontsize',Font)
    subplot(223)
    plot(t,PA,'linewidth',Width)
    title('alveolar pressure','fontsize',Font)
    xlabel('tempo (s)','fontsize',Font)
    set(gca,'fontsize',Font)
    subplot(224)
    plot(t(100:end),dVA(100:end),'linewidth',Width)
    title('minute ventilation','fontsize',Font)
    xlabel('tempo (s)','fontsize',Font)
    set(gca,'fontsize',Font)
    
    figure(2)
    plot(t,Pa0(1:end-1),'b',t,Pmus,'g','linewidth',Width)
    title('Pa0 (blu), Pmus (verde)','fontsize',Font)
    xlabel('tempo (s)','fontsize',Font)
    set(gca,'fontsize',Font)
    
    figure(3)
    plot(t,dVref,'b',t,dV,'g','linewidth',Width)
    title('dVref (blu), dV (verde)','fontsize',Font)
    xlabel('tempo (s)','fontsize',Font)
    set(gca,'fontsize',Font)
    
    figure(4)
    subplot(221)
    plot(t, VA+VD,'linewidth',Width);
    title('total volume','fontsize',Font)
    set(gca,'fontsize',Font)
    subplot(222)
    plot(t,VA,'linewidth',Width)
    title('alveolar volume','fontsize',Font)
    xlabel('tempo (s)','fontsize',Font)
    set(gca,'fontsize',Font)
    subplot(223)
    plot(t,VD,'linewidth',Width)
    title('dead volume','fontsize',Font)
    xlabel('tempo (s)','fontsize',Font)
    set(gca,'fontsize',Font)
    
 
    
<<<<<<<< HEAD:07_respiratory_assisted_controlled/respiratory_controlled_breathing.m
Vent = (max(VA(round(10/dt):end)) - min(VA(round(10/dt):end)))*60/T

========
Vent = (max(VA(round(10/dt):end)) - min(VA(round(10/dt):end)))*60/T
>>>>>>>> 7c2f5a5 (Merge respiratory modules into a single project):respiratory_mechanics_gas_exchange/assisted_ventilation/Exercise7_II.m
