function [J, J1, J2, dJ]=jacobian3(th,dth)

%Input

a0=0.895; a1=1.152; a2=1.152; a3=0.38;
th0=0; th1=th(1);th2=th(2); th3=th(3);
dth0=0; dth1=dth(1);dth2=dth(2); dth3=dth(3);
th01=th0+th1; th012=th0+th1+th2; th03=th0+th3;
dth01=dth0+dth1; dth012=dth0+dth1+dth2; dth03=dth0+dth3;

% Jacobian J
J=[-a1*sin(th01)-a2*sin(th012) -a2*sin(th012)  a3*sin(th03)
    a1*cos(th01)+a2*cos(th012)  a2*cos(th012)  -a3*cos(th03)];

% J1
J1=[-a1*sin(th01)-a2*sin(th012) -a2*sin(th012) 0
    a1*cos(th01)+a2*cos(th012)  a2*cos(th012) 0];

% J2
J2=[0 0  a3*sin(th03)
    0 0 -a3*cos(th03)];

% Derivative of Jacobian dJ

dJ=[-a1*cos(th01)*dth01-a2*cos(th012)*dth012 -a2*cos(th012)*dth012 a3*cos(th03)*dth03
    -a1*sin(th01)*dth01-a2*sin(th012)*dth012 -a2*sin(th012)*dth012 a3*sin(th03)*dth03];


