function [dof m1 m2 l1 a2 g b th a alp]=inputs()

%System: 2-link RP planar robot
%Number of links 
n=2;

%Degree of fredom of the system
dof=n;

m1 = 0.5; m2 = 0.5; %mass of links
% a1 = 0.079; l2 = 1; %length of links
l1 = 0.3; a2 = 0.3; %length of links
g = 9.81; %acceleration due to gravity

% DH PARAMETERs
b = [l1/2, 0];
th = [deg2rad(0), 0];
% th = [deg2rad(0), 0];
a = [0 a2];
alp=[pi/2 pi/2];




