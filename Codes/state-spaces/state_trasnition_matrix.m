clc;
clear all;
syms t
A = [-2 1; 2 -3];
[V,D]=eig(A);
diag(exp(diag(D)*t))
stm=(V*diag(exp(diag(D)*t)))* inv(V);

x0=[1; 2];
resp=stm*x0;


A = [0 0 -2; 0 1 0; 1 0 3];
[V,D]=eig(A);
D
V
diag(exp(diag(D)*t))
stm=(V*diag(exp(diag(D)*t)))* inv(V)

x0=[0; 1; 0];
resp=stm*x0
 
A = [exp(2*t) 0 0;
    0 exp(t) 0;
    0 0 exp(t)]

P = [1 -2 0;
    0 0 1;
    -1 1 0]
inv(P)
P*A*inv(P)

P*A*inv(P)*[0; 1; 0]