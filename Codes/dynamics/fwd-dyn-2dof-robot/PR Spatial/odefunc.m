function dY = odefunc(t,Y)
%Input data
[dof m1 m2 l1 a2 g b th a alp]=inputs();
[y0, ti, tf]=initials();
disp(t)
b1=Y(1); th2=Y(3); db1=Y(2); dth2=Y(4);

%State equations
%Inertia Matrix [M]
i11 = m1 + m2;
i12 = 0;
i21 = i12;
i22 = m2*(a2^2/4) + m2*(a2^2)/12;

I = [i11 i12;
     i21 i22];
 
% h vector 
h1 = 0;
h2 = 0;
h = [h1; h2];

% gravity vector
tg1 = 0;
tg2 = m2*g*(a2/2)*cos(th2);
tau_g = [tg1; tg2];

% applied torque
tau_d = torque(t, tf, dof, [b1, th2], [db1, dth2]); 
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