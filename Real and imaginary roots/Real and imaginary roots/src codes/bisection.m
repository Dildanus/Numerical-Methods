function [sol, N] = bisection(a, b)
N = 1;
tol = 0.000001;
f = @(x)(3.1 - 3*x - exp(-x));
if (f(a) * f(b) > 0)
    disp("given interval doesnt have any roots");
    return;
end
sol = (a+b)/2;
err = abs(f(sol));
while err > tol
        N = N + 1;
    if f(a) * f(sol) < 0
        b = sol;
    else
        a = sol;
    end
    sol = (a+b)/2;
    err = abs(f(sol));
end
disp(N);
end