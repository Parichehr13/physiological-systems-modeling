% program for the simulation of the cardiovascular systemic circulation without control
clc
clear
close all
q0=5/60*1000;  %gittata cardiaca in ml/s
Psa0=100;
Psv0=5;
Pra0=4;
Kr=q0/(Pra0 - 1.82);
Rsa=(Psa0-Psv0)/q0;
Rsv=(Psv0-Pra0)/q0;
Csa=4;
Csv=111;
Cra=31;
DT=0.1;

t=[0:DT:100];
L=length(t);
Volume_emor = 400;    %400
Emor = Volume_emor/50;  % 50 seconds of hemhorrage 
Ii=[zeros(1,round(10/DT)) -Emor*ones(1,round(50/DT)) zeros(1,L -round(60/DT))];
Psa = zeros(1,L);
Psv = zeros(1,L);
Pra = zeros(1,L);
Psa(1)=Psa0*1.0; % perturbation from 100mmHg to 150 
Psv(1)=Psv0*1.0;
Pra(1)=Pra0*1.0;

for j = 1:L-1
V(j) = Csa*Psa(j)+Csv*Psv(j)+Cra*Pra(j);
q(j) =  Kr*(Pra(j) - 1.82);
dPsa = (q(j) -(Psa(j)-Psv(j))/Rsa)/Csa;
dPsv = ((Psa(j) - Psv(j))/Rsa - (Psv(j)  - Pra(j))/Rsv +Ii(j))/Csv;
dPra = ((Psv(j)  - Pra(j))/Rsv - q(j))/Cra;
Psa(j+1) = Psa(j) +DT*dPsa;
Psv(j+1)= Psv(j) +DT*dPsv;
Pra(j+1) = Pra(j) + DT*dPra;

end

Font = 18;
Width=1.5;
figure
plot(t,Psa,'r','linewidth',Width)
title('Systemic arterial pressure','fontsize',Font)
xlabel('time (s)','fontsize',Font)
ylabel('mmHg','fontsize', Font)
set(gca,'fontsize',Font)
figure
plot(t,Psv,'b','linewidth',Width)
title('Systemic venous pressure','fontsize',Font)
xlabel('time (s)','fontsize',Font)
ylabel('mmHg','fontsize', Font)
set(gca,'fontsize',Font)
figure
plot(t,Pra,'g','linewidth',Width)
title('Right atrial pressure','fontsize',Font)
xlabel('time (s)','fontsize',Font)
ylabel('mmHg','fontsize', Font)
set(gca,'fontsize',Font)
figure
plot(t(1:end-1),q,'linewidth',Width)
title('Cardiac output','fontsize',Font)
xlabel('time (s)','fontsize',Font)
ylabel('ml/s','fontsize', Font)
set(gca,'fontsize',Font)
figure
plot(t(1:end-1),V,'linewidth',Width)
title('Systemic filling Volume','fontsize',Font)
xlabel('time (s)','fontsize',Font)
ylabel('ml','fontsize', Font)
set(gca,'fontsize',Font)


