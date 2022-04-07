function Jacobi()
n =4;
tol = 1e-10;
m = 10000;
%%
A = [13 2 -8 1 ; 1 10 5 -2 ; 6 2 -23 15 ; 1 2 -1 13];
b = [16 24 184 82];
error = zeros(n, 1);
%%
x0 = zeros(n,1); %initial guess
x = [0 0 0 0]; %solutions
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
end
%%
disp(norm(x));
fprintf('Solution vector after %d iterations is :\n', k-1);
for i = 1 : n
   fprintf(' %11.8f \n', x0(i));
end
end