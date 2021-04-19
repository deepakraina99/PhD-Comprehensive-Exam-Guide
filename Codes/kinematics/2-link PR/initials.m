function [te, qi, ti, dt, tf] = initials()

te = [0; 0.5; 0; 0; 0; 0];
qi = [0.5; deg2rad(30)];
ti=0; dt=0.01; tf=1.5;