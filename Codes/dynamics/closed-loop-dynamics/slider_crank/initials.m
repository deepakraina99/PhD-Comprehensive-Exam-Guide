function [y0, ti, tf, incr, rtol, atol, int_type] = initials()


% Initial condition here
%3 link system
q=[deg2rad(120);deg2rad(120);-1];
dq=[0;0;0];
y0=[q;dq];

%Time span
ti=0;
tf=3;
incr=.01; %Sampling time for adaptive solver and step size for fixed step solver

%Relative and absolute tolerance for ode45
rtol=1e-4;
atol=1e-6;
int_type=0; %0 for ode45, 1 for ode15s, 2 for ode5
end