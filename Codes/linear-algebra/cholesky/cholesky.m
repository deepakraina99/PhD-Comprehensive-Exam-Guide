function L = cholesky(A)
% Program to find LU decomposition of Matrix A using Cholesky Algorithm
% (For symmetric positive -definite Matrices)
% U = L'
%==========================================================================
% INPUTS:
%==========================================================================
% Matrix, A (n-by-n)
%==========================================================================
% OUTPUT:
%==========================================================================
% Lower Traingular Matrix, L
%==========================================================================
% Version 1.0
%==========================================================================
% Author : Arshad Afzal, India, Email: arshad.afzal@gmail.com 
%==========================================================================

fprintf('\n         ==================================================================================');
fprintf('\n                      Matrix Decomposition using Cholesky Algorithm ');
fprintf('\n         ==================================================================================');


%==========================================================================
[~, n] = size(A);
%==========================================================================

% Check for symmetry fo the Matrix
t = issymmetric(A);
if t == 0
    fprintf('\n\nAlgorithm Terminated.\n');
    fprintf('\nNon-symmetric matrix.\n');
    return
end

% Check for singular/ ill-conditioned Matrix
r = rank(A);
if r < n
    fprintf('\n\nAlgorithm Terminated.\n');
    fprintf('\nRank deficient matrix. Full cholesky decomposition not possible.\n');
    return
end

% Initialization

L = zeros(n,n);

%==========================================================================
% Main Program
%==========================================================================

for j = 1:n
    
    sum = 0;
    
    for k = 1:j-1
        sum = sum + (L(j,k))^2;
    end
        
    L(j,j) = sqrt(A(j,j)-sum);

    for i = j+1:n
        sum = 0;

        for k = 1:j-1
             sum = sum + L(i,k)*L(j,k);
        end

    L(i,j) = (A(i,j)-sum)/L(j,j);
    end
            
end  

end
    