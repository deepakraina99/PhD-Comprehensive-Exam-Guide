% clear all;
% clc;
function dy = rigidscriptdualzero3(t,y)
%Trajectory
t
thin=[2.1572; 1.9687; 3.1416];%124 113 180
% thf=[1.6050; 2.2703; 1.5708]; %91.96 130.08 90 (Mid-Position)
thf=[1.7962; 2.6907; 0]; %102.92 154.17 0 (End-Position)
Tp=10;
for i=1:3
    thi(i,:)=thin(i)+((thf(i)-thin(i))/Tp)*(t-(Tp/(2*pi))*sin((2*pi/Tp)*t));
    dthi(i,:)=((thf(i)-thin(i))/Tp)*(1-cos((2*pi/Tp)*t));
    ddthi(i,:)=(2*pi*(thf(i)-thin(i))/(Tp*Tp))*sin((2*pi/Tp)*t);
end
th_d=thi;
dth_d=dthi;
ddth_d=ddthi;

m0=100; m1=10; m2=10; m3=10;
a0=0.895; a1=1.152; a2=1.152; a3=0.38;
d1x=a1/2; d2x=a2/2; d3x=a3/2;
I0z=83.61; I1z=1.05; I2z=1.05; I3z=1.05;

th1=y(1); th2=y(2); th3=y(3);
dth1=y(4); dth2=y(5); dth3=y(6);


% Row4
hm44 = m2*a1^2 + 2*m2*cos(th2)*a1*d2x + m1*d1x^2 + m2*d2x^2 + I1z + I2z;
hm45 = m2*d2x^2 + a1*m2*cos(th2)*d2x+ I2z;
hm46 = 0;

% Row5
hm54 = m2*d2x^2 + a1*m2*cos(th2)*d2x + I2z;
hm55 = m2*d2x^2 + I2z;
hm56 = 0;

% Row 6
hm64 = 0;
hm65 = 0;
hm66 = m3*d3x^2 + I3z;

% C Matrix
dph0=0; dx0=0; dy0=0; ph0=0;
cm4=-((a0*d2x*dph0*dth1*m2*sin(th1 + th2))/2 + (a0*d2x*dph0*dth2*m2*sin(th1 + th2))/2 + (a0*a1*dph0*dth1*m2*sin(th1))/2 - (a0*d1x*dph0*dth1*m1*sin(th1))/2 + a1*d2x*dth2^2*m2*sin(th2) + 2*a1*d2x*dph0*dth2*m2*sin(th2) + 2*a1*d2x*dth1*dth2*m2*sin(th2) + d1x*m1*dx0*dph0*cos(ph0+th1) + d1x*m1*dx0*dth1*cos(ph0+th1) + d1x*m1*dy0*dph0*sin(ph0+th1) + d1x*m1*dy0*dth1*sin(ph0+th1) + 2*d1x*m2*dx0*dph0*cos(ph0+th1) + 2*d1x*m2*dx0*dth1*cos(ph0+th1) + d2x*m2*dx0*dph0*cos(ph0+th1+th2)+ d2x*m2*dx0*dth1*cos(ph0+th1+th2)+ d2x*m2*dx0*dth2*cos(ph0+th1+th2) + 2*d1x*m2*dy0*dph0*sin(ph0+th1) + 2*d1x*m2*dy0*dth1*sin(ph0+th1) + d2x*m2*dy0*dph0*sin(ph0+th1+th2)+ d2x*m2*dy0*dth1*sin(ph0+th1+th2)+ d2x*m2*dy0*dth2*sin(ph0+th1+th2));
cm5=-(a1*d2x*m2*dph0*dth2*sin(th2) + a1*d2x*m2*dth1*dth2*sin(th2) + (a0*d2x*m2*dph0*dth1*sin(th1+th2))/2 + (a0*d2x*m2*dph0*dth2*sin(th1+th2))/2 + (a0*d2x*m2*dth1^2*sin(th1+th2))/2 + (a0*d2x*m2*dth1*dth2*sin(th1+th2))/2 + d2x*m2*dx0*dph0*cos(ph0+th1+th2) + d2x*m2*dx0*dth1*cos(ph0+th1+th2) + d2x*m2*dx0*dth2*cos(ph0+th1+th2) + d2x*m2*dy0*dph0*sin(ph0+th1+th2) + d2x*m2*dy0*dth1*sin(ph0+th1+th2) + d2x*m2*dy0*dth2*sin(ph0+th1+th2));
cm6= (a0*d3x*dph0^2*m3*sin(th3))/2 + (d3x*m3*dx0*dph0*cos(ph0+th3) + d3x*m3*dx0*dth3*cos(ph0+th3) + (d3x*m3*dy0*dph0*sin(ph0+th3))/2 + (d3x*m3*dy0*dth3*sin(ph0+th3))/2);


%GIM

Im = [hm44 hm45 hm46
    hm54 hm55 hm56
    hm64 hm65 hm66];

Cm=[cm4
    cm5
    cm6];

% Type=1 for closed loop and =0 for open loop
type=0;

if type==0 %Closed
    % PD Control
    kp=49; kd=14;
    % tau1=kp*(th_d(1)-th1)+kd*(dth_d(1)-dth1);
    % tau2=kp*(th_d(2)-th2)+kd*(dth_d(2)-dth2);
    tau3=kp*(th_d(3)-th3)+kd*(dth_d(3)-dth3);
    tau1=0;
    tau2=0;
    % tau3=0;
    Fm=[tau1
        tau2
        tau3];
    
    %Closed Loop Dynamics
    phi=Fm-Cm;
    % phi=Fm-cm;
    % q=[x0; y0; ph0]; dq=[dx0; dy0; dph0];
    th=[th1; th2; th3]; dth=[dth1; dth2; dth3];
    [J, J1, J2, dJ]=jacobian3(th,dth);
    % dqt=[dq; dth];
    Jt=transpose(J);
    
    % lambda Expression
    % IJ=inv(I)*Jt;
    % lamphi=(dJ*dqt+J*(inv(I))*phi);
    % lamI=J*IJ;
    % lam=-inv(lamI)*lamphi;
    lam=(-inv(J*(inv(Im)*Jt)))*(J*(inv(Im))*phi + dJ*dth);
    
    %Matrix Form
    % O=zeros(2,2);
    % A=[Im Jt
    %    J O];
    % B=[phi
    %    (-dJ)*dqt];
    % temp=inv(A)*B;
    
    %External Force Value
    % lam=[-2; 0];
    % Fe=[Fe1; Fe2];
    phi= phi+J'*lam;
    
elseif type==1 %Open
    % Forces
    kp=49; kd=14;
    tau1=kp*(th_d(1)-th1)+kd*(dth_d(1)-dth1);
    tau2=kp*(th_d(2)-th2)+kd*(dth_d(2)-dth2);
    tau3=kp*(th_d(3)-th3)+kd*(dth_d(3)-dth3);
    
    Fm=[tau1
        tau2
        tau3];
    
    phi=Fm-Cm;
end
temp=(inv(Im))*(phi);
%DAE
% temp=(inv(Hb))*(-cb - Hbm*ddph);
% temp = (inv(I))*((F)-(C) + J'*lam); %Closed
% temp = (inv(I))*((F)-(C) + J1'*lam ); %Force on End-Effector 1
% temp = (inv(I))*((F)-(C) + J2'*(-lam) ); %Force on End-Effector 2
% temp = (inv(I))*((F)-(C) + J'*lam); %Force on Both End-Effector (Way 1)
% temp = (inv(I))*((F)-(C) + (J1'-J2')*lam); %Force on both End-Effector (Way 2)
% temp = (inv(Im))*((Fm)-(Cm));
% torque = Hbm'*temp + Hm*ddph + cm;
%
dy=zeros(6,1);

dy(1)=dth1;
dy(2)=dth2;
dy(3)=dth3;
dy(4)=temp(1);
dy(5)=temp(2);
dy(6)=temp(3);


