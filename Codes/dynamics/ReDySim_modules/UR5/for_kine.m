function [so sc vc tt st]=for_kine(q, dq,n, alp, a, b, th, bt, r, dx, dy, dz)

%This code was dveloped by Mr. Suril Shah
% Updated latest : 10 Aug 2013
% This program calculate forward kinematics
% in the inertial frame

% FORWARD RECURSION _FINDING TWIST AND TWIST RATE
%Initialization
e=[0;0;1];
tt=zeros(3,n);
tb=zeros(3,n);
so=zeros(3,n);
sc=zeros(3,n);
st=zeros(3,n);
vc=zeros(3,n);
Qf=zeros(3,3,n);
p=zeros(n,1);

% Enter location of fixed hinges
% FOR LOOP STARTS
for i=1:n
    p(i)=1-r(i);
    th(i)=th(i)*p(i)+q(i)*r(i);
    b(i)=b(i)*r(i)+q(i)*p(i);
    if bt(i)==0 %When parent of the link is ground link
   
        Qi=[cos(th(i))              -sin(th(i))              0
            cos(alp(i))*sin(th(i))   cos(alp(i))*cos(th(i)) -sin(alp(i))
            sin(alp(i))*sin(th(i))   sin(alp(i))*cos(th(i))  cos(alp(i))];
        Qf(:,:,i)=Qi;
        %Positions
        di=[dx(i);dy(i);dz(i)];
        aim=[a(i)
            -b(i)*sin(alp(i))
            b(i)*cos(alp(i))];
        so(:,i)=aim;
        sc(:,i)=so(:,i)+Qf(:,:,i)*di;
        st(:,i)=so(:,i)+Qf(:,:,i)*2*di;
        %w angular velocity
        edq=e*dq(i);
        tt(:,i)=r(i)*edq;
        tti=tt(:,i);
        
        %%v
        tb(:,i)=p(i)*edq;
        ttixdi=[tti(2)*di(3)-di(2)*tti(3);-(tti(1)*di(3)-di(1)*tti(3));tti(1)*di(2)-di(1)*tti(2)];
        vc(:,i)=tb(:,i)+ttixdi;
        
    else %Calculation for the links other than those attached with ground
        Qi=[cos(th(i))              -sin(th(i))              0
            cos(alp(i))*sin(th(i))   cos(alp(i))*cos(th(i)) -sin(alp(i))
            sin(alp(i))*sin(th(i))   sin(alp(i))*cos(th(i))  cos(alp(i))];
        Qf(:,:,i)=Qf(:,:,bt(i))*Qi;
        
        %position vector from origin of link to origin of next link
        aim=[a(i)
            -b(i)*sin(alp(i))
            b(i)*cos(alp(i))];
        di=[dx(i);dy(i);dz(i)];
        
        %Positions
        so(:,i)=so(:,bt(i))+Qf(:,:,bt(i))*aim;
        sc(:,i)=so(:,i)+Qf(:,:,i)*di;
        st(:,i)=so(:,i)+Qf(:,:,i)*2*di;
        
        %w angular velocity
        ttbi=tt(:,bt(i));
        edq=e*dq(i);
        tt(:,i)=Qi'*ttbi+r(i)*edq;
        tti=tt(:,i);
        %v  linear velocity
        ttbixaim=[ttbi(2)*aim(3)-aim(2)*ttbi(3);-(ttbi(1)*aim(3)-aim(1)*ttbi(3));ttbi(1)*aim(2)-aim(1)*ttbi(2)];
        tb(:,i)=Qi.'*(tb(:,bt(i))+ttbixaim)+p(i)*edq;
        ttixdi=[tti(2)*di(3)-di(2)*tti(3);-(tti(1)*di(3)-di(1)*tti(3));tti(1)*di(2)-di(1)*tti(2)];
        vc(:,i)=tb(:,i)+ttixdi;
    end
end