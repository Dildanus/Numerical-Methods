function Muller(draw, which)
syms x;
f=@(x)(-1*x.^4 - 7*x.^3 + 7*x.^2 + 3*x + 9);
df=matlabFunction(diff(f, x));
ddf=matlabFunction(diff(df, x));
accurracy=1e-6;
initial_value=-6;
if draw==1
    y=-3:0.01:2;
    plot(y, f(y), '--or');
    legend('f(x) = -1 * x^4 - 7 * x^3 + 7 * x^2 + 3 * x + 9');
    xlabel('x');
    ylabel('y');
end
if which ==1
    while abs(f(initial_value)-f(1))>accurracy && abs(f(initial_value)-f(-1))>accurracy && abs(f(-1)-f(1))>accurracy
        [rootMM1, iterationMM1]=MM1(f, -1, 1, initial_value, accurracy);
        if abs(imag(rootMM1)) < accurracy
            fprintf('Iterations MM1: %d, Result MM1: %f \n', iterationMM1, rootMM1);
        else
            fprintf('Iterations MM1: %d, Result MM1: %f%+fj \n', iterationMM1, real(rootMM1), imag(rootMM1));
        end
        syms x;
        i=@(x)(x-rootMM1);
        f=@(x)(f(x)./i(x));
    end
    
else
    
    while abs(f(initial_value)-f(1))>accurracy && abs(f(initial_value)-f(-1))>accurracy && abs(f(-1)-f(1))>accurracy
        [rootMM2, iterationMM2]=MM2(f, initial_value, df, ddf, accurracy);
        if abs(imag(rootMM2)) < accurracy
            fprintf('Iterations MM2: %d, Result MM2: %f \n', iterationMM2, rootMM2);
        else
            fprintf('Iterations MM2: %d, Result MM2: %f%+fj \n', iterationMM2, real(rootMM2), imag(rootMM2));
        end
        initial_value = 0;
        syms x;
        i=@(x)(x-rootMM2);
        f=@(x)(f(x)./i(x));
        df=matlabFunction(diff(f, x));
        ddf=matlabFunction(diff(df, x));
    end
    
end
end


function [x, it]=MM1(f,x_0, x_1, x_2, acc)
a = x_1 - x_0;
b = x_2 - x_1;
delta_1 = (f(x_1)-f(x_0))/a;
delta_2 = (f(x_2)-f(x_1))/b;
del = (delta_2 - delta_1)/(a+b);
it=3;
while it<1000
    i=delta_2+b*del;
    DEL=(i^2-4*f(x_2)*del)^(1/2);
    if abs(i+DEL)>abs(i-DEL)
        j=i+DEL;
    else
        j=i-DEL;
    end
    z=-2*f(x_2)/j;
    x=x_2+z;
    if abs(z)<acc
        break;
    end
    x_0=x_1;
    x_1=x_2;
    x_2=x;
    a = x_1 - x_0;
    b = x_2 - x_1;
    delta_1 = (f(x_1)-f(x_0))/a;
    delta_2 = (f(x_2)-f(x_1))/b;
    del = (delta_2 - delta_1)/(a+b);
    it=it+1;
end
end


function [x, it] = MM2(f, x, df, ddf, acc)
it=1;
while it<1000
    c= f(x);
    b= df(x);
    a= ddf(x);
    r1=(- 2*c)/(b+(b^2-2*a*c)^(1/2));
    r2=(- 2*c)/(b-(b^2-2*a*c)^(1/2));
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



