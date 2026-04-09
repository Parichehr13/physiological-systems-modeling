clear 
close all
clc
global sigma beta rho
sigma = 10;
beta = 8/3;
rho = 23.8; %[14 18 19 19.9 23.7 23.78 23.8  28];
X0 = [1 1 1];
[t, X]= ode45(@Lorenz,[0 200],X0);
plot3(X(101:end,1),X(101:end,2),X(101:end,3))
xlabel('x1','fontsize',18)
ylabel('x2','fontsize',18)
zlabel('x3','fontsize',18)
set(gca,'fontsize',14)
grid
figure
plot(X(101:end,1),X(101:end,2))
xlabel('x1','fontsize',18)
ylabel('x2','fontsize',18)
set(gca,'fontsize',14)
figure
plot(X(101:end,2),X(101:end,3))
xlabel('x2','fontsize',18)
ylabel('x3','fontsize',18)
set(gca,'fontsize',14)
figure
plot(X(101:end,1),X(101:end,3))
xlabel('x1','fontsize',18)
ylabel('x3','fontsize',18)
set(gca,'fontsize',14)

X0(1) = X0(1) + 1E-15;
[t1, X1]= ode45(@Lorenz,[0 200],X0);
figure
plot(t,X(:,1),'r',t1,X1(:,1),'b','linewidth',1)
xlabel('tempo (s)','fontsize',18)
ylabel('x1','fontsize',18)
set(gca,'fontsize',14)
%axis([0 80 0 50])
figure
plot3(X(101:end,1),X(101:end,2),X(101:end,3),'b')
hold
plot3(X1(101:end,1),X1(101:end,2),X1(101:end,3),'r')
xlabel('x1','fontsize',18)
ylabel('x2','fontsize',18)
zlabel('x3','fontsize',18)
set(gca,'fontsize',14)
grid


