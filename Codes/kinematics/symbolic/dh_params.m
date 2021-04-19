function [joint, b, th, a, alpha] = dh_params(robo_type)

syms th1 th2 th3 th4 th5 th6
syms b1 b2 b3 b4 b5 b6
syms a1 a2 a3 a4 a5 a6

if robo_type == 11
    % 3-link RRR planar manipulator
    disp('RRR robot')
    joint=[1 1];  
    th=[th1 th2];
    b=[0 0 0];
    alpha=[0 0 0];
    a=[a1 a2];
elseif robo_type == 1
    % 3-link RRR planar manipulator
    disp('RRR robot')
    joint=[1 1 1];  
    th=[th1 th2 th3];
    b=[0 0 0];
    alpha=[0 0 0];
    a=[a1 a2 a3];
elseif robo_type == 2
    % 2-link RP planar manipulator
    disp('RP robot')
    joint=[1 0];
    th=[th1 0];
    b=[0 b2];
    alpha=[-pi/2  pi/2];
    a=[a1 0]; 
elseif robo_type == 3
    % 2-link PR planar manipulator
    disp('PR robot')
    joint=[0 1];
%     th=[-pi/2 th2];
    th=[0 th2]; % in force control
    b=[b1 0];
    alpha=[pi/2  0];
    a=[0 a2];
elseif robo_type == 4
    % 3-link articulated spatial manipulator
    disp('3-link articulated spatial manipulator')
    joint=[1 1 1];
%     th=[-pi/2 th2];
    th=[th1 th2 th3]; % in force control
    b=[b1 0 0];
    alpha=[pi/2  0 0];
    a=[0 a2 a3];  
elseif robo_type == 5
    % SCARA Manipulator
    disp('SCARA robot')
    joint=[1 1 0 1];
    th=[th1 th2 0 th4];
    b=[0 0 b3 b4];
    alpha=[0 pi 0 0];
    a=[a1 a2 0 0];
    
elseif robo_type == 6
    % UR5 robot
    disp('UR5 robot')
    % a2=-0.4250; a3=-0.3922;
    % b1=0.1625; b4=0.1333; b5=0.0997; b6=0.0966;
    joint=[1 1 1 1 1 1];
    th=[th1 th2 th3 th4 th5 th6];
    a=[0 a2 a3 0 0 0];
    b=[b1 0 0 b4 b5 b6];
    alpha=[pi/2 0 0 pi/2 -pi/2 0];
    % th=deg2rad([-89.77,-110.88,-95.18,-65.16,-270.55,-0.70]);
    % th=deg2rad([0,0,0,0,0,0]);
end