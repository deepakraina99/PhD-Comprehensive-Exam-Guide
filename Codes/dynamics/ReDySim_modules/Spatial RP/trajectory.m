% ReDySim trajectory module. The desired indpendent joint trejectories are 
% enterd here
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [qi dqi ddqi]= trajectory(tim, dof, Tp)
%Enter trejectories here

% Initial and final joint variable
qin=[0 0.15];
qf=[pi/2 0.30];
for i=1:dof
    qi(i,1)=qin(i)+((qf(i)-qin(i))/Tp)*(tim-(Tp/(2*pi))*sin((2*pi/Tp)*tim));
    dqi(i,1)=((qf(i)-qin(i))/Tp)*(1-cos((2*pi/Tp)*tim));
    ddqi(i,1)=(2*pi*(qf(i)-qin(i))/(Tp*Tp))*sin((2*pi/Tp)*tim);
end
