clc
clear
close all
q0=5/60*1000;  %gittata cardiaca in ml/s
Psa0=100;
Psv0=5;
Pra0=4;
Kr=q0/Pra0;
Rsa=(Psa0-Psv0)/q0;
Rsv=(Psv0-Pra0)/q0;
Csa=4;
Csv=111;
Cra=31;
DT=0.1;   %0.51
t=[0:DT:50];
L=length(t);
Ii=zeros(1,L);  %[-8*ones(1,L/2) zeros(1,L/2)];
Psa(1)=Psa0*1.5;
Psv(1)=Psv0;
Pra(1)=Pra0;

for j = 1:L-1,
V(j) = Csa*Psa(j)+Csv*Psv(j)+Cra*Pra(j);
q(j) =  Kr*(Pra(j));
dPsa = (q(j) -(Psa(j)-Psv(j))/Rsa)/Csa;
dPsv = ((Psa(j) - Psv(j))/Rsa - (Psv(j)  - Pra(j))/Rsv +Ii(j))/Csv;
dPra = ((Psv(j)  - Pra(j))/Rsv - q(j))/Cra;
Psa(j+1) = Psa(j) +DT*dPsa;
Psv(j+1)= Psv(j) +DT*dPsv;
Pra(j+1) = Pra(j) + DT*dPra;
end

Width = 1.5;
Font = 16;

plot(t,Psa,'g','linewidth',Width)
title('systemic arterial pressure','fontsize',Font)
xlabel('time (s)','fontsize',Font)
ylabel('mmHg','fontsize', Font)
figure
plot(t,Psv,'g','linewidth',Width)
title('Systemic Venous pressure','fontsize',Font)
xlabel('time (s)','fontsize',Font)
ylabel('mmHg','fontsize', Font)
set(gca,'fontsize',Font)
figure
plot(t,Pra,'g','linewidth',Width)
title('right atrial pressure','fontsize',Font)
xlabel('time (s)','fontsize',Font)
ylabel('mmHg','fontsize', Font)
figure
plot(t(1:end-1),q,'g','linewidth',Width)
title('cardiac output','fontsize',Font)
xlabel('time (s)','fontsize',Font)
ylabel('mmL/s','fontsize', Font)
figure
plot(t(1:end-1),V,'g','linewidth',Width)
xlabel('time (s)','fontsize',Font)
ylabel('mL','fontsize', Font)
title('fuilling volume','fontsize',Font)
%%%
A(1,1) = -1/Rsa/Csa;    
A(1,2)=1/Rsa/Csa;
A(1,3)= Kr/Csa;
A(2,1) = 1/Rsa/Csv;
A(2,2) = -1/Rsa/Csv-1/Rsv/Csv;
A(2,3) = 1/Rsv/Csv;
A(3,1) = 0;
A(3,2) = 1/Rsv/Cra;
A(3,3) = -1/Rsv/Cra-Kr/Cra;
X0=[Psa(1) Psv(1) Pra(1)]';

[V lambda]= eig(A);
lambda1 = lambda(1,1);
lambda2 = lambda(2,2);
lambda3 = lambda(3,3);
alpha = V\X0;

X=alpha(1)*V(:,1)*exp(lambda1*t)+alpha(2)*V(:,2)*exp(lambda2*t)+alpha(3)*V(:,3)*exp(lambda3*t);
figure(1)
hold on
plot(t,X(1,:),'r','linewidth',Width)
figure(2)
hold on
plot(t,X(2,:),'r','linewidth',Width)
figure(3)
hold on
plot(t,X(3,:),'r','linewidth',Width)
%%%
XX=zeros(3,L);
for j=1:L,
XX(:,j)=expm(A*t(j))*X0;
end
figure(1)
hold on
plot(t,XX(1,:),'b','linewidth',Width)
ll= legend('Euler','Eigenvectors','Exponential','Location','northeast');
set(ll,'fontsize',12)
figure(2)
hold on
plot(t,XX(2,:),'b','linewidth',Width)
ll= legend('Euler','Eigenvectors','Exponential','Location','southeast');
set(ll,'fontsize',12)
figure(3)
hold on
plot(t,XX(3,:),'b','linewidth',Width)
ll= legend('Euler','Eigenvectors','Exponential','Location','southeast');
set(ll,'fontsize',12)

