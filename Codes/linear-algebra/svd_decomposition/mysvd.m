function [U,S,V] = mysvd(A)

% initial varibles
err_tol=2.27e-13;
size_A=size(A);
max_loops=100*max(size_A);
loop_iter=0;
% U,S,V
U=eye(size_A(1));
S=A';
V=eye(size_A(2));

error=10000;
while error>err_tol & loop_iter<max_loops
    % calculate u and v using qr decomposition
    [Q,S]=qr(S'); 
    U=U*Q;
    [Q,S]=qr(S');
    V=V*Q;
    % calculate error
    TS=triu(S,1); % upper diagonal matrix 
    NTS=norm(TS(:)); % norm
    NS=norm(diag(S));
    if NS==0
        NS=1;
    end
    error=NTS/NS;
    loop_iter=loop_iter+1;
end

% adjust the sign in s
diag_S=diag(S);
S=zeros(size_A);
for i=1:length(diag_S)
    SSN=diag_S(i);
    S(i,i)=abs(SSN);
    if SSN<0
       U(:,i)=-U(:,i);
    end
end

% if nargout<=1
%    u=diag(s);
% end

return
