function J = jacobian(q)

[robo_type, n, joint, al, b, th, a, alpha] = params();
a1 = al(1); a2 = al(2);
th1=q(1); b2=q(2);

J = [- b2*cos(th1) - a1*sin(th1), -sin(th1);
    a1*cos(th1) - b2*sin(th1),  cos(th1);
    0,         0;
    0,         0;
    0,         0;
    1,         0];
