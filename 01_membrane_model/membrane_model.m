% Simulation of a first order electrophysiological model of the cellular membrane
clc
clear all
close all
E0 = -65;  %mV
r = 10;  % MOhm
tau = 30; % ms
tfin = 200;  % ms
dt = 0.1; %integration step
t =  [0:dt:tfin];  % temporal vector
L = length(t); 
V0 = -50;  % initial state
i = 4;  % nA;
font = 16;
%%
% theoretical computation
Vinf = E0 + r*i; % mV
Vteor = (V0 - Vinf)*exp(-t/tau) + Vinf;
plot(t,Vteor,'r','linewidth',1.5)
xlabel('time (ms)')
ylabel('Voltage (mV)')
set(gca,'fontsize',font)
dt1 = .1;   % just to have the possbiklity to use another integration step
t1 =  [0:dt1:tfin];  % temporal vector
L1 = length(t1);
V = zeros(1,L1);   % memory allocation
V(1) = V0;
%%
% numerical computation with Euler method
for k = 1:L1-1
    dV = 1/tau*(-V(k)+ Vinf);
    V(k+1) = V(k) + dt1*dV;
end
hold on
plot(t1,V,'b--','linewidth',1.5)
legend('Theoretical','Numerical','Location','southeast')
%%
% Use of a sinusoidal input
tau=30;
tfin = 2000;  % ms
dt = 0.1; %integration step
t =  [0:dt:tfin];  % temporal vector
L = length(t); 
V = zeros(1,L);   % memory allocation
V0 = -50;  % initial state
V(1) = V0;
f = 10;  % Hz    % 5.3052 (cutting frequency)
T = 1/f*1000;  %(ms)
i = 4*cos(2*pi*t/T);
% numericlal computation with Euler method
for k = 1:L-1
    Vinf = E0 + r*i(k); % mV
    dV = 1/tau*(-V(k)+ Vinf);
    V(k+1) = V(k) + dt*dV;
end
figure(2)
hold on 
plot(t,V,'g','linewidth',1.5)







