function J = jacobian(q)

[robo_type, n, joint, al, b, th, a, alpha] = params();
a1 = al(1); a2 = al(2);
b1=q(1); th2=q(2);

J = [0,           0;
    0, a2*sin(th2);
    1, a2*cos(th2);
    0,          -1;
    0,           0;
    0,           0];
