function [y0, t_initial, t_final, incr, rtol, atol, eepi, ctrl_type]=initials()

%Simulation time
t_initial=0;
t_final=3;
incr=0.01;  %Sampling time for adaptive solver and step size for fixed step solver

[dof m1 m2 a1 l2 g b th a alp]=inputs();

%Double link pendulum
% th1=deg2rad(-32); b2=0.5; % stiffness
% th1=deg2rad(-30); b2=0.5; % impedence
th1=deg2rad(0); b2=0.15; % impedence

% th1=deg2rad(0); b2=0.15;
dth1=0; db2=0;

%Vecotor of all the initial State Variable
y0=[th1 dth1 b2 db2];

%ITERATION TOLERANCES
rtol=1e-4;         %relative tolerance in integration 
atol=1e-6;         %absolute tolerances in integration
 
%Initial end-effector position
Ti=fwd_kine([th1, b2]);
eepi=[Ti(1,4); Ti(2,4)];

% controller-type
% 1: Free simulation
% 2: set-point control
% 3: trajectory following control
% 4: stiffness contrl
% 5: impedence control
% 6: stiffness contrl
% 7: impedence control
ctrl_type = 3;

