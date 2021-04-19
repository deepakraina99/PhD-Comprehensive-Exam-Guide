clc;
clear all;

% DH parameters
syms th1 th2 th3 th4 th5 th6
syms b1 b2 b3 b4 b5 b6
syms a1 a2 a3 a4 a5 a6

%% Define Robot
% SCARA Manipulator
joint=[1 1 0 1];
th=[th1 th2 0 th4];
b=[0 0 b3 b4];
alpha=[0 pi 0 0];
a=[a1 a2 0 0];

% % 3-link RRR planar manipulator
% joint=[1 1 1];  
% th=[th1 th2 th3];
% b=[0 0 0];
% alpha=[0 0 0];
% a=[a1 a2 a3];

% % 2-link RP planar manipulator
% joint=[1 0];
% th=[th1 0];
% b=[0 b2];
% alpha=[-pi/2  pi/2];
% a=[a1 0];

% % 2-link PR planar manipulator
% joint=[0 1];
% th=[-pi/2 th2];
% b=[b1 0];
% alpha=[pi/2  0];
% a=[0 a2];
%% Generating HTM matrices
% T(:,:,1)=homo_trans(b(1),th(1),a(1),alpha(1));
% for i=2:size(th,2)
%     T(:,:,i)=T(:,:,i-1)*homo_trans(b(i),th(i),a(i),alpha(i));
% end
% T
T = fwd_kine(b,th,a,alpha)
%%
z(:,1)=sym([0;0;1]);
for i=1:(length(joint)-1)
    z(:,i+1)=T(1:3,3,i);
end

%%
if joint(1)==1
    jacob=[cross(z(:,1),(T(1:3,4,length(joint))-[0;0;0]));z(:,1)];
else
    jacob=[z(:,1);[0;0;0]];
end
for i=2:length(joint)
    if joint(i)==1
        jacob=horzcat(jacob,[cross(z(:,i),(T(1:3,4,length(joint))-T(1:3,4,i-1)));z(:,i)]);
    else
        jacob=horzcat(jacob,[z(:,i);[0;0;0]]);
    end
end
%% analyzing Singularities
% mat=jacob(1:3,1:3); %SCARA Manipulator
% deter=det(mat);
% [sing1,sing2]=solve(deter==0,'th1','th2');

out=jacob;
simplify(jacob)

function A= tutorial2(b,c,d,a)
% x=deg2rad(b);
% y=deg2rad(c);
x=b; y=c;
A=[cos(x) -round(cos(y))*sin(x) sin(x)*(round(sin(y))) a*cos(x); sin(x) round(cos(y))*cos(x) -round(sin(y))*cos(x) a*sin(x)];
A=[A;0 round(sin(y)) round(cos(y)) d; 0 0 0 1];
end