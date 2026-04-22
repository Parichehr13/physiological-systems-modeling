% clc
clear all
% close all
ki_Na = 1.5;
ke_Na = 0.02*ki_Na;
u_Na = 0.107;
cNa_d = 140;

ki_U = 0.77;
ke_U = 1*ki_U;
u_U = 0.075;
cU_d = 0;

ki_K = 1.5;
ke_K = 28.2*ki_K;
u_K = 0.045;
cK_d = 2;

d = 0.241;
qf = 2/240;
Ii = 0;  % immagino non beva durante la dialisi
Vt = 0.58*70+2;   % immagino che pesi 2 Kg in più a inizio dialisi

% metodo di Eulero 
dt = 0.1;  %minuti
t = (0:dt:4*60);
L = length(t);

Mi_Na = zeros(1,L);
Me_Na = zeros(1,L);
Mi_U = zeros(1,L);
Me_U = zeros(1,L);
Mi_K = zeros(1,L);
Me_K = zeros(1,L);
ci_Na = zeros(1,L);
ce_Na = zeros(1,L);
ci_U = zeros(1,L);
ce_U = zeros(1,L);
ci_K = zeros(1,L);
ce_K = zeros(1,L);
Vi = zeros(1,L);
Ve = zeros(1,L);
osmi = zeros(1,L);
osme = zeros(1,L);

% stato iniziale
Vi(1) = 5*Vt/8;
Ve(1) = 3*Vt/8;

ce_Na(1) = 148;
ci_Na(1) = ce_Na(1)*0.02+u_Na/ki_Na;
Mi_Na(1) = ci_Na(1)*Vi(1);
Me_Na(1) = ce_Na(1)*Ve(1);

ci_U(1) = 20;
ce_U(1) = ci_U(1);
Mi_U(1) = ci_U(1)*Vi(1);
Me_U(1) = ce_U(1)*Ve(1);


ce_K(1) = 4.5;
ci_K(1) = ce_K(1)*28.2+u_K/ki_K;
Mi_K(1) = ci_K(1)*Vi(1);
Me_K(1) = ce_K(1)*Ve(1);

Vi(1) = 5*Vt/8;
Ve(1) = 3*Vt/8;

osm0= 308;  % immagino una osmolatità alta a inizio dialisi
kf = 0.1;
ceqi = (osm0 - 0.93*(ci_Na(1) + ci_K(1) + ci_U(1))) /0.93;
ceqe = (osm0 - 0.93*(ce_Na(1) + ce_K(1) + ce_U(1))) /0.93;
osmi(1) = 0.93*(ci_Na(1) + ci_K(1) + ci_U(1) + ceqi);
osme(1) = 0.93*(ce_Na(1) + ce_K(1) + ce_U(1) + ceqe);


for j = 1:L-1
    dVi = kf*(osmi(j) - osme(j));
    dVe = Ii- qf - kf*(osmi(j) - osme(j));
    Vi(j+1)= Vi(j) + dt*dVi;
    Ve(j+1)= Ve(j) + dt*dVe;
    
    dMi_Na = - ki_Na*Mi_Na(j)/Vi(j) + ke_Na*Me_Na(j)/Ve(j) +u_Na;
    dMe_Na =   ki_Na*Mi_Na(j)/Vi(j) - ke_Na*Me_Na(j)/Ve(j) -d*(Me_Na(j)/Ve(j) -cNa_d)-qf*ce_Na(j);
    Mi_Na(j+1) = Mi_Na(j) + dt*dMi_Na;
    Me_Na(j+1) = Me_Na(j) + dt*dMe_Na;
    ci_Na(j+1) = Mi_Na(j+1)/Vi(j+1);
    ce_Na(j+1) = Me_Na(j+1)/Ve(j+1);
    
    dMi_U = - ki_U*Mi_U(j)/Vi(j) + ke_U*Me_U(j)/Ve(j) +u_U;
    dMe_U =   ki_U*Mi_U(j)/Vi(j) - ke_U*Me_U(j)/Ve(j) -d*(Me_U(j)/Ve(j) -cU_d)-qf*ce_U(j);
    Mi_U(j+1) = Mi_U(j) + dt*dMi_U;
    Me_U(j+1) = Me_U(j) + dt*dMe_U;
    ci_U(j+1) = Mi_U(j+1)/Vi(j+1);
    ce_U(j+1) = Me_U(j+1)/Ve(j+1);
    
    dMi_K = - ki_K*Mi_K(j)/Vi (j)+ ke_K*Me_K(j)/Ve(j) +u_K;
    dMe_K =   ki_K*Mi_K(j)/Vi(j) - ke_K*Me_K(j)/Ve(j) -d*(Me_K(j)/Ve(j) -cK_d)-qf*ce_K(j);
    Mi_K(j+1) = Mi_K(j) + dt*dMi_K;
    Me_K(j+1) = Me_K(j) + dt*dMe_K;
    ci_K(j+1) = Mi_K(j+1)/Vi(j+1);
    ce_K(j+1) = Me_K(j+1)/Ve(j+1);
    
    osmi(j+1) = 0.93*(ci_Na(j+1) + ci_K(j+1) + ci_U(j+1) + ceqi);
    osme(j+1) = 0.93*(ce_Na(j+1) + ce_K(j+1) + ce_U(j+1) + ceqe);
end

Width = 1.5;
Font = 18;


figure
subplot(221)
plot(t/60,ci_Na,'b','linewidth',Width)
title('intracellular sodium','fontsize',Font)
xlabel('tempo (ore)','fontsize',Font)
set(gca,'fontsize',Font)
axis tight
subplot(222)
plot(t/60,ce_Na,'r','linewidth',Width)
title('extracellular sodium','fontsize',Font)
xlabel('time (hours)','fontsize',Font)
set(gca,'fontsize',Font)
axis tight

figure
subplot(221)
plot(t/60,ci_U,'b','linewidth',Width)
title('intracellular urea','fontsize',Font)
xlabel('time hours)','fontsize',Font)
set(gca,'fontsize',Font)
axis tight
subplot(222)
plot(t/60,ce_U,'r','linewidth',Width)
title('extracellular urea','fontsize',Font)
xlabel('time (hours)','fontsize',Font)
set(gca,'fontsize',Font)
axis tight

figure
subplot(221)
plot(t/60/24,ci_K,'b','linewidth',Width)
title('intracellular potassium','fontsize',Font)
xlabel('time (hours)','fontsize',Font)
set(gca,'fontsize',Font)
axis tight
subplot(222)
plot(t/60/24,ce_K,'r','linewidth',Width)
title('extracellular potassium','fontsize',Font)
xlabel('time (hours)','fontsize',Font)
set(gca,'fontsize',Font)
axis tight

figure
plot(t/60,Vi,'b',t/60,Ve,'r','linewidth',Width)
title('volumes','fontsize',Font)
xlabel('time (hours)','fontsize',Font)
set(gca,'fontsize',Font)
axis tight


figure
plot(t/60,osmi,'b',t/60,osme,'r','linewidth',Width)
title('osmolarities','fontsize',Font)
xlabel('time (hours)','fontsize',Font)
set(gca,'fontsize',Font)
axis tight

    

