%%'task' is a function that 
function JacobiForSecondTask(n, task)
tol = 1e-10;
m = 1000000;
%%
A = zeros(n);
b = zeros(n,1);
error = zeros(n, 1);
%%
x = zeros(n,1); %solution
x0 = zeros(n,1); %initial guess
x = [0 0 0 0];
%%
if task == 'A'
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
elseif task == 'B'
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
end
%%
k = 1; %iterator, showing the number of iterations of the loop
while k <= m
    err = 0;
    for i = 1:n
        s = 0;
        for j = 1:n
            	s = s + (-A(i,j)) * x0(j);
        end
        x0=x;
        s = (s+b(i))/A(i,i);
        if abs(s) > err 
         err  = abs(s);
        end
        
        x(i) =  x(i)+s;
    end
    if err <= tol
      break;
    else
      k = k+1;
    end
    error = GetErrors2(A, b, x, n);
    plot(error, '-o');
end
fprintf('Solution vector after %d iterations is :\n', k-1);
for i = 1 : n
   fprintf(' %11.8f \n', x0(i));
end
end