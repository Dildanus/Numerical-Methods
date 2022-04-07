function newton_task2(guess)
syms x;
f = @(x)(-1*x.^4 - 7*x.^3 + 7*x.^2 + 3*x + 9);
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