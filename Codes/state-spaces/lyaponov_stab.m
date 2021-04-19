clc;
clear;
syms p11 p12 p21 p22
A = [-1 -2; 1 -4];
P = [p11 p12; p21 p22];
R = [1 0; 0 1];

L = A'*P + P*A

eqn1 = L(1,1) == -R(1,1);
eqn2 = L(1,2) == -R(1,2);
eqn3 = L(2,1) == -R(2,1);
eqn4 = L(2,2) == -R(2,2);

[A,B] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4], [p11 p12 p21 p22])

sol = linsolve(A,B)

sol = A\B

P = [sol(1) sol(2); sol(3) sol(4)]

syms x1 x2
assume(x1,'real'); assume(x2,'real');
X = [x1; x2]

v = X'*P*X

dv = X'*(-R)*X

% v = 