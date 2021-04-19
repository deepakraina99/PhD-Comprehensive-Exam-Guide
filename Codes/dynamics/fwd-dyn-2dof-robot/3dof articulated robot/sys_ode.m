function [I, h, tau_g] = sys_ode(q,dq)
[dof m1 m2 m3 l1 l2 l3 g b th a alp]=inputs();

th1=q(1); th2=q(2); th3=q(3); dth1=dq(1); dth2=dq(2); dth3=dq(3);

Izz1 = m1*l1*l1/12; Izz2 = m2*l2*l2/12; Izz3 = m3*l3*l3/12;
lc2 = l2/2; lc3 = l3/2;
%State equations
%Inertia Matrix [M]
i11 = Izz1 + Izz2 + Izz3 + (l2^2*m3)/2 + (lc2^2*m2)/2 + (lc3^2*m3)/2 + (lc3^2*m3*cos(2*th2 + 2*th3))/2 + (l2^2*m3*cos(2*th2))/2 + (lc2^2*m2*cos(2*th2))/2 + l2*lc3*m3*cos(th3) + l2*lc3*m3*cos(2*th2 + th3);
i12 = Izz2 + Izz3;
i13 = Izz3;
i21 = i12;
i22 = m3*l2^2 + 2*m3*cos(th3)*l2*lc3 + m2*lc2^2 + m3*lc3^2 + Izz2 + Izz3;
i23 = m3*lc3^2 + l2*m3*cos(th3)*lc3 + Izz3;
i31 = i13;
i32 = i23;
i33 = m3*lc3^2 + Izz3;
  
I = [i11 i12 i13;
     i21 i22 i23;
     i31 i32 i33];
 
% h vector
 
 
h1 =-dth1*dth2*l2^2*m3*sin(2*th2) - dth1*dth2*lc2^2*m2*sin(2*th2) - dth1*dth2*lc3^2*m3*sin(2*th2 + 2*th3) - dth1*dth3*lc3^2*m3*sin(2*th2 + 2*th3) - dth1*dth3*l2*lc3*m3*sin(th3) - 2*dth1*dth2*l2*lc3*m3*sin(2*th2 + th3) - dth1*dth3*l2*lc3*m3*sin(2*th2 + th3);
h2 = (dth1^2*l2^2*m3*sin(2*th2))/2 + (dth1^2*lc2^2*m2*sin(2*th2))/2 - dth3^2*l2*lc3*m3*sin(th3) + (dth1^2*lc3^2*m3*cos(2*th2)*sin(2*th3))/2 + (dth1^2*lc3^2*m3*cos(2*th3)*sin(2*th2))/2 - 2*dth2*dth3*l2*lc3*m3*sin(th3) + dth1^2*l2*lc3*m3*cos(2*th2)*sin(th3) + dth1^2*l2*lc3*m3*sin(2*th2)*cos(th3);
h3 = (lc3*m3*(dth1^2*lc3*sin(2*th2 + 2*th3) + dth1^2*l2*sin(th3) + 2*dth2^2*l2*sin(th3) + dth1^2*l2*sin(2*th2 + th3)))/2;
h = [h1; h2; h3];

% gravity vector
tg1 = (g*lc3*m3*cos(th2 - th1 + th3))/2 + (g*l2*m3*cos(th1 + th2))/2 + (g*lc2*m2*cos(th1 + th2))/2 + (g*l2*m3*cos(th1 - th2))/2 + (g*lc2*m2*cos(th1 - th2))/2 + (g*lc3*m3*cos(th1 + th2 + th3))/2 ;
tg2 = - g*l2*m3*sin(th1)*sin(th2) - g*lc2*m2*sin(th1)*sin(th2)  - g*lc3*m3*cos(th2)*sin(th1)*sin(th3) - g*lc3*m3*cos(th3)*sin(th1)*sin(th2);
tg3 = (lc3*m3*(g*cos(th1 + th2 + th3) - g*cos(th2 - th1 + th3)))/2;
tau_g = [tg1; tg2; tg3];