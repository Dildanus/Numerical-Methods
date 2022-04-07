function task1
clc;
xi = [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5];
yi = [-4.9606; -3.3804; -1.4699; -1.1666; 0.4236; 0.1029; -0.5303; -4.04830; -11.0280; -21.1417; -33.9458];
n = 0; %starting degree of the polynomial

val = 10; %maximal degree of the polynomial

%Here I draw experimental data on the second graph
figure(2);
plot(xi,yi,'o', 'DisplayName', 'Experimental Data');
hold on

%the loop goes up to val,which is the maximal degree of the polynomial so
%that the program doesn't run for ages.
while n <= val
    difference = zeros(n,1); %difference between the aquired result and y from the task
    
    sol = zeros(length(xi),n+1);
    for i = 1:1:length(xi)
        for j = 0:1:n
            sol(i, j+1) = xi(i)^j;
        end
    end
    
    [Q, R] = QRdec(sol);
    solutions = fliplr((R\(Q'*yi))');
    
    result = polyval(solutions, xi);
    for j = 1:n
        difference(j) = abs(yi(j) - result(j));
    end
    error = norm(difference);
    gram_cond = cond(sol'*sol);
    
    %%
    %following code prints coefficients, solution error and condition
    %number of Gram's Matrix
%     fprintf('Degree of polynomial: %d\n', n);
%     disp(solutions);
%     
        fprintf('Solution error:')
        disp(error);
    
    %     fprintf('Condition number of Grams matrix:');
    %     disp(gram_cond);
    %%
    %following code draws two graphs: figure(1) with all polynomials on one
    %graph and figure(2) with plot of the degree that I chose as optimal
    %with one degree higher, to show that they are almost identical.
    x_fit = linspace(-5,5);
    y_fit = polyval(solutions, x_fit);
    
    figure(1);
    subplot(1,2,1)
    plot(x_fit, y_fit, 'DisplayName', sprintf('Poly of deg %d', n));
    grid on;
    xlabel('x');
    ylabel('y');
    title('Plots of all polynomials');
    hold on
    subplot(1,2,2)
    plot(x_fit, y_fit, 'DisplayName', sprintf('Poly of deg %d', n));
    xlabel('x');
    ylabel('y');
    xlim([-5, -3.5]);
    ylim([-15, 5]);
    grid on
    title('Zoomed plots of all polynomials');
    hold on
    
    if n == 3
        figure(2)
        plot(x_fit, y_fit, 'm', 'DisplayName', sprintf('Poly of deg: %d', n));
        hold on
        grid on
        xlabel('x');
        ylabel('y');
        legend show
    end
    
    if n == 4
        figure(2)
        plot(x_fit, y_fit, 'k', 'DisplayName', sprintf('Poly of deg: %d', n));
        hold on
        grid on
        xlabel('x');
        ylabel('y');
        legend show
        hold off
    end
    n = n + 1;
    legend show
end
end
%%
%following function calculates a QR decomposition of a given matrix A.
%Outputs: Q -> orthogonal matrix
%         R -> upper triangular matrix
function [Q, R] = QRdec(A)
[m, n] = size(A);
R = zeros(n,n);
Q = zeros(m,n);
d = zeros(1,n);

for i = 1:1:n
    Q(:,i) = A(:,i);
    R(i,i) = 1;
    d(i) = Q(:,i)'*Q(:,i);
    
    for j = i+1:1:n
        R(i,j) = (Q(:,i)' * A(:,j))/d(i);
        A(:,j) = A(:,j) - R(i,j) * Q(:,i);
    end
end

for i = 1:1:n
    dd = norm(Q(:,i));
    Q(:,i) = Q(:,i)/dd;
    R(i,i:n) = R(i,i:n) * dd;
end
end