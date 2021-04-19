% ReDySim input module.The model parameters are entered in this module
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs() 

%System: 3-link planar robot
%Number of links 
n=2;

%Degree of fredom of the system
dof=n;

%system type
type=0; %1 for Closed-loop and 0 for open-loop

% Link lengths
al=[0.3; 0.3]; 

%DH PARAMETERs
alp=[pi/2; -pi/2];
a=[0; 0.3];
b=[0; 0.15];
th=[0; 0];

%Enter joint type , r=1 if revolute and r=0 if prismatic
r=[1; 0];

%PARENT ARRAY
bt=[0; 1];

%Actuated joints of open tree
aj=[1 1]; %enter 1 for actuated joints and 0 otherwise


% d - VECTOR FORM ORIGIN TO CG 
dx=[al(1)/2, 0];   % all X coordinates
dy=[0,       0];         % all Y coordinates
dz=[0,      -al(2)/2];         % all Z coordinates

% MASS AND MOMENT OF INERTIA AND GRAVITY
m=[0.5; 0.5];
g=[0; -9.81; 0];
% g=[0; 0; 0];

%Inertia Tensor of the kth link about Center-Of-Mass (COM) in ith frame
%which is rigid attach to the link
Icxx=zeros(n,1);Icyy=zeros(n,1);Iczz=zeros(n,1); % Initialization 
Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1); % Initialization 
Icxx(1)=0;  Icyy(1)=(1/12)*m(1)*al(1)*al(1);  Iczz(1)=(1/12)*m(1)*al(1)*al(1);
Icxx(2)=(1/12)*m(2)*al(2)*al(2);  Icyy(2)=(1/12)*m(2)*al(2)*al(2);  Iczz(2)=0;

end