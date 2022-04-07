function Task2_IterationsOfN(I, task)
%I - is used to define the number of operations
%subpoint - either 'A' or 'B' is used to solve the matrix from task2.a or
%task2.b
n = zeros(I,1);
for i = 1:I
    if task == 'A'
        [r] = mainA((10*2^(i-1)));
        n(i) = norm(r);
    elseif task == 'B'
        [r] = mainB((10*2^(i-1)));
        n(i) = norm(r);
    end
end
plot(n, '-ro');
end