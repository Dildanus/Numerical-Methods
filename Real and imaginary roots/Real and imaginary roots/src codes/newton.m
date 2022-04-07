function newton(guess)
syms x;
f = @(x)(3.1 - 3*x - exp(-x));
df = matlabFunction(diff(f, x));
err = abs(f(guess));
n = 0;
accuracy = 1e-6;

while err > accuracy
    b = guess - (f(guess)/df(guess));
    err = abs(b-guess);
    guess = b;
    n = n + 1;
end
disp(n);
disp(guess);
end