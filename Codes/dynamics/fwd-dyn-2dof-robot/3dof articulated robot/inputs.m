function [dof m1 m2 m3 l1 l2 l3 g b th a alp]=inputs()

%System: 3-link articulated robot
%Number of links 
n=3;

%Degree of fredom of the system
dof=n;

m1 = 0.5; m2 = 0.5; m3 = 0.5;%mass of links
% a1 = 0.079; l2 = 1; %length of links
l1 = 0.3; l2 = 0.3; l3 = 0.3;%length of links
g = 9.81; %acceleration due to gravity

% DH PARAMETERs
b = [l1, 0, 0];
th = deg2rad([0, 0, 0]);
% th = [deg2rad(0), 0];
a = [0 l2 l3];
alp=[pi/2 0 0];




