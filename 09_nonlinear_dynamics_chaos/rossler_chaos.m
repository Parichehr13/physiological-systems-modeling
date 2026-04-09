

clear 
close all
clc
global a b c

b = 2;
c = 4;
a = 0.45;   %[0.1  0.18  0.37 0.377 0.45];
X0 = [1 1 1];
[t, X]= ode45(@Rossler,[0 2000],X0);
plot3(X(1001:end,1),X(1001:end,2),X(1001:end,3))
xlabel('x1','fontsize',18)
ylabel('x2','fontsize',18)
zlabel('x3','fontsize',18)
set(gca,'fontsize',14)
figure
plot(X(1001:end,1),X(1001:end,2))
xlabel('x1','fontsize',18)
ylabel('x2','fontsize',18)
set(gca,'fontsize',14)
figure
plot(X(1001:end,2),X(1001:end,3))
xlabel('x2','fontsize',18)
ylabel('x3','fontsize',18)
set(gca,'fontsize',14)
figure
plot(X(1001:end,1),X(1001:end,3))
xlabel('x1','fontsize',18)
ylabel('x3','fontsize',18)
set(gca,'fontsize',14)

X0(1) = X0(1) + 1E-12;
[t1, X1]= ode45(@Rossler,[0 2000],X0);
figure(5)
plot(t,X(:,3),'r',t1,X1(:,3),'b')

A = [0.37: 0.00333: 0.397];
figure
for k = 1:9
    a = A(k);
[t, X]= ode45(@Rossler,[0 1500],X0);
subplot(3,3,k)
plot(X(1001:end,2),X(1001:end,3))
xlabel('x2','fontsize',12)
ylabel('x3','fontsize',12)
set(gca,'fontsize',12)
end



