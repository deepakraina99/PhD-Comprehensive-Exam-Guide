% Solution of first order differential equation using
% Runge-Kutta 4 method
clc;
clear all;

% Initial values
h=0.1; % step-size
y(1)=1;
x(1)=0;
y_des = 0.4;
n_iter = y_des/h + 1;
for i=2:n_iter
    disp(i)
    x(i) = x(i-1) + h;
    y(i)=rk4_step(i-1,h,x,y);
end

% define first order equation in this function
function dy = f(x,y)
dy = 1-x+4*y;
end

% Runge-kutta method step
function y_next = rk4_step(i,h,x,y)
k1 = h*f(x(i),y(i));
k2 = h*f(x(i) + h/2, y(i) + k1/2);
k3 = h*f(x(i) + h/2, y(i) + k2/2);
k4 = h*f(x(i) + h, y(i) + k3);
y_next = y(i)+(1/6)*(k1+2*k2+2*k3+k4);
end