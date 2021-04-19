% ReDySim torque module. The control algorithm is entered here
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [tau_d] = torque(t,q,dq)

[y0, ti, tf, incr, rtol, atol, int_type] = initials();

tau_d=zeros(3,1);
ctrl_type=2;
if ctrl_type==1
    % Free Simulation
    tau_d=zeros(dof,1);
    
elseif ctrl_type==2
    % Force Simultion: Set point control
    qd=[0; 0; -0.5];
    dqd=[0; 0; 0];
    kp=49;
    kd=14;
%     tau_d(1)=kp*(qd(1)-q(1))+kd*(dqd(1)-dq(1));
%     tau_d(2)=kp*(qd(2)-q(2))+kd*(dqd(2)-dq(2));
    tau_d(3)=kp*(qd(3)-q(3))+kd*(dqd(3)-dq(3));

elseif ctrl_type==3
    % Force Simultion: tajectory following control
    [qd dqd ddqd]= trajectory(t, 3, tf);
    kp=49;
    kd=14;
    tau_d(1)=kp*(qd(1)-q(1))+kd*(dqd(1)-dq(1));
    tau_d(2)=kp*(qd(2)-q(2))+kd*(dqd(2)-dq(2));
end

