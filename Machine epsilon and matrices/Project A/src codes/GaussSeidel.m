function GaussSeidel() %n is the number of linear equations
n = 4;
m = 10000;
tol = 1e-10;
x1 = zeros(n);
A = zeros(n,n+1);
A=[13 2 -8 1 16; 1 10 5 -2 24; 6 2 -23 15 184; 1 2 -1 13 82];
x1=[0 0 0 0];

k = 1;
while  k <= m
   err = 0;
   for i = 1 : n 
      s = 0;
      for j = 1 : n           
          s = s-A(i,j)*x1(j);
      end
      s = (s+A(i,n+1))/A(i,i);
      if abs(s) > err 
        err  = abs(s);
      end
      x1(i) = x1(i) + s;
   end

   if err <= tol 
     break;
   else
     k = k+1;
   end
end
disp(norm(x1));

fprintf('Solution vector after %d iterations is :\n', k-1);
for i = 1 : n 
  fprintf(' %11.8f \n', x1(i));
end