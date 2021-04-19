% ReDySim trajectory module. The desired indpendent joint trejectories are 
% enterd here
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [qi dqi ddqi]= trajectory(tim, dof, Tp)
%Enter trejectories here
%Constant angular velocity
% Initial and final joint variable

qin=[0 0 0 0 0 0];
qf=[0 0 0 0 0 0];
% qf=[pi/3 pi/3 pi/3 pi/3 pi/3 pi/3];
qf(1)=pi/3;

for i=1:dof
    qi(i)=qin(i)+((qf(i)-qin(i))/Tp)*(tim-(Tp/(2*pi))*sin((2*pi/Tp)*tim));
    dqi(i)=((qf(i)-qin(i))/Tp)*(1-cos((2*pi/Tp)*tim));
    ddqi(i)=(2*pi*(qf(i)-qin(i))/(Tp*Tp))*sin((2*pi/Tp)*tim);
end