clear
clc

%% prob 1
% converting the stress tensor to geographical coordinate system

Pp = 55.7;
SHmax = 78.9;
Sv = 66.6;
Shmin = 64.3;

sigma_H = SHmax-Pp;
sigma_h = Shmin-Pp;
sigma_v = Sv-Pp;

a = 90;
b = 0;
c = 90;


R_pg = [cosd(a)*cosd(b) sind(a)*cosd(b) -sind(b);
  cosd(a)*sind(b)*sind(c)-sind(a)*cosd(c) sind(a)*sind(b)*sind(c)+cosd(a)*cosd(c) cosd(b)*sind(c);
  cosd(a)*sind(b)*cosd(c)+sind(a)*sind(c) sind(a)*sind(b)*sind(c)-cosd(a)*sind(c) cosd(b)*cosd(c)];

Sp = diag([SHmax,Sv,Shmin]);
Sg = R_pg'*Sp*R_pg;

%% prob 2 using a uniform distribution
rng(1)
n = 100;
strike = rand(1,n) * 360;
dip = rand(1,n) * 90;
nn = [-sind(strike).*sind(dip);cosd(strike).*sind(dip);-cosd(dip)];
t = (Sg-Pp*eye(3)) * nn;

for i = 1:n
	sigma_n(i) = t(:,i)'* nn(:,i);
	tau(i) = sqrt(t(:,i)'*t(:,i)-sigma_n(i)^2);
end

%% mohr circle
x1_sample = linspace(sigma_h,sigma_H,100);
x2_sample = linspace(sigma_v,sigma_H,100);
x3_sample = linspace(sigma_h,sigma_v,100);
x1_center = (sigma_h+sigma_H)/2;
x2_center = (sigma_v+sigma_H)/2;
x3_center = (sigma_v+sigma_h)/2;
r1 = (sigma_H-sigma_h)/2;
r2 = (sigma_H-sigma_v)/2;
r3 = (sigma_v-sigma_h)/2;
y1 = sqrt(r1^2-(x1_sample-x1_center).^2);
y2 = sqrt(r2^2-(x2_sample-x2_center).^2);
y3 = sqrt(r3^2-(x3_sample-x3_center).^2);


%% prob 3
mu1 = 0.5;
mu2 = 0.7;

xx_sample = linspace(0,25,100);
yy_sample1 = mu1*xx_sample;
yy_sample2 = mu2*xx_sample;



%% prob 4
rng(1)
n = 10;
strike1 = random('Normal',60,5,1,10);
dip1 = random('Normal',80,5,1,10);
nn = [-sind(strike1).*sind(dip1);cosd(strike1).*sind(dip1);-cosd(dip1)];
t = (Sg-Pp*eye(3)) * nn;

for i = 1:n
	sigma_n1(i) = t(:,i)'* nn(:,i);
	tau1(i) = sqrt(t(:,i)'*t(:,i)-sigma_n1(i)^2);
end

strike2 = random('Normal',10,5,1,10);
dip2 = random('Normal',80,5,1,10);
nn = [-sind(strike2).*sind(dip2);cosd(strike2).*sind(dip2);-cosd(dip2)];
t = (Sg-Pp*eye(3)) * nn;

for i = 1:n
	sigma_n2(i) = t(:,i)'* nn(:,i);
	tau2(i) = sqrt(t(:,i)'*t(:,i)-sigma_n2(i)^2);
end

%% plot
figure(1)
hold on; box on; grid on
axis equal
plot(x1_sample,y1)
plot(x2_sample,y2)
plot(x3_sample,y3)
plot(xx_sample,yy_sample1)
plot(xx_sample,yy_sample2)
plot(sigma_n,tau,'x','MarkerSize',5)
xlim([0 25])
ylim([0 25])
legend({'\sigma_{Hmax} and \sigma_{hmin}','\sigma_{Hmax} and \sigma_{v}','\sigma_{v} and \sigma_{hmin}',...
    '\mu = 0.5','\mu = 0.7','\sigma_n and \tau'},'fontsize',18)


figure(2)
hold on; box on; grid on
axis equal
plot(x1_sample,y1)
plot(x2_sample,y2)
plot(x3_sample,y3)
plot(xx_sample,yy_sample1)
plot(xx_sample,yy_sample2)
plot(sigma_n1,tau1,'x','MarkerSize',5)
plot(sigma_n2,tau2,'x','MarkerSize',5)
xlim([0 25])
ylim([0 25])
legend({'\sigma_{Hmax} and \sigma_{hmin}','\sigma_{Hmax} and \sigma_{v}','\sigma_{v} and \sigma_{hmin}',...
    '\mu = 0.5','\mu = 0.7','Fracture Set 1','Fracture Set 2'},'fontsize',18)