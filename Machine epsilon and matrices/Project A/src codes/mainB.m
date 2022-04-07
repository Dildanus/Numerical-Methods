%function that initializes the matrix A from Task 2.b and performs a
%Gaussian Elimination in order to find the solutions to the system.
function [r] = mainB(n)
%%
A = zeros(n); %initial matrix A
b = zeros(n, 1); %left-hand side of the system of linear equations
x = zeros(n, 1); %solutions;
%%
% matrices init
for i = 1:n
    for j = 1:n
        A(i,j) = 4/(5*(i+j-1));
        if mod(i,2) == 0
            b(i,1) = 0;
        else
            b(i,1) = 1/(2*i);
        end
    end
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