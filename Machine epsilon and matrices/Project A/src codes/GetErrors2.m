function errors = GetErrors2(A, B, x, n)
%colculating the error from the formula r = Ax - b
errors = zeros(n, 1);
for i = 1:n
    result = 0;
    for j = i:n
        result = result + A(i,j) * x(j);
    end
    errors(i) = result - B(i);
end
end