%function [M, C]=Eqn_Motion_EL(n,th,dth,m,Izz,lc,l,g)

clc;
clear all;

n=3;

syms m1 m2 m3 m4 m5 m6 m7 m8 m9 m10
syms Izz1 Izz2 Izz3 Izz4 Izz5 Izz6 Izz7 Izz8 Izz9 Izz10
syms l1 l2 l3 l4 l5 l6 l7 l8 l9 l10
syms lc1 lc2 lc3 lc4 lc5 lc6 lc7 lc8 lc9 lc10
syms th1 th2 th3 th4 th5 th6 th7 th8 th9 th10
syms dth1 dth2 dth3 dth4 dth5 dth6 dth7 dth8 dth9 dth10
syms g
assume(g,'real');
% 
m=[m1 m2 m3 m4 m5 m6 m7 m8 m9 m10];

Izz=[Izz1 Izz2 Izz3 Izz4 Izz5 Izz6 Izz7 Izz8 Izz9 Izz10];

th=[th1 th2 th3 th4 th5 th6 th7 th8 th9 th10];

dth=[dth1 dth2 dth3 dth4 dth5 dth6 dth7 dth8 dth9 dth10];

lc=[lc1 lc2 lc3 lc4 lc5 lc6 lc7 lc8 lc9 lc10];

l=[l1 l2 l3 l4 l5 l6 l7 l8 l9 l10];

grav=[0; -g; 0];

cc=(zeros(3,1));
% 
c(:,1)=[0; 0; lc1];
c(:,2)=[lc2*cos(th1)*cos(th2); 
    lc2*sin(th1)*cos(th2); 
    l1+lc2*sin(th2)];
c(:,3)=[l2*cos(th1)*cos(th2)+lc3*cos(th1)*cos(th2+th3);
    l2*sin(th1)*cos(th2)+lc3*sin(th1)*cos(th2+th3);
    l1+l2*sin(th2)+lc3*sin(th2+th3)];

% c(:,1)=sym([0; 0; 0]);
% c(:,2)=[lc2*cos(th1)*cos(th2); 
%     lc2*sin(th1)*cos(th2); 
%     lc2*sin(th2)];
% c(:,3)=[l2*cos(th1)*cos(th2)+lc3*cos(th1)*cos(th2+th3);
%     l2*sin(th1)*cos(th2)+lc3*sin(th1)*cos(th2+th3);
%     l2*sin(th2) + lc3*sin(th2+th3)];

for i=1:n  %n=no of links

    cs=cos(sum(th(1:i)));
    sn=sin(sum(th(1:i)));
    ww=sum(dth(1:i));
    w(3,i)=ww;
%     %Position
%     c(:,i)=cc+[lc(i)*cs;    lc(i)*sn;    0];
%     cl(:,i)=cc+[l(i)*cs;    l(i)*sn;    0];
%     cc=cl(:,i);
    %Velocity
    vv=jacobian(c(:,i),th(1:n))*dth(1:n).';
    v(:,i)=(vv)
    disp('v')
    i
    simplify(v)
    %Energy
    vtv = simplify(v(:,i).'*v(:,i))
    K(i)=((m(i)*v(:,i).'*v(:,i))+(Izz(i)*w(:,i).'*w(:,i)))/2
    P(i)=-m(i)*(grav'*c(:,i))
    kkvi = simplify(((m(i)*v(:,i).'*v(:,i))/2))
    kkwi = simplify(((Izz(i)*w(:,i).'*w(:,i))/2))
    pppi = simplify(P(i))
    %Langrangian
L=sum(K)-sum(P);
end

L11=jacobian(L,dth(1:n));
L1=L11.';
L1s = simplify(L1) % del_L/del_dth

L22=jacobian(L1,dth(1:n));
L2=L22.';
L2s = simplify(L2) % I terms: del_L (del_L/del_dth)/del_t

L33=jacobian(L1,th(1:n));
L3=L33*dth(1:n).';
L3s=simplify(L3) % C terms: del_L (del_L/del_dth)/del_t

L44=jacobian(L,th(1:n));
L4=L44.';
L4s=simplify(L4) % del_L/del_th

%EOM

M=simplify(L2)

C=simplify(L3-L4)
%EOM



