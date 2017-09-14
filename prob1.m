clear
clc

%% prob 1
% converting the stress tensor to geographical coordinate system

a = 90;
b = 0;
c = 90;

R_pg = [cosd(a)*cosd(b) sind(a)*cosd(b) -sind(b);
  cosd(a)*sind(b)*sind(c)-sind(a)*cosd(c) sind(a)*sind(b)*sind(c)+cosd(a)*cosd(c) cosd(b)*sind(c);
  cosd(a)*sind(b)*cosd(c)+sind(a)*sind(c) sind(a)*sind(b)*sind(c)-cosd(a)*sind(c) cosd(b)*cosd(c)];

Sp = diag([78.9,66.6,64.3]);
Sg = R_pg'*Sp*R_pg;

%% using a uniform distribution
strike = rand(100,1) * 360;
dip = rand(100,1) * 90;