
clc;
clear all;
disp('----------------------------------')
disp('SINGULAR VALUE DECOMPOSITION CODE')
disp('----------------------------------')
A = randi([-15 15],3,3)
% A = [9 2 3 12; 9 0 5 12; 0 1 -4 0];
disp('----------------------------------')
disp('MY SVD')
disp('----------------------------------')
[u,s,v] = mysvd(A)
disp('----------------------------------')
disp('MATLAB SVD')
disp('----------------------------------')
[u0,s0,v0] = svd(A)
disp('----------------------------------')
