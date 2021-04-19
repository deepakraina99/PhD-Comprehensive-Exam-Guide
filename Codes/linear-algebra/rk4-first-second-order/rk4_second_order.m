% Solution of first order differential equation using
% Runge-Kutta 4 method
clc;
clear all;

% Initial values
h=1; % step-size
x(1)=0;
y(1)=4; % dy
z(1)=5; % ddy
x_des = 2;
n_iter = x_des/h + 1;
for i=2:n_iter
    disp(i)
    x(i) = x(i-1) + h;
    [y(i), z(i)]=rk4_step(i-1,h,x,y,z)
end

% define equation in this function
function dz = g(x,y,z) % second-order
dz = 3*z-2*y;
% dz = (3*z-5*y)/2;
end
function dy = f(x,y,z) % first-order
dy = z;
end

% Runge-kutta method step
function [y_next, z_next] = rk4_step(i,h,x,y,z)
k1 = h*f(x(i),y(i),z(i));
l1 = h*g(x(i),y(i),z(i));
k2 = h*f(x(i) + h/2, y(i) + k1/2, z(i) + l1/2);
l2 = h*g(x(i) + h/2, y(i) + k1/2, z(i) + l1/2);
k3 = h*f(x(i) + h/2, y(i) + k2/2, z(i) + l2/2);
l3 = h*g(x(i) + h/2, y(i) + k2/2, z(i) + l2/2);
k4 = h*f(x(i) + h, y(i) + k3, z(i) + l3);
l4 = h*g(x(i) + h, y(i) + k3, z(i) + l3);
k = [k1 k2 k3 k4]
l = [l1 l2 l3 l4]
y_next = y(i)+(1/6)*(k1+2*k2+2*k3+k4);
z_next = z(i)+(1/6)*(l1+2*l2+2*l3+l4);
end