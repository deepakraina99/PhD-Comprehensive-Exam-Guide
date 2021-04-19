% Homogeneous transformation matrix
clc;
clear all;


N_DOFS = 2;
temp = eye(4);

% RP manipulator
syms b1 b2 th1 th2 a1 a2
b = [0, b2];
theta = [th1, 0];
a = [0, 0];
alpha = [pi/2, 0];
% 
% % RP manipulator
% b = [0, b2];
% theta = [th1, 0];
% a = [0, 0];
% alpha = [-pi/2, pi/2];

% % PR manipulator
% b = [0, b2];
% theta = [-pi/2, th2];
% a = [0, a2];
% alpha = [pi/2, 0];

for i =  1 : 1 : N_DOFS
    ct = cos(theta(i));
    st = sin(theta(i));
    ca =  cos(alpha(i));
    sa = sin(alpha(i));
    
    temp = temp * [ ct    -st*ca   st*sa     a(i)*ct ; ...
        st    ct*ca    -ct*sa    a(i)*st ; ...
        0     sa       ca        b(i)    ; ...
        0     0        0         1         ];
    disp(i)
    temp = vpa(temp,2)
    T = simplify(temp);
end
T = vpa(T,2)