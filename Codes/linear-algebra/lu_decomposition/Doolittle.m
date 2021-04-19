%% 
clear
clc
disp(' A program for LU decomposition of a square matrix by Doolittle''s method ')
disp('By: Yasin A. Al-Shiboul')
disp('Al-Balqa'' AppliedUniversity,  Amman-Jordan')
disp('Date: 3/6/2005')
% disp('Press Enter to continue')
% pause
% clc
%%
% A = randi([-15 15],3,3)
% A = [1 2 5;0.2 1.6 7.4; 0.5 4 8.5];
A = [9 2 3 12; 9 0 5 12; 0 1 -4 0];
% A = rand(3,3)
[m,n]=size(A);
if m~=n 
    disp('Matrix must be square')
%     beep
end
U=zeros(m);
L=zeros(m);
for j=1:m
    L(j,j)=1;
end
for j=1:m
    U(1,j)=A(1,j);
end
for i=2:m
    for j=1:m
        for k=1:i-1
            s1=0;
            if k==1
                s1=0;
            else
            for p=1:k-1
                s1=s1+L(i,p)*U(p,k);
            end
            end
            L(i,k)=(A(i,k)-s1)/U(k,k);
           end
         for k=i:m
             s2=0;
           for p=1:i-1
               s2=s2+L(i,p)*U(p,k);
           end
           U(i,k)=A(i,k)-s2;
         end
    end
end
disp('The matrix to be decomposed is')
A
disp('The Lower Triangular Matrix is')
L
disp('The Upper Triangular Matrix is')
U
[lo,uo,po]=lu(A)
                  
  