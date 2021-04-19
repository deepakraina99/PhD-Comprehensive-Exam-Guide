function J = jacobian(q)

[robo_type, n, joint, al, b, th, a, alpha] = params();

th1=q(1); th2=q(2); th3=q(3); th4=q(4); th5=q(5); th6=q(6);
a1=a(1); a2=a(2); a3=a(3); a4=a(4); a5=a(5); a6=a(6);
b1=b(1); b2=b(2); b3=b(3); b4=b(4); b5=b(5); b6=b(6);

j11=b6*(cos(th1)*cos(th5) + cos(th2 + th3 + th4)*sin(th1)*sin(th5)) + b4*cos(th1) - a2*cos(th2)*sin(th1) - b5*sin(th2 + th3 + th4)*sin(th1) - a3*cos(th2)*cos(th3)*sin(th1) + a3*sin(th1)*sin(th2)*sin(th3);
j12=-cos(th1)*(b5*(sin(th2 + th3)*sin(th4) - cos(th2 + th3)*cos(th4)) + a3*sin(th2 + th3) + a2*sin(th2) - b6*sin(th5)*(cos(th2 + th3)*sin(th4) + sin(th2 + th3)*cos(th4)));
j13=cos(th1)*(b5*cos(th2 + th3 + th4) - a3*sin(th2 + th3) + b6*sin(th2 + th3 + th4)*sin(th5));
j14=cos(th1)*(b5*cos(th2 + th3 + th4) + b6*sin(th2 + th3 + th4)*sin(th5));
j15=b6*cos(th1)*cos(th2)*cos(th5)*sin(th3)*sin(th4) - b6*sin(th1)*sin(th5) + b6*cos(th1)*cos(th3)*cos(th5)*sin(th2)*sin(th4) + b6*cos(th1)*cos(th4)*cos(th5)*sin(th2)*sin(th3) - b6*cos(th1)*cos(th2)*cos(th3)*cos(th4)*cos(th5);
j16=0;

j21=b6*(cos(th5)*sin(th1) - cos(th2 + th3 + th4)*cos(th1)*sin(th5)) + b4*sin(th1) + a2*cos(th1)*cos(th2) + b5*sin(th2 + th3 + th4)*cos(th1) + a3*cos(th1)*cos(th2)*cos(th3) - a3*cos(th1)*sin(th2)*sin(th3);
j22=-sin(th1)*(b5*(sin(th2 + th3)*sin(th4) - cos(th2 + th3)*cos(th4)) + a3*sin(th2 + th3) + a2*sin(th2) - b6*sin(th5)*(cos(th2 + th3)*sin(th4) + sin(th2 + th3)*cos(th4)));
j23=sin(th1)*(b5*cos(th2 + th3 + th4) - a3*sin(th2 + th3) + b6*sin(th2 + th3 + th4)*sin(th5));
j24=sin(th1)*(b5*cos(th2 + th3 + th4) + b6*sin(th2 + th3 + th4)*sin(th5));
j25=b6*cos(th1)*sin(th5) - b6*cos(th2)*cos(th3)*cos(th4)*cos(th5)*sin(th1) + b6*cos(th2)*cos(th5)*sin(th1)*sin(th3)*sin(th4) + b6*cos(th3)*cos(th5)*sin(th1)*sin(th2)*sin(th4) + b6*cos(th4)*cos(th5)*sin(th1)*sin(th2)*sin(th3);
j26=0;

j31=0;
j32=a3*cos(th2 + th3) - (b6*sin(th2 + th3 + th4 + th5))/2 + a2*cos(th2) + (b6*sin(th2 + th3 + th4 - th5))/2 + b5*sin(th2 + th3 + th4);
j33=a3*cos(th2 + th3) - (b6*sin(th2 + th3 + th4 + th5))/2 + (b6*sin(th2 + th3 + th4 - th5))/2 + b5*sin(th2 + th3 + th4);
j34=(b6*sin(th2 + th3 + th4 - th5))/2 - (b6*sin(th2 + th3 + th4 + th5))/2 + b5*sin(th2 + th3 + th4);
j35=-b6*(sin(th2 + th3 + th4 - th5)/2 + sin(th2 + th3 + th4 + th5)/2);
j36=0;

j41=0;
j42=sin(th1);
j43=sin(th1);
j44=sin(th1);
j45=sin(th2 + th3 + th4)*cos(th1);
j46=cos(th5)*sin(th1) - cos(th2 + th3 + th4)*cos(th1)*sin(th5);

j51=0;
j52=-cos(th1);
j53=-cos(th1);
j54=-cos(th1);
j55=sin(th2 + th3 + th4)*sin(th1);
j56=- cos(th1)*cos(th5) - cos(th2 + th3 + th4)*sin(th1)*sin(th5);

j61=1;
j62=0;
j63=0;
j64=0;
j65=-cos(th2 + th3 + th4);
j66=-sin(th2 + th3 + th4)*sin(th5);

J = [j11 j12 j13 j14 j15 j16;
    j21 j22 j23 j24 j25 j26;
    j31 j32 j33 j34 j35 j36;
    j41 j42 j43 j44 j45 j46;
    j51 j52 j53 j54 j55 j56;
    j61 j62 j63 j64 j65 j66];
