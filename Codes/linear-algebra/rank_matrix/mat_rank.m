% Rank of a matrix
clc;
clear all;
A = randi(3,4)
% A =  [1     2     3;
%      1     2     2;
%      1     2     3]
% A=[9 2 3 12; 9 0 5 12; 0 1 -4 0]
true_rank = rank(A)
rank = size(A,1);
rows = size(A,1);
for r=1:1:rank
    if A(r,r)~=0
        for c=1:1:rows
            if c~=r
                multiplier = A(c,r)/A(r,r);
                for i=1:rank
                    A(c,i) = A(c,i) - (multiplier*A(r,i));
                end
            end
        end
    else
        reduce=1;
        for i=r+1:1:rows
            if A(i,r)~=0
                swap(A,r,i,rank)
                reduce=0;
                break
            end
        end
        if reduce==1
            rank = rank -1;
            for i=1:1:rows
                A(i,r) = A(i,rank);
            end
        end
        r = r -1;
    end
end
my_rank = rank
if my_rank ~= true_rank
    disp('error, not matching !!!')
end

function [] = swap(Matrix, row1, row2, col)
for i=1:col
    temp = Matrix(row1,i);
    Matrix(row1,i) = Matrix(row2,i);
    Matrix(row2,i) = temp;
end
end
