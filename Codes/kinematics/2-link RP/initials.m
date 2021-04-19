function [te, qi, ti, dt, tf] = initials()

te = [0; 0.25; 0; 0; 0; 0];
qi = [deg2rad(0); 0];
ti=0; dt=0.01; tf=1.5;