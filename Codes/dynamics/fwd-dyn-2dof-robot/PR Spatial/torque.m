% ReDySim torque module. The control algorithm is entered here
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [tau_d, we, pe, ve] = torque(t,tf, dof, q,dq)

[y0, t_initial, t_final, incr, rtol, atol, eepi, ctrl_type]=initials();
global t_prev pa_prev

tau_d=zeros(dof,1);
we=zeros(dof,1); pe=zeros(dof,1); ve=zeros(dof,1); 
if ctrl_type==1
    % Free Simulation
    tau_d=zeros(dof,1);
    
elseif ctrl_type==2
    % Force Simultion: Set point control
    qd=[pi/2 0.3];
    dqd=[0; 0];
    kp=49;
    kd=14;
    tau_d(1)=kp*(qd(1)-q(1))+kd*(dqd(1)-dq(1));
    tau_d(2)=kp*(qd(2)-q(2))+kd*(dqd(2)-dq(2));
    
elseif ctrl_type==3
    % Force Simultion: tajectory following control
    [qd dqd ddqd]= trajectory(t, dof, tf);
    kp=49;
    kd=14;
    tau_d(1)=kp*(qd(1)-q(1))+kd*(dqd(1)-dq(1));
    tau_d(2)=kp*(qd(2)-q(2))+kd*(dqd(2)-dq(2));
    
elseif ctrl_type==4
    % Force Simultion: Stiffness control
    % tau_d=tau_p-tau_v-tau_e
    % tau_e
    J=jacobian(q);
    % Initial wall (environment) state
    pe=[0.35; 0];
    ve=[-0.05; 0];
    Ke = [9*10^5 0;
        0 0];
    pec = pe + ve*(t);
    Tc=fwd_kine(q);
    pc=[Tc(1,4); Tc(2,4)];
    if pc(1)>pec(1)
        we=Ke*(pc-pec);
    else
        we=[0; 0];
    end
    tau_e=J'*we;
    % tau_p
    Kpp=[50 0;
        0 1000];
    pd = eepi;
    Kfp=[0.01 0;
        0 0.01];
    pf=Kfp*we;
    delta_p=pd-pc-pf;
    tau_p=J'*Kpp*delta_p;
    % tau_v
    Kvq=[200 0;
        0 200];
    tau_v=Kvq*dq';
    % tau_d=tau_p-tau_v;
    tau_d=tau_p-tau_v-tau_e;
    
elseif ctrl_type==5
    % Force Simultion: Impedence control
    % tau_d=tau_pv-tau_v-tau_e
    % tau_e
    J=jacobian(q);
    % Initial wall (environment) state
    Ke = [9*10^5 0;
        0 0];
    pe=[0.35; 0];
    ae = [-0.2; 0];
    ve_max=[-0.2; 0];
    ve_min=[0; 0];
    ve = ve_min + (ve_max-ve_min)*t;
    pec = pe + ve*(t);
    pec = pe + 0.5*ae*t*t;
    Tc=fwd_kine(q);
    pc=[Tc(1,4); Tc(2,4)];
    if pc(1)>pec(1)
        we=Ke*(pc-pec);
    else
        we=[0; 0];
    end
    tau_e=J'*we;
    % tau_pv
    pd = eepi;
    Kfp=[0.01 0;
        0 0.01];
    pf=Kfp*we;
    delta_p=pd-pc-pf; % ee-position error
    ted=[0; 0];
    tec=J*dq';
    delta_te=ted-tec; % ee-orientation error
    Kpp=[300 0;
        0 0];
    Kvp=[100 0;
        0 100];
    tau_pv = J'*(Kpp*delta_p+Kvp*delta_te);
    % tau_v
    Kv=[200 0;
        0 200];
    tau_v=Kv*dq';
    % tau_d=tau_pv-tau_v;
    tau_d=tau_pv-tau_v-tau_e;
    
elseif ctrl_type==6
    % Force Simultion: Impedence control
    % tau_d=tau_a-tau_v-tau_e
    % tau_e
    J=jacobian(q);
    % Initial wall (environment) state
    Ke = [9*10^5 0;
        0 0];
    pe=[0.35; 0];
    ve=[-0.01; 0];
    pec = pe + ve*(t);
    Tc=fwd_kine(q);
    pc=[Tc(1,4); Tc(2,4)];
    if pc(1)>pec(1)
        we=Ke*(pc-pec);
    else
        we=[0; 0];
    end
    tau_e=J'*we;
    % tau_a
    pd=eepi;
    wd=[20; 0];
    A = [0.03 0;
        0 0];
    if t == 0
        pa_prev = [0; 0];
        t_prev=0;
    end
    dt = t-t_prev;
    pa = pa_prev + A*(wd-we)*dt;
    t_prev = t;
    pa_prev = pa;
    delta_x=pd+pa-pc;
    Kpa=[100 0;
        0 100];
    tau_a=Kpa*(inv(J))*delta_x;
    %tau_v
    Kv=[30 0;
        0 30];
    tau_v=Kv*dq';
    % tau_d=tau_pv-tau_v;
    tau_d=tau_a-tau_v-tau_e;
    
elseif ctrl_type==7
    % Force Simultion: Hybrid control
    % tau_d=tau_p+tau_f-tau_v-tau_e
    % tau_e
    J=jacobian(q);
    % Initial wall (environment) state
    Ke = [9*10^5 0;
        0 0];
    pe=[0.35; 0];
    ve=[-0.05; 0];
    pec = pe + ve*(t);
    Tc=fwd_kine(q);
    pc=[Tc(1,4); Tc(2,4)];
    if pc(1)>pec(1)
        we=Ke*(pc-pec);
    else
        we=[0; 0];
    end
    tau_e=J'*we;
    % tau_p & tau_f
    S = [0 0; 0 1];
    IS = eye(2)-S;
    pd=eepi;
    
    delta_p=S*(pd-pc);
    Kpp=[100 0;
        0 100];
    tau_p=Kpp*inv(J)*(delta_p);
    wd=[10; 0];
    delta_w=IS*(wd-we);
    Kpf=[100 0;
        0 100];
    tau_f=Kpf*J'*(delta_w);
    %tau_v
    Kv=[30 0;
        0 30];
    tau_v=Kv*dq';
    % tau_d=tau_pv-tau_v;
    tau_d=tau_p+tau_f-tau_v-tau_e;
end


