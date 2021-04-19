function dY = odefunc(t,Y)
%Input data
[dof m1 m2 a1 l2 g b th a alp]=inputs();
[y0, ti, tf]=initials();
disp(t)
th1=Y(1); b2=Y(3); dth1=Y(2); db2=Y(4);

%State equations
%Inertia Matrix [M]
i11 = (m1*a1^2)/3 + (m2*l2^2)/12 + m2*(a1^2 + (b2-(l2/2))^2);
i12 = m2*a1;
i21 = i12;
i22 = m2;

I = [i11 i12;
     i21 i22];
 
% h vector 
h1 = 2*m2*(b2-(l2/2))*db2*dth1;
h2 = -m2*(b2-(l2/2))*(dth1^2);
h = [h1; h2];

% gravity vector
tg1 = m2*g*(a1*cos(th1) - (b2-(l2/2))*sin(th1)) + (m1*g*a1*cos(th1))/2;
tg2 = m2*g*cos(th1);
tau_g = [tg1; tg2];

% applied torque
tau_d = torque(t, tf, dof, [th1, b2], [dth1, db2]); 
tau = -tau_g + tau_d;

% phi
phi = tau - h;

% acceleration
ddth = inv(I)*(phi);

%New
dY=zeros(4,1);
dY(1)=Y(2);
dY(2)=ddth(1);
dY(3)=Y(4);
dY(4)=ddth(2);
%dY
