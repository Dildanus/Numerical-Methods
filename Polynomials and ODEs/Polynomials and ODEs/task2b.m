%%
function task2b
clc;
interval = [0,15]; %interval set in the task
init_step = 4; %initial step. I chose 4 becuase it gives a very smooth result

%both errors were chosen to be very small but not smaller than machine
%epsilon
relative = 1e-10;
absolute = 1e-10;

%the result should be much grater than min_step so if the result is
%smaller then something went wrong and the program should give throw an
%error
min_step = 1e-6;

x_val = [0, -0.3]; %initial values set in the task

%using Runge-Kutta method with variable step for values described above
[x ,t, error_error, step] = RungeKuttaVar(init_step, relative, absolute, min_step, interval, x_val);

%%
%the rest of the function draws all the graphs
figure(1)
plot(t, error_error(1,:), 'DisplayName', sprintf('Error estiamtion for x1'));
hold on
plot(t, error_error(2,:), 'DisplayName', sprintf('Error estiamtion for x2'));
grid on
title('Error plot with respect to time');
xlabel('t');
ylabel('Error');
legend show
%%
figure(2)
subplot(2,1,1);
plot(t, x(1,:));
grid on
title('x1(t)');
subplot(2,1,2)
plot(t, x(2,:));
grid on
title('x2(t)');
%%
figure(3)
plot(x(1,:), x(2,:));
grid on
ylabel('x2');
xlabel('x1');
title('x2 versus x1');
%%
figure(4)
plot(t, step);
grid on
xlabel('t');
ylabel('step');
title('Step plot with respect to time');

end
%%
%the following function uses Runge-Kutta implementation from the previous
%task with a change so that it can adjust the step on its own
function [x ,t, error_error, step] = RungeKuttaVar(init_step, relative, absolute, min_step, interval, x_val)
T = 5;
different_step = 0.9; %taken from the flowchart from the report
step(1) = init_step; %seting the initial value of the step
error_error(:,1) = [0,0]; %preallocating data for later use for the error;
n = 1;
steps = floor(abs(interval(2) - interval(1))/abs(step)); %calculating the number of iterations
t = zeros(1, steps+1);
t(1) = interval(1);

x(:, 1) = x_val;

while t(n) + step(n) < interval(2)
    %calculating Runge-Kutta for a fullstep
    k(:,1) = fun_val(t(n), x(:,n));
    
    k(:,2) = fun_val(t(n), x(:,n)+step(n)*k(:,1)/2);
    
    k(:,3) = fun_val(t(n), x(:,n)+step(n)*k(:,2)/2);
    
    k(:,4) = fun_val(t(n), x(:,n)+step(n)*k(:,3));
    
    full_step = x(:, n) + step(n)/6*(k(:, 1)+2*k(:, 2)+2*k(:, 3)+k(:, 4));
    
    step2 = step(n)/2;
    half_step = x(:,n);
    
    x(:,n+1) = full_step;
    %calculating the Runge-Kutta again, this time with half of the original
    %step-size
    for i = 1:1:2
        k(:,1) = fun_val(t(n), half_step);
        k(:,2) = fun_val(t(n), half_step + step2*k(:,1)/2);
        k(:,3) = fun_val(t(n), half_step + step2*k(:,2)/2);
        k(:,4) = fun_val(t(n), half_step + step2*k(:,3));
        
        half_step = half_step + step2/6 * (k(:,1) + 2 * k(:,2) + 2 * k(:,3) + k(:,4));
    end
    
    %estimating the error of the calculations
    error_estim = (half_step - full_step)/(2^4 - 1);
    error_error(:,n+1) = error_estim;
    ei = abs(half_step)*relative + absolute;
    
    alpha = min((ei./abs(error_estim)).^(1/5));
    
    %calculating the new step-size according to the flowchart from the
    %report
    step_p = different_step * alpha * step(n); %value of the step calculated according to the formula on the flowchart
    if different_step*alpha >= 1
        if t(n) + step(n) == interval(2)
           return 
        end
        t(n+1) = t(n) + step(n);
        step(n+1) = min([step_p,T*step(n),interval(2)-t(n)]);
        n = n+1;
    else
        if step_p < min_step
            error("Solution not possible with chosen accuracy ");
        else
            step(n) = step_p;
        end
    end
end
end
%Here I combine two functions given in the task into one for convinience
function [out] = fun_val(t, x)
out = [x(2)+x(1)*(0.5-x(1)^2-x(2)^2); -x(1)+x(2)*(0.5-x(1)^2-x(2)^2)];
end