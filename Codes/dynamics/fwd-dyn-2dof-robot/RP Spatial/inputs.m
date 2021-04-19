function [dof m1 m2 a1 l2 g b th a alp]=inputs()

%System: 2-link RP planar robot
%Number of links 
n=2;

%Degree of fredom of the system
dof=n;

m1 = 0.5; m2 = 0.5; %mass of links
% a1 = 0.079; l2 = 1; %length of links
a1 = 0.3; l2 = 0.3; %length of links
g = 9.81; %acceleration due to gravity

% DH PARAMETERs
b = [0, l2/2];
th = [deg2rad(0), 0];
% th = [deg2rad(0), 0];
a = [a1 0];
alp=[0 -pi/2];




