% L : Lower triangular matrix
% U : Upper triangular matrix
clc;
clear all;
disp('----------------------------------')
disp('LU DECOMPOSITION CODE')
disp('----------------------------------')
A = randi([-15 15],3,3)
% A = [1 2 5;0.2 1.6 7.4; 0.5 4 8.5];
% A = [9 2 3 12; 9 0 5 12; 0 1 -4 0];
% A = rand(3,3)
A = [52/3 -3 -2; -3 20/3 -6; -2 -6 40/3]
n=rank(A);

%Initialize L and U matrix
L=zeros(n);
U=eye(n);

for s=1:n
%Perform calculation on column j to determine L components 
j=s;
for i=j:n
    L(i,j)=A(i,j)-L(i,1:(j-1))*U(1:(j-1),j);
end
%Perform calculation on row i to determine U components   
i=s;
U(i,i)=1;
for j=i+1:n
    U(i,j)=(A(i,j)-L(i,1:(i-1))*U(1:(i-1),j))/(L(i,i));
end
end
L
U
%check if L*U=A
check=(L*U)

if check==A
    disp('the equation L*U=A is correct')
else
    disp('error')
end

[lo, uo] = lu(A)