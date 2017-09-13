clear
clc

% converting the stress tensor to geographical coordinate system

a = 90;
b = 0;
c = 0;

R_pg = [cosd(a)*cosd(b) sind(a)*cosd(b) -sind(b);
  cosd(a)*sind(b)*sind(c)-sind(a)*cosd(c) sind(a)*sind(b)*sind(c)+cosd(a)*cosd(c) cosd(b)*sind(c);
  cosd(a)*sind(b)*cosd(c)+sind(a)*sind(c) sind(a)*sind(b)*sind(c)-cosd(a)sind(c) cosd(b)cosd(c)];
