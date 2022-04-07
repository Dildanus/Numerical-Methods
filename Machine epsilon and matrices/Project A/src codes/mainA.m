%function that initializes the matrix A from Task 2.a and performs a
%Gaussian Elimination in order to find the solutions to the system.
function [r] = mainA(n)
%%
A = zeros(n); %initial matrix A
b = zeros(n, 1); %left-hand side of the system of linear equations
x = zeros(n, 1); %solutions
%%
% matrices init
for i = 1:n
    for j = 1:n
        if i == j
            A(i, j) = 13;
        elseif i == j-1 || i == j+1
            A(i, j) = 4;
        end
    end
    b(i) = 2.4 + 0.6*i;
    x(i) = i;
end
%%
%Performing Gaussian Elimination with partial pivoting
[A,b,x] = gepp(A,b,n);
%%
%Finding the residuum r and applying residual correction in order to check
%whether the results improve
r = GetErrors2(A,b,x,n);
[A,b,x_corr] = gepp(A,r,n);
x1 = x - x_corr;
plot(x1, '-o');
end