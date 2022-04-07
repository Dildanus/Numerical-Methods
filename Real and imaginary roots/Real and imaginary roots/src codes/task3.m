function task3(draw)
syms x;
f=@(x)(-1*x.^4 - 7*x.^3 + 7*x.^2 + 3*x + 9);
df=matlabFunction(diff(f, x));
ddf=matlabFunction(diff(df, x));
accurracy=1e-6;
initial_value=0;
if draw==1
    y=-3:0.01:2;
    plot(y, f(y), '--or');
    legend('f(x) = -1 * x^4 - 7 * x^3 + 7 * x^2 + 3 * x + 9');
    xlabel('x');
    ylabel('y');
end

while abs(f(initial_value)-f(1))>accurracy && abs(f(initial_value)-f(-1))>accurracy && abs(f(-1)-f(1))>accurracy
    [root_Lag, iteration_Lag]=Laguerres(f, initial_value, df, ddf, accurracy);
    if abs(imag(root_Lag)) < accurracy
        fprintf('Iterations Laguerres: %d, Result Laguerres: %f \n', iteration_Lag, root_Lag);
    else
        fprintf('Iterations Laguerres: %d, Result Laguerres: %f%+fj \n', iteration_Lag, real(root_Lag), imag(root_Lag));
    end
    initial_value = 0;
    syms x;
    i=@(x)(x-root_Lag);
    f=@(x)(f(x)./i(x));
    df=matlabFunction(diff(f, x));
    ddf=matlabFunction(diff(df, x));
end

end

function [x, it] = Laguerres(f, x, df, ddf, acc)
it=1;
while it<1000
    c= f(x);
    b= df(x);
    a= ddf(x);
    n = 4;
    r1=(-n*c)/(b+((n-1)*((n-1)*b^2-2*a*c))^(1/2));
    r2=(-n*c)/(b-((n-1)*((n-1)*b^2-2*a*c))^(1/2));
    if abs(r1)>abs(r2)
        root=r2;
    else
        root=r1;
    end
    if abs(root)<acc
        break;
    end
    x=x+root;
    it=it+1;
end
end