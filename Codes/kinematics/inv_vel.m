% Inverse velocity kinematics
clc;
clear all;
% input and initials
[robo_type, n, joint, al, b, th, a, alpha] = params();
[te, qi, ti, dt, tf] = initials();
q = qi;
i = 1;
Y(i,:) = zeros(1, 2*n);
T(i) = 0;

% solving velocity kinematics
for t = ti:dt:tf
    J = jacobian(q);
    % pinv(J)
    dq = pinv(J)*te;
    % J-inv by LU decomposition
    [L,U] = lu(J);
    y = pinv(L)*te;
    dq = pinv(U)*y;
    % update joint positions
    q = q + dq*dt;
    T(i) = t;
    Y(i,:) = [q', dq'];
    i = i + 1;
end

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

% animation
animate;

