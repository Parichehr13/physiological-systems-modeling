clear all
close all
clc
gNamax = 120;
gKmax = 36;
gEq = 0.3;
ENa = 55;
EK = -77;
EEq = -54.4;
V0 = -65;
I = 15; %7.5                                                                                                                                                                                                                                                                          ; %5.4 un solo spike;  7.2: treno di spike periodico
C = 4;
dt = 0.01;
tmax = 100;  %ms
t = [0:dt:tmax];
L = length(t);
V = zeros(1,L);
m = zeros(1,L);
n = zeros(1,L);
h = zeros(1,L);
V(1) = V0;
alpha_m = 0.1*(-40-V(1))/( exp( (-40 - V(1)) /10 ) - 1 );
beta_m = 4*exp( (-V(1) - 65)/18 );
alpha_h = 0.07*exp( (-V(1) - 65)/20 );
beta_h = 1/( exp( (-V(1) - 35)/10 ) + 1);
alpha_n = 0.01*(-55-V(1))/( exp( (-55 - V(1)) /10 ) - 1 );
beta_n = 0.125*exp( (-V(1) - 65)/80 );

m(1) = alpha_m / (alpha_m + beta_m);
n(1) = alpha_n / (alpha_n + beta_n);
h(1) = alpha_h / (alpha_h + beta_h);

for i = 1: L-1
    dV = 1/C * ( -gKmax*n(i)^4 *(V(i) - EK) - gNamax*m(i)^3*h(i)*(V(i) -ENa) - gEq*(V(i) - EEq) + I);
    dm = alpha_m*(1 - m(i)) - beta_m*m(i);
    dn = alpha_n*(1 - n(i)) - beta_n*n(i);
    dh = alpha_h*(1 - h(i)) - beta_h*h(i);
    
    V(i+1) = V(i) + dV*dt;
    m(i+1) = m(i) + dm*dt;
    n(i+1) = n(i) + dn*dt;
    h(i+1) = h(i) + dh*dt;
    
    alpha_m = 0.1*(-40-V(i+1))/( exp( (-40 - V(i+1)) /10 ) - 1 );
    beta_m = 4*exp( (-V(i+1) - 65)/18 );
    alpha_h = 0.07*exp( (-V(i+1) - 65)/20 );
    beta_h = 1/( exp( (-V(i+1) - 35)/10 ) + 1);
    alpha_n = 0.01*(-55-V(i+1))/( exp( (-55 - V(i+1)) /10 ) - 1 );
    beta_n = 0.125*exp( (-V(i+1) - 65)/80 );
end

Width = 1.5;
Font = 18;

plot(t,V,'linewidth',Width)
title('Membrane potential','fontsize',Font)
xlabel('time (ms)','fontsize',Font)
ylabel('mV','fontsize',Font)
set(gca,'fontsize',Font)
figure
plot(t,m,'r',t,n,'b',t,h,'g','linewidth',Width)
title('m: red; n: blue; h: green','fontsize',Font)
xlabel('time (ms)','fontsize',Font)
set(gca,'fontsize',Font)
ylabel('dimensionless','fontsize',Font)
figure
plot(t,gKmax*n.^4,'g',t,gNamax*(m.^3).*h,'r','linewidth',Width)
title('red: sodium; green:potassium','fontsize',Font)
xlabel('time (ms)','fontsize',Font)
set(gca,'fontsize',Font)
ylabel('conductances','fontsize',Font)
