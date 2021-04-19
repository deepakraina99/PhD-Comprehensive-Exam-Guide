% ReDySim torque module. The control algorithm is entered here
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [tau_d] = torque(t,tf, n, dof, q,dq)

% Free Simulation
tau_d=zeros(n,1);

%Force Simultion: Set point control
qd=[pi/2 0.3];
dqd=[0; 0];
kp=49;
kd=14;
tau_d(1)=kp*(qd(1)-q(1))+kd*(dqd(1)-dq(1));
tau_d(2)=kp*(qd(2)-q(2))+kd*(dqd(2)-dq(2));

% %Force Simultion:ajectory following control
% [qd dqd ddqd]= trajectory(t, dof, tf);
% kp=49;
% kd=14;
% tau_d(1)=kp*(qd(1)-q(1))+kd*(dqd(1)-dq(1));
% tau_d(2)=kp*(qd(2)-q(2))+kd*(dqd(2)-dq(2));


end

