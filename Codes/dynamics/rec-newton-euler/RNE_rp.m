function RNE()
clc
clear all
close all

syms th1 th2 b1 b2 dth1 dth2 db1 db2 ddth1 ddth2 ddb1 ddb2 a1 a2 m1 m2 g
assume(th1,'real'); assume(th2,'real'); 
assume(dth1,'real');assume(dth2,'real');
assume(ddth1,'real');assume(ddth2,'real');
assume(b1,'real'); assume(b2,'real'); 
assume(db1,'real');assume(db2,'real');
assume(ddb1,'real');assume(ddb2,'real');assume(a1,'real'); assume(a2,'real'); 
assume(m1,'real'); assume(m2,'real');
assume(g,'real'); 

% -------------------------------------------------------------------------
% Define the DH parameters
N_DOFS = 2;
dh.theta = [th1 0];
dh.alpha = [0 0];
dh.offset = [0 b2];
dh.d = [0 0];
dh.a = [a1 a2];
dh.type = ['r' 'p'];

% -------------------------------------------------------------------------
% Rigid body paramaters: inertia, mass, and cener of mass
rb.m = [m1 m2];
rb.I(:,:,1) = (m1*a1*a1)/12*[0 0 0; 0 1 0; 0 0 1];
rb.I(:,:,2) = (m1*a2*a2)/12*[0 0 0; 0 0 0; 0 0 0];

% In standard DH, COM is mesured respect to its end-effector (using local
% frame). When COM is [0 0 0]', it means the COM is located exactly at the
% end-effector. Therefore, COM usually has negative values, which means the
% COM is behind the end-effector
rb.r = [-a1/2 0 0; -a2/2 0 0]';

% -------------------------------------------------------------------------
% Arbitrary trajectory as the inputs: joint position, velocity, and 
% acceleration
qc = [th1 b1];
qcdot = [dth1 db2];
qcddot = [ddth1 ddb2];

% -------------------------------------------------------------------------
% Here we go!
Q = invdyn(dh, rb, qc, qcdot, qcddot, [0; -g; 0]);

% -------------------------------------------------------------------------
% % For validation purpose, using RVC Toolbox for comparison
% % Disable these lines below if you don't want to try Peter Corkee's RVC 
% % toolbox
% L(1) = Revolute('d', 0, 'a', 0.5, 'alpha', 0, ...
%     'm', rb.m(1), 'I', rb.I(:,:,1), 'r',  rb.r(:,1));
% L(2) = Revolute('d', 0, 'a', 0.5, 'alpha', 0, ...
%     'm', rb.m(2), 'I', rb.I(:,:,2), 'r', rb.r(:,2));
% L(3) = Revolute('d', 0, 'a', 0.5, 'alpha', 0, ...
%     'm', rb.m(3), 'I', rb.I(:,:,3), 'r', rb.r(:,3));
% 
% threelink = SerialLink(L, 'name', 'two link');
% threelink.gravity = [0; -9.8; 0];
% torque_by_rvc_toolbox = threelink.rne(qc, qcdot, qcddot);
% plot(time_span, torque_by_rvc_toolbox(:,1), '-.b', 'LineWidth', 2);
% plot(time_span, torque_by_rvc_toolbox(:,2), '-.r', 'LineWidth', 2);
% plot(time_span, torque_by_rvc_toolbox(:,3), '-.g', 'LineWidth', 2);
% 
% legend('Torque 1', 'Torque 2', 'Torque 3', ...
%     'Torque 1 by RVC', 'Torque 2 by RVC', 'Torque 3 by RVC');

end

% -------------------------------------------------------------------------
function Q = invdyn(dh, rb, qc, qcdot, qcddot, grav)
% Inverse dynamic with recursive Newton-Euler

if nargin < 6
    grav = [0;0;0];
end

z0 = [0; 0; 1];

for k = 1 : length(qc)  
    q = qc(k, :);
    qdot = qcdot(k, :);
    qddot = qcddot(k, :);

    N_DOFS = length(q);
    
    % ---------------------------------------------------------------------
    % Forward recursion
    for i = 1 : N_DOFS
        T = calc_transformation(i-1, i, dh, q);
        R(:,:,i) = T(1:3, 1:3);
        p = [dh.a(i); dh.d(i)*round(sin(dh.alpha(i))); dh.d(i)*round(cos(dh.alpha(i)))];
        d(:,i) = [(1/2)*dh.a(i)*cos(q(i)) (1/2)*dh.a(i)*sin(q(i)) 0];
        r(:,i) = [0 0 b2];

        if i > 1
            w(:, i) =  R(:,:,i-1)'*(w(:, i-1) + z0.*qdot(i));
            wdot(:, i) = R(:,:,i-1)'*(wdot(:, i-1) +  z0.*qddot(i) + ...
                cross(w(:, i-1), z0.*qdot(i)));
            vdot(:,i) = R(:,:,i-1)'*vdot(:,i-1) + ...
                cross(w(:,i),d(:,i));
            v1 = simplify(R(:,:,i-1)'*(vddot(:,i-1)))
            v2 = simplify(cross(wdot(:,i), d(:,i)))
            v3 = simplify(cross(w(:,i), cross(w(:,i),d(:,i))))
            v4 = simplify(cross(wdot(:,i-1),r(:,i-1)))
            v5 = simplify(cross(w(:,i-1), cross(w(:,i-1),r(:,i-1))))
            v145 =v1+v4+v5
%             v145= R(:,:,i-1)'*v1 + v4 + v5
            vddot(:,i) = v145+v2+v3
%             vddot(:,i) = R(:,:,i-1)'*(vddot(:,i-1) + cross(wdot(:,i-1),r(:,i-1)) + ...
%                 cross(w(:,i-1), cross(w(:,i-1),r(:,i-1)))) + cross(wdot(:,i), d(:,i)) + ...
%                 cross(w(:,i), cross(w(:,i),d(:,i)));

        else
            w(:, i) =  (z0.*qdot(i));
            wdot(:, i) = (z0.*qddot(i));
            vdot(:,i) = grav + cross(w(:,i),d(:,i));
            vddot(:,i) = grav + cross(wdot(:,i), d(:,i)) + ...
                cross(w(:,i), cross(w(:,i),d(:,i)));
        end
    end
    simplify(vdot)
    simplify(vddot)
    
    % Dynamic simulation
    % Backward recursion
    for i = N_DOFS:-1:1
%         p = [dh.a(i); dh.d(i)*sin(dh.alpha(i)); dh.d(i)*cos(dh.alpha(i))];
%         
%         vcdot = vdot(:,i) + cross(wdot(:,i),rb.r(:,i)) + ...
%             cross(w(:,i),cross(w(:,i),rb.r(:,i)));
%         
%         F = rb.m(i)*vcdot;
%         N = rb.I(:,:,i)*wdot(:,i)+cross(w(:,i),rb.I(:,:,i)*w(:,1));

        F = rb.m(i)*vddot(:,i);
        N = rb.I(:,:,i)*wdot(:,i)+cross(w(:,i),rb.I(:,:,i)*w(:,i));
        if i < N_DOFS
            f(:,i) = f(:,i+1) + F - rb.m(i)*grav;
            n(:,i) = n(:,i+1) + N + cross(r(:,i), f(:,i+1)) + ...
                cross(d(:,i),F) + N;
        else
            f(:,i) = F - rb.m(i)*R(:,:,i-1)'*grav;
%             syms f21x f21y
%             f21x = f(1,i);
%             f21y = f(2,i);
%             f(:,i) = [f21x;f21y;0]
            n(:,i) = cross(d(:,i),f(:,i)) + N;
        end
        
        T = calc_transformation(i-1, i, dh, q);
        R = T(1:3, 1:3);
        
        if dh.type(i) == 't'
            Q(i,k) = f(:,i)'*R'*z0;
        elseif dh.type(i) == 'r'
            Q(i,k) = simplify(z0'*n(:,i))
        end
    end
end
end

% -------------------------------------------------------------------------
function  T = calc_transformation(from, to, dh, qc)
% Transformation from one joint to another joint
% 0<=from<N_DOFS
% 0<to<=N_DOFS

T = eye(4);
N_DOFS = length(qc);

% Sanity check
if (from >= N_DOFS) || (from < 0) || (to <= 0) || (to >  N_DOFS)
    return;
end

for i = from+1 : to
    if dh.type(i) == 'r'
        dh.theta(i) = qc(i);
    elseif dh.type(i) == 'p'
        dh.d(i) = qc(i);
    end
    
    ct = cos(dh.theta(i) + dh.offset(i));
    st = sin(dh.theta(i) + dh.offset(i));
    ca = cos(dh.alpha(i));
    sa = sin(dh.alpha(i));
    
    T = T * [ ct    -st*ca   st*sa     dh.a(i)*ct ; ...
              st    ct*ca    -ct*sa    dh.a(i)*st ; ...
              0     sa       ca        dh.d(i)    ; ...
              0     0        0         1          ];
end

end
