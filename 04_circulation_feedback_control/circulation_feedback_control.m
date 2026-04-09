clc
clear
close all

q0=5/60*1000;  %gittata cardiaca in ml/s
Psa0=100;
Psv0=5;
Pra0=4;
Kr0=q0/(Pra0 - 1.82);
Rsa0=(Psa0-Psv0)/q0;
Rsv=(Psv0-Pra0)/q0;
Csa=4;
Csv=111;
Cra=31;

DT = 0.1;
t=[0:DT:150];
L=length(t);
Volume_emor = 400;
Emor = Volume_emor/50;  % 50 seconds of hemhorrage 
Ii=[zeros(1,round(10/DT)) -Emor*ones(1,round(50/DT)) zeros(1,L -round(60/DT))];

Psa_no = zeros(1,L);
Psv_no = zeros(1,L);
Pra_no = zeros(1,L);

Psa = zeros(1,L);
Psv = zeros(1,L);
Pra = zeros(1,L);

%% Simulazione senza controllo
Psa_no(1)=Psa0*1.0;
Psv_no(1)=Psv0*1.0;
Pra_no(1)=Pra0;

for j = 1:L-1,

q_no(j) =  Kr0*(Pra_no(j) - 1.82);
dPsa = (q_no(j) -(Psa_no(j)-Psv_no(j))/Rsa0)/Csa;
dPsv = ((Psa_no(j) - Psv_no(j))/Rsa0 - (Psv_no(j)  - Pra_no(j))/Rsv +Ii(j))/Csv;
dPra = ((Psv_no(j)  - Pra_no(j))/Rsv - q_no(j))/Cra;
Psa_no(j+1) = Psa_no(j) +DT*dPsa;
Psv_no(j+1)= Psv_no(j) +DT*dPsv;
Pra_no(j+1) = Pra_no(j) + DT*dPra;
end
V_no = Csa*Psa_no+Csv*Psv_no+Cra*Pra_no;

%% Simulazione con controllore
Psa(1)=Psa0*1.0;
Psv(1)=Psv0*1.0;
Pra(1)=Pra0;
Rsa(1) = Rsa0;
Kr(1) = Kr0;
tauR = 15;
tauK = 5;
GR=Rsa0/Psa0*0.6;    %0.6
GK = Kr0/Psa0*15;    %15


for j = 1:L-1
q(j) =  Kr(j)*(Pra(j) - 1.82);
dPsa = (q(j) -(Psa(j)-Psv(j))/Rsa(j))/Csa;
dPsv = ((Psa(j) - Psv(j))/Rsa(j) - (Psv(j)  - Pra(j))/Rsv +Ii(j))/Csv;
dPra = ((Psv(j)  - Pra(j))/Rsv - q(j))/Cra;
DKr = -(Kr(j)-Kr0)-GK*(Psa(j)-Psa0);
DRsa = -(Rsa(j) - Rsa0) - GR*(Psa(j) - Psa0);
Psa(j+1) = Psa(j) +DT*dPsa;
Psv(j+1)= Psv(j) +DT*dPsv;
Pra(j+1) = Pra(j) + DT*dPra;
Rsa(j+1) = Rsa(j) + DT/tauR*DRsa;
Kr(j+1) = Kr(j) + DT/tauK*DKr;
end
V = Csa*Psa+Csv*Psv+Cra*Pra;

%% grafici
Width = 1.5;
Font = 18;
plot(t,Psa,'r',t,Psa_no,'b','linewidth',Width)
title('Systemic arterial pressure','fontsize',Font)
xlabel('time (s)','fontsize',Font)
ylabel('mmHg','fontsize', Font)
set(gca,'fontsize',Font)
figure
plot(t,Psv,'r',t,Psv_no,'b','linewidth',Width)
title('Systemic venous pressure','fontsize',Font)
xlabel('time (s)','fontsize',Font)
ylabel('mmHg','fontsize', Font)
set(gca,'fontsize',Font)
figure
plot(t,Pra,'r',t,Pra_no,'b','linewidth',Width)
title('Rigth atrial pressure','fontsize',Font)
xlabel('time (s)','fontsize',Font)
ylabel('mmHg','fontsize', Font)
set(gca,'fontsize',Font)
figure
plot(t(1:end-1),q,'r',t(1:end-1),q_no,'b','linewidth',Width)
title('Cardiac output','fontsize',Font)
xlabel('time (s)','fontsize',Font)
ylabel('ml/s','fontsize', Font)
set(gca,'fontsize',Font)
figure
plot(t(1:end),V,'r',t(1:end),V_no,'b','linewidth',Width)
title('Systemic filling volume','fontsize',Font)
xlabel('time (s)','fontsize',Font)
ylabel('ml','fontsize', Font)
set(gca,'fontsize',Font)
figure
plot(t(1:end),Rsa,'r',[t(1) t(end)],[Rsa0 Rsa0],'b','linewidth',Width)
title('Systemic arterial resistance','fontsize',Font)
xlabel('time (s)','fontsize',Font)
ylabel('mmHg/(ml/s)','fontsize', Font)
set(gca,'fontsize',Font)
figure
plot(t(1:end),Kr,'r',[t(1) t(end)],[Kr0 Kr0],'b','linewidth',Width)
title('Cardiac factor (k)','fontsize',Font)
xlabel('time (s)','fontsize',Font)
ylabel('ml/s/mmHg','fontsize', Font)
set(gca,'fontsize',Font)

