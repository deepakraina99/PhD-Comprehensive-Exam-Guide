function dy=odefunc(t,y)

[a1 a2 a3 m1 m2 m3 g] = inputs();

th1 = y(1); th2 = y(2); b = y(3);
th1d = y(4); th2d = y(5); bd = y(6);

% Inertia matrix
i11 = (1/3)*((m1*a1*a1)+(m2*a2*a2)) + m2*a1*a1 + m2*a1*a2*cos(th2);
i12 = (1/3)*(m2*a2*a2) + (1/2)*(m2*a1*a2*cos(th2));
i13 = 0;
i21 = i12;
i22 = (1/3)*(m2*a2*a2);
i23 = 0;
i31 = 0; i32 = 0; i33 = m3;

I = [i11 i12 i13; i21 i22 i23; i31 i32 i33];

% h matrix
h1 = -m2*a1*a2*sin(th2)*(0.5*th2d + th1d)*th2d;
h2 = 0.5*m2*a1*a2*sin(th2)*th1d*th1d;
h3 = 0;

h = [h1;h2;h3];

% gravity matrix
g1 = m1*g*(a1/2)*cos(th1)+ m2*g*(a1*cos(th1) + (a2/2)*cos(th1+th2));
g2 = m2*g*(a2/2)*cos(th1+th2);
g3 = 0;
tau_g = [g1;g2;g3];

% applied torque
q = [th1, th2, b]; 
dq=[th1d; th2d; bd];
tau = torque(t,q,dq);

% phi
phi = tau - h - tau_g;

% Jacobian
[J, dJ]=jacobian(q, dq);

% closed loop constraint forces
lam=(-inv(J*(inv(I)*J')))*(J*(inv(I))*phi + dJ*dq);
phi= phi+J'*lam;

% acceleration
thdd = I\phi;
dy=zeros(6,1);
dy(1)=y(4);
dy(2)=y(5);
dy(3)=y(6);
dy(4)=thdd(1);
dy(5)=thdd(2);
dy(6)=thdd(3);