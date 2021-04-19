%% Dynamic Simulation of 2-link RP robot %%
% Contributors: Deepak Raina @IIT delhi
%%
function [] = run_me()
%Use this file to run your program
clear all;
fclose all;
clc;
disp('Dynamic Simulation of 2-link RP robot')
disp('---------------------------------------------')
%Input data
[dof m1 m2 a1 l2 g b th a alp]=inputs();

%Initial data
[y0, t_initial, t_final, incr, rtol, atol]=initials();

%ODE Solver
opts = odeset('RelTol',rtol,'AbsTol',atol);
[T,Y] = ode45(@odefunc,t_initial:incr:t_final,y0,opts);

%Exporting data to .dat
%OPENING DATA FILE
fomode='w';
fip1=fopen('timevar.dat',fomode);%time
fip2=fopen('statevar.dat',fomode);%all state variables

%FOR LOOP FOR READING & WRITING SOLUTIONS FOR EACH INSTANT
for j=1:length(T)
    tsim=T(j);
    %WRITING SOLUTION FOR EACH INSTANT IN FILES
    fprintf(fip1,'%e\n',tsim);
    fprintf(fip2,'%e ',Y(j,:));
    fprintf(fip2,'\n');
end

%Animation
animate;

%Plot motion
plot_motions;

%Plot motion
% plot_tor;
