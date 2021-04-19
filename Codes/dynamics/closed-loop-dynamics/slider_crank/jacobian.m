function [J, dJ]=jacobian(q, dq)

[a1 a2 a3 m1 m2 m3 g] = inputs();

% Jacobian matrix (Jv)
th1=q(1); th2=q(2); b=q(3);
th1d=dq(1); th2d=dq(2); bd=dq(3);

J = [ -a1*sin(th1)-a2*sin(th1+th2)  -a2*sin(th1+th2) -1;
    a1*cos(th1)+a2*cos(th1+th2)    a2*cos(th1+th2) 0];

dJ = [ -a1*cos(th1)*th1d-a2*cos(th1+th2)*(th1d+th2d)  -a2*cos(th1+th2)*(th1d+th2d) 0;
     -a1*sin(th1)*th1d-a2*sin(th1+th2)*(th1d+th2d)  -a2*sin(th1+th2)*(th1d+th2d) 0];
