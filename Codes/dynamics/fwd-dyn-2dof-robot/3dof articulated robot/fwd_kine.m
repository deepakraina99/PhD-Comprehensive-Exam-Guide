% RP manipulator: Homogeneous transformation matrix
% Contibutors: Deepak Raina @IIT Delhi

function ht = fwd_kine(q)

 [dof m1 m2 m3 l1 l2 l3 g b th a alp]=inputs();

temp = eye(4);
b = [l1; 0; 0];
th = [q(1); q(2); q(3)];
T(:,:,1) = eye(4);
for i = 1:dof
    ct = cos(th(i));
    st = sin(th(i));
    ca = cos(alp(i));
    sa = sin(alp(i));
    
    temp = temp * [ ct    -st*ca   st*sa     a(i)*ct ; ...
                    st    ct*ca    -ct*sa    a(i)*st ; ...
                    0     sa       ca        b(i)    ; ...
                    0     0        0         1      ];
    T(:,:,i) = temp;
end
ht = T;
end