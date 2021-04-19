function J=jacobian(q)

[dof m1 m2 a1 l2 g b th a alp]=inputs();

% Jacobian matrix (Jv)
th1=q(1); b2=q(2);
j11 = -a1*sin(th1) - b2*cos(th1);
j12 = -sin(th1);
j21 = a1*cos(th1) - b2*sin(th1);
j22 = cos(th1);
J = [j11 j12; 
     j21 j22];