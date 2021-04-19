
robo_type = 2;
[joint, b, th, a, alpha] = dh_params(robo_type);

% generating HTM matrices
T = fwd_kine(b,th,a,alpha);

% z-axis of joints
z(:,1)=sym([0;0;1]);
for i=1:(length(joint)-1)
    z(:,i+1)=T(1:3,3,i);
end

% jacobian
if joint(1)==1
    jacob=[cross(z(:,1),(T(1:3,4,length(joint))-[0;0;0]));z(:,1)];
else
    jacob=[z(:,1);[0;0;0]];
end
for i=2:length(joint)
    if joint(i)==1
        jacob=horzcat(jacob,[cross(z(:,i),(T(1:3,4,length(joint))-T(1:3,4,i-1)));z(:,i)]);
    else
        jacob=horzcat(jacob,[z(:,i);[0;0;0]]);
    end
end

J = simplify(jacob)