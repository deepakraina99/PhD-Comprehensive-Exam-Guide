% ReDySim inputs module. The model parameters are entered in this module
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs() 

%System: KUKA KR5 robot
% INPUTS
%Number of links 
n=6;

%Degree of fredom of the system
dof=6;

% Type of mechanism
type=0; % 1 for closed-loop and 0 for open-loop

%Actuated joints of open tree
aj=[1 1 1 1 1 1]; %enter 1 for actuated joints and 0 otherwise

% Link lengths
al=[0.1625; 0.425; 0.3922; 0.1333; 0.0997; 0.0966];

%DH PARAMETERs
% alp=[0; pi/2; 0; 0; pi/2; -pi/2; 0];
% a=[0; 0; -0.4250; -0.3922; 0; 0; 0];
% b=[0; .1625; 0; 0; .1333; 0.0997; 0.0966];
% th=[0; 0; 0; 0; 0; 0];
% 2 link will be fixed
% alp=[0; pi/2; 0; 0; pi/2; -pi/2];
% a=[0; -0.4250; -0.3922; 0; 0; 0];
% b=[0.1625; 0; 0; 0.133; 0.0997; 0.0966];
% th=[0; 0; 0; 0; 0; 0];
alp=[0; 0; pi/2; 0; 0; pi/2; -pi/2];
a=[0; 0; -0.4250; -0.3922; 0; 0; 0];
b=[0; 0.1625; 0; 0; 0.133; 0.0997; 0.0966];
th=[0; 0; 0; 0; 0; 0];
% alp=[0; pi/2; 0; 0; pi/2; -pi/2];
% a=[0; -0.4250; -0.3922; 0; 0; 0];
% b=[0.1625; 0; 0; 0.133; 0.0997; 0.0966];
% th=[0; 0; 0; 0; 0; 0];
%Enter joint type , r=1 if revolute and r=0 if prismatic
r=[1; 1; 1; 1; 1; 1];

%PARENT ARRAY
bt=[0; 1; 2; 3; 4; 5 ];

% di,a vector form the origin Ok to Center of mass (COM), Ck, for k=1,..,n
dx=[       0,    0.2125,    0.1500,         0,         0,         0];
dy=[ -0.0256,         0,         0,   -0.0018,    0.0018,         0];
dz=[  0.0019,    0.1134,    0.0265,    0.0163,    0.0163,   -0.0012];

% MASS AND MOMENT OF INERTIA AND GRAVITY
m=[3.71, 8.058, 2.846, 1.37, 1.3, 0.365];
g=[0 ; 0; -9.81];

%Inertia Tensor of the kth link about Center-Of-Mass (COM) in ith frame
%which is rigid attach to the link
Icxx=zeros(n,1);Icyy=zeros(n,1);Iczz=zeros(n,1); % Initialization
Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1); % Initialization
Icxx(1)=0.0067;  Icyy(1)=0.0064;  Iczz(1)=0.0067;
Icxx(2)=0.0149;  Icyy(2)=0.3564;  Iczz(2)=0.3553;
Icxx(3)=0.0025;  Icyy(3)=0.0551;  Iczz(3)=0.0546;
Icxx(4)=0.0012;  Icyy(4)=0.0012;  Iczz(4)=0.0090;
Icxx(5)=0.0012;  Icyy(5)=0.0012;  Iczz(5)=0.0090;
Icxx(6)=0.0001;  Icyy(6)=0.0001;  Iczz(6)=0.0001;
end