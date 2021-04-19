% clear all;
% clc;
function dy = rigidscriptdualzero(t,y)
type=1;
%Trajectory
t
thin=[2.1572; 1.9687; 3.1416];%124 113 180
% thf=[1.6050; 2.2703; 1.5708]; %91.96 130.08 90 (Mid-Position)
thf=[1.7962; 2.6907; 0]; %102.92 154.17 0 (End-Position)
Tp=10;
for type=1:3
    thi(type,:)=thin(type)+((thf(type)-thin(type))/Tp)*(t-(Tp/(2*pi))*sin((2*pi/Tp)*t));
    dthi(type,:)=((thf(type)-thin(type))/Tp)*(1-cos((2*pi/Tp)*t));
    ddthi(type,:)=(2*pi*(thf(type)-thin(type))/(Tp*Tp))*sin((2*pi/Tp)*t);
end
th_d=thi;
dth_d=dthi;
ddth_d=ddthi;

m0=100; m1=10; m2=10; m3=10;
a0=0.895; a1=1.152; a2=1.152; a3=0.38;
d1x=a1/2; d2x=a2/2; d3x=a3/2;
I0z=83.61; I1z=1.05; I2z=1.05; I3z=1.05;

x0=y(1); y0=y(2); ph0=y(3); th1=y(4); th2=y(5); th3=y(6);
dx0=y(7); dy0=y(8); dph0=y(9); dth1=y(10); dth2=y(11); dth3=y(12);

% GIM
%Row1
hb11 = m0 + m1 + m2 + m3;
hb12 = 0;
hb13 =  - (a0*m1*sin(ph0))/2 - (a0*m2*sin(ph0))/2 - d2x*m2*sin(ph0 + th1 + th2) - a1*m2*sin(ph0 + th1) - d1x*m1*sin(ph0 + th1) + ((a0*m3*sin(ph0))/2 + d3x*m3*sin(ph0 + th3));

hbm14 = - d2x*m2*sin(ph0 + th1 + th2) - a1*m2*sin(ph0 + th1) - d1x*m1*sin(ph0 + th1);
hbm15 = - d2x*m2*sin(ph0 + th1 + th2);
hbm16 =   d3x*m3*sin(ph0 + th3);

%Row2
hb21 = 0;
hb22 = m0 + m1 + m2 + m3;
hb23 = (a0*m1*cos(ph0))/2 + (a0*m2*cos(ph0))/2 + d2x*m2*cos(ph0 + th1 + th2) + a1*m2*cos(ph0 + th1) + d1x*m1*cos(ph0 + th1) - ((a0*m3*cos(ph0))/2 + d3x*m3*cos(ph0 + th3)) ;

hbm24 = d2x*m2*cos(ph0 + th1 + th2) + a1*m2*cos(ph0 + th1) + d1x*m1*cos(ph0 + th1);
hbm25 = d2x*m2*cos(ph0 + th1 + th2);
hbm26 = -d3x*m3*cos(ph0 + th3);

%Row3
hb31 = -(a0*m1*sin(ph0))/2 - (a0*m2*sin(ph0))/2 - d2x*m2*sin(ph0 + th1 + th2) - a1*m2*sin(ph0 + th1) - d1x*m1*sin(ph0 + th1) + ((a0*m3*sin(ph0))/2 + d3x*m3*sin(ph0 + th3));
hb32 =  (a0*m1*cos(ph0))/2 + (a0*m2*cos(ph0))/2 + d2x*m2*cos(ph0 + th1 + th2) + a1*m2*cos(ph0 + th1) + d1x*m1*cos(ph0 + th1) - ((a0*m3*cos(ph0))/2 + d3x*m3*cos(ph0 + th3));
hb33 = I0z + I1z + I2z + (a0^2*m1)/4 + (a0^2*m2)/4 + a1^2*m2 + d1x^2*m1 + d2x^2*m2 + a0*d2x*m2*cos(th1 + th2) + a0*a1*m2*cos(th1) + a0*d1x*m1*cos(th1) + 2*a1*d2x*m2*cos(th2) + (I3z + d3x^2*m3 + a0*d3x*m3*cos(th3));

hbm34 = m2*a1^2 + 2*m2*cos(th2)*a1*d2x + (a0*m2*cos(th1)*a1)/2 + m1*d1x^2 + (a0*m1*cos(th1)*d1x)/2 + m2*d2x^2 + (a0*m2*cos(th1 + th2)*d2x)/2 + I1z + I2z;
hbm35 = I2z + d2x^2*m2 + (a0*d2x*m2*cos(th1 + th2))/2 + a1*d2x*m2*cos(th2);
hbm36 = m3*d3x^2 + (a0*m3*cos(th3)*d3x)/2 +  I3z;

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
cb1=-(d2x*dph0^2*m2*cos(ph0 + th1 + th2) + d2x*dth1^2*m2*cos(ph0 + th1 + th2) + d2x*dth2^2*m2*cos(ph0 + th1 + th2) + a1*dph0^2*m2*cos(ph0 + th1) + a1*dth1^2*m2*cos(ph0 + th1) + d1x*dph0^2*m1*cos(ph0 + th1) + d1x*dth1^2*m1*cos(ph0 + th1) + (a0*dph0^2*m1*cos(ph0))/2 + (a0*dph0^2*m2*cos(ph0))/2 + 2*d2x*dph0*dth1*m2*cos(ph0 + th1 + th2) + 2*d2x*dph0*dth2*m2*cos(ph0 + th1 + th2) + 2*d2x*dth1*dth2*m2*cos(ph0 + th1 + th2) + 2*a1*dph0*dth1*m2*cos(ph0 + th1) + 2*d1x*dph0*dth1*m1*cos(ph0 + th1)) + (d3x*dph0^2*m3*cos(ph0 + th3) + d3x*dth3^2*m3*cos(ph0 + th3) + (a0*dph0^2*m3*cos(ph0))/2 + 2*d3x*dph0*dth3*m3*cos(ph0 + th3));
cb2=-(d2x*dph0^2*m2*sin(ph0 + th1 + th2) + d2x*dth1^2*m2*sin(ph0 + th1 + th2) + d2x*dth2^2*m2*sin(ph0 + th1 + th2) + a1*dph0^2*m2*sin(ph0 + th1) + a1*dth1^2*m2*sin(ph0 + th1) + d1x*dph0^2*m1*sin(ph0 + th1) + d1x*dth1^2*m1*sin(ph0 + th1) + (a0*dph0^2*m1*sin(ph0))/2 + (a0*dph0^2*m2*sin(ph0))/2 + 2*d2x*dph0*dth1*m2*sin(ph0 + th1 + th2) + 2*d2x*dph0*dth2*m2*sin(ph0 + th1 + th2) + 2*d2x*dth1*dth2*m2*sin(ph0 + th1 + th2) + 2*a1*dph0*dth1*m2*sin(ph0 + th1) + 2*d1x*dph0*dth1*m1*sin(ph0 + th1)) + (d3x*dph0^2*m3*sin(ph0 + th3) + d3x*dth3^2*m3*sin(ph0 + th3) + (a0*dph0^2*m3*sin(ph0))/2 + 2*d3x*dph0*dth3*m3*sin(ph0 + th3));
cb3=-((a0*d2x*dth1^2*m2*sin(th1 + th2))/2 + (a0*d2x*dth2^2*m2*sin(th1 + th2))/2 + (a0*a1*dth1^2*m2*sin(th1))/2 + (a0*d1x*dth1^2*m1*sin(th1))/2 + a1*d2x*dth2^2*m2*sin(th2) + a0*d2x*dph0*dth1*m2*sin(th1 + th2) + a0*d2x*dph0*dth2*m2*sin(th1 + th2) + a0*d2x*dth1*dth2*m2*sin(th1 + th2) + a0*a1*dph0*dth1*m2*sin(th1) + a0*d1x*dph0*dth1*m1*sin(th1) + 2*a1*d2x*dph0*dth2*m2*sin(th2) + 2*a1*d2x*dth1*dth2*m2*sin(th2) + (a0*m1*dx0*dph0*cos(ph0))/2 + d1x*m1*dx0*dph0*cos(ph0+th1) + d1x*m1*dx0*dth1*cos(ph0+th1) + (a0*m1*dy0*dph0*sin(ph0))/2 + d1x*m1*dy0*dph0*sin(ph0+th1) + d1x*m1*dy0*dth1*sin(ph0+th1) + (a0*m2*dx0*dph0*cos(ph0))/2 + a1*m2*dx0*dph0*cos(ph0+th1) + a1*m2*dx0*dth1*cos(ph0+th1) + d2x*m2*dx0*dph0*cos(ph0+th1+th2) + d2x*m2*dx0*dth1*cos(ph0+th1+th2) + d2x*m2*dx0*dth2*cos(ph0+th1+th2) + (a0*m2*dy0*dph0*sin(ph0))/2 + a1*m2*dy0*dph0*sin(ph0+th1) + a1*m2*dy0*dth1*sin(ph0+th1) + d2x*m2*dy0*dph0*sin(ph0+th1+th2) + d2x*m2*dy0*dth1*sin(ph0+th1+th2) + d2x*m2*dy0*dth2*sin(ph0+th1+th2)) + (-(a0*d3x*dth3^2*m3*sin(th3))/2 - a0*d3x*dph0*dth3*m3*sin(th3) + (a0*m3*dx0*dph0*cos(ph0))/2 + d3x*m3*dx0*dph0*cos(ph0+th3) + d3x*m3*dx0*dth3*cos(ph0+th3) + (a0*m3*dy0*dph0*cos(ph0))/2 + d3x*m3*dy0*dph0*sin(ph0+th3) + d3x*m3*dy0*dth3*sin(ph0+th3));

cm4=-((a0*d2x*dph0*dth1*m2*sin(th1 + th2))/2 + (a0*d2x*dph0*dth2*m2*sin(th1 + th2))/2 + (a0*a1*dph0*dth1*m2*sin(th1))/2 - (a0*d1x*dph0*dth1*m1*sin(th1))/2 + a1*d2x*dth2^2*m2*sin(th2) + 2*a1*d2x*dph0*dth2*m2*sin(th2) + 2*a1*d2x*dth1*dth2*m2*sin(th2) + d1x*m1*dx0*dph0*cos(ph0+th1) + d1x*m1*dx0*dth1*cos(ph0+th1) + d1x*m1*dy0*dph0*sin(ph0+th1) + d1x*m1*dy0*dth1*sin(ph0+th1) + 2*d1x*m2*dx0*dph0*cos(ph0+th1) + 2*d1x*m2*dx0*dth1*cos(ph0+th1) + d2x*m2*dx0*dph0*cos(ph0+th1+th2)+ d2x*m2*dx0*dth1*cos(ph0+th1+th2)+ d2x*m2*dx0*dth2*cos(ph0+th1+th2) + 2*d1x*m2*dy0*dph0*sin(ph0+th1) + 2*d1x*m2*dy0*dth1*sin(ph0+th1) + d2x*m2*dy0*dph0*sin(ph0+th1+th2)+ d2x*m2*dy0*dth1*sin(ph0+th1+th2)+ d2x*m2*dy0*dth2*sin(ph0+th1+th2));
cm5=-(a1*d2x*m2*dph0*dth2*sin(th2) + a1*d2x*m2*dth1*dth2*sin(th2) + (a0*d2x*m2*dph0*dth1*sin(th1+th2))/2 + (a0*d2x*m2*dph0*dth2*sin(th1+th2))/2 + (a0*d2x*m2*dth1^2*sin(th1+th2))/2 + (a0*d2x*m2*dth1*dth2*sin(th1+th2))/2 + d2x*m2*dx0*dph0*cos(ph0+th1+th2) + d2x*m2*dx0*dth1*cos(ph0+th1+th2) + d2x*m2*dx0*dth2*cos(ph0+th1+th2) + d2x*m2*dy0*dph0*sin(ph0+th1+th2) + d2x*m2*dy0*dth1*sin(ph0+th1+th2) + d2x*m2*dy0*dth2*sin(ph0+th1+th2));
cm6= (a0*d3x*dph0^2*m3*sin(th3))/2 + (d3x*m3*dx0*dph0*cos(ph0+th3) + d3x*m3*dx0*dth3*cos(ph0+th3) + (d3x*m3*dy0*dph0*sin(ph0+th3))/2 + (d3x*m3*dy0*dth3*sin(ph0+th3))/2);


%GIM
Ib = [hb11 hb12 hb13
    hb21 hb22 hb23
    hb31 hb32 hb33];

Ibm = [hbm14 hbm15 hbm16
    hbm24 hbm25 hbm26
    hbm34 hbm35 hbm36];

Im = [hm44 hm45 hm46
    hm54 hm55 hm56
    hm64 hm65 hm66];

I=[Ib Ibm;Ibm' Im];

%C Matrix
C=[cb1
    cb2
    cb3
    cm4
    cm5
    cm6];

cb=[cb1
    cb2
    cb3];

cm=[cm4
    cm5
    cm6];

% Type=1 for closed loop and =0 for open loop 
type=1;

if type==1 %Closed
    % Forces
    kp=49; kd=14;
    % F1=kp*(0-x0)+kd*(0-dx0);
    % F2=kp*(0-y0)+kd*(0-dy0);
    % F3=kp*(0-ph0)+kd*(0-dph0);
    F1=0; F2=0; F3=0;
    % tau1=kp*(th_d(1)-th1)+kd*(dth_d(1)-dth1);
    % tau2=kp*(th_d(2)-th2)+kd*(dth_d(2)-dth2);
    tau3=kp*(th_d(3)-th3)+kd*(dth_d(3)-dth3);
    tau1=0;
    tau2=0;
    % tau3=0;
    
    F = [F1
        F2
        F3
        tau1
        tau2
        tau3];
    
    Fb=[F1
        F2
        F3];
    
    Fm=[tau1
        tau2
        tau3];
    
    %Closed Loop Dynamics
    phi=F-C;
    q=[x0; y0; ph0]; dq=[dx0; dy0; dph0];
    th=[th1; th2; th3]; dth=[dth1; dth2; dth3];
    [J, J1, J2, dJ]=jacobian2(q, dq, th,dth);
    dqt=[dq; dth];
    Jt=transpose(J);
    
    % lambda Expression
    % IJ=inv(I)*Jt;
    % lamphi=(dJ*dqt+J*(inv(I))*phi);
    % lamI=J*IJ;
    % lam=-inv(lamI)*lamphi;
    lam=(-inv(J*(inv(I)*Jt)))*(J*(inv(I))*phi + dJ*dqt);
    
    %Matrix Form
    % O=zeros(2,2);
    % A=[I Jt
    %    J O];
    % B=[phi
    %    (-dJ)*dqt];
    % temp=inv(A)*B;
    
    %External Force Value
    % lam=[-2; 0];
    % Fe=[Fe1; Fe2];
    
    phi= phi+J'*lam;
    
elseif type==0 %Open
    % Forces
    kp=49; kd=14;
    % F1=kp*(0-x0)+kd*(0-dx0);
    % F2=kp*(0-y0)+kd*(0-dy0);
    % F3=kp*(0-ph0)+kd*(0-dph0);
    F1=0; F2=0; F3=0;
    tau1=kp*(th_d(1)-th1)+kd*(dth_d(1)-dth1);
    tau2=kp*(th_d(2)-th2)+kd*(dth_d(2)-dth2);
    tau3=kp*(th_d(3)-th3)+kd*(dth_d(3)-dth3);
    % tau1=0;
    % tau2=0;
    % tau3=0;
    
    F = [F1
        F2
        F3
        tau1
        tau2
        tau3];
    
    phi= F-C;
end
%DAE
temp=(inv(I))*(phi);
% temp = (inv(I))*((F)-(C) + J1'*lam ); %Force on End-Effector 1
% temp = (inv(I))*((F)-(C) + J2'*(-lam) ); %Force on End-Effector 2
% temp = (inv(I))*((F)-(C) + J'*lam); %Force on Both End-Effector (Way 1)
% temp = (inv(I))*((F)-(C) + (J1'-J2')*lam); %Force on both End-Effector (Way 2)
dy=zeros(12,1);

dy(1)=dx0;
dy(2)=dy0;
dy(3)=dph0;
dy(4)=dth1;
dy(5)=dth2;
dy(6)=dth3;
dy(7)=temp(1);
dy(8)=temp(2);
dy(9)=temp(3);
dy(10)=temp(4);
dy(11)=temp(5);
dy(12)=temp(6);


