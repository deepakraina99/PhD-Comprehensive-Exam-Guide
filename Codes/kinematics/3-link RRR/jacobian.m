function J = jacobian(q)

[robo_type, n, joint, al, b, th, a, alpha] = params();
a1 = a(1); a2 = a(2); a3 = a(3);
th1=q(1); th2=q(2); th3=q(3);

J = [- a2*sin(th1 + th2) - a1*sin(th1) - a3*sin(th1 + th2 + th3), - a2*sin(th1 + th2) - a3*sin(th1 + th2 + th3), -a3*sin(th1 + th2 + th3);
a2*cos(th1 + th2) + a1*cos(th1) + a3*cos(th1 + th2 + th3),   a2*cos(th1 + th2) + a3*cos(th1 + th2 + th3),  a3*cos(th1 + th2 + th3);
0,                                             0,                        0;
0,                                             0,                        0;
0,                                             0,                        0;
1,                                             1,                        1];
