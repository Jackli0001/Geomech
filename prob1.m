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
nn = [-sind(strike)*sind(dip);cosd(strike)*sind(dip);-cosd(dip)];
t = Sg * nn;

for i = 1:n
	sigma_n(i) = t(:,i)'* nn(:,i);
	tau(i) = sqrt(t(:,i)'*t(:,i)-sigma_n(i)^2);
end

x1_sample = linspace(sigma_h,sigma_H,100);
x2_sample = linspace(sigma_v,sigma_H,100);
x3_sample = linspace(sigma_h,sigma_v,100);
x1_center = (sigma_h+sigma_H)/2;
x2_center = (sigma_v+sigma_H)/2;
x3_center = (sigma_v+sigma_h)/2;
r1 = (sigma_H-sigma_h)/2;
r2 = (sigma_H-sigma_v)/2;
r3 = (sigma_v-sigma_h)/2;
y1 = sqrt(r1^2-x1_sample.^2);
y2 = sqrt(r2^2-x2_sample.^2);
y3 = sqrt(r3^2-x3_sample.^2);

figure(1)
hold on; box on; grid on
plot(x1_sample,y1)
plot(x2_sample,y2)
plot(x3_sample,y3)
plot(sigma_n,tau,'.','MarkerSize',5)
xlim([0 30])




