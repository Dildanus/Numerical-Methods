function Adams_PC
%%
interval = [0, 15]; % interval set as in the task
%following values are used to find optimal step by trial and error and also
%compare it to a non-optimal one
optimal_step = 0.01;
nonoptimal_step = 0.3;

x_val = [0, -0.3]; %values of x as set in the task
%%
%rest of the function plots the graphs required to detemine whether the
%chosen step is the optimal one
figure(1)
[t,x] = Calc(interval, x_val, optimal_step);
subplot(2,2,1);
plot(t, x(1,:), 'DisplayName', sprintf('Current step = %0.5f', optimal_step));
hold on

[t,x] = Calc(interval, x_val, nonoptimal_step);
plot(t, x(1,:), 'DisplayName', sprintf('Current step = %0.5f', nonoptimal_step));
hold on
grid on
title('x1(t)');
xlim([0, 15]);
legend show

subplot(2,2,2);
[t,x] = Calc(interval, x_val, optimal_step);
plot(t, x(2,:), 'DisplayName', sprintf('Current step = %0.5f', optimal_step));
hold on

[t,x] = Calc(interval, x_val, nonoptimal_step);
plot(t, x(2,:), 'DisplayName', sprintf('Current step = %0.5f', nonoptimal_step));
hold on;
grid on;
title('x2(t)');
xlim([0, 15]);
legend show

subplot(2,2,3)
[t,x] = Calc(interval, x_val, optimal_step);
plot(t, x(1,:), 'DisplayName', sprintf('Current step = %0.5f', optimal_step));
hold on

[t,x] = Calc(interval, x_val, nonoptimal_step);
plot(t, x(1,:), 'DisplayName', sprintf('Current step = %0.5f', nonoptimal_step));
hold on
grid on
title('x1(t) zoomed in to make it clearer what are the differences');
xlim([4.5, 5.1]);
legend show

subplot(2,2,4)
[t,x] = Calc(interval, x_val, optimal_step);
plot(t, x(2,:), 'DisplayName', sprintf('Current step = %0.5f', optimal_step));
hold on

% [t,x] = Calc(interval, x_val, nonoptimal_step);
% plot(t, x(2,:), 'DisplayName', sprintf('Current step = %0.5f', nonoptimal_step));
% hold on
% grid on
% title('x2(t) zoomed in to make it clearer what are the differences');
% xlim([3, 3.6]);
% legend show
%%
figure(2)
[t,x] = Calc(interval, x_val, optimal_step);
plot(x(1,:), x(2,:), 'DisplayName', sprintf('Current step = %0.5f', optimal_step));
hold on

[t,x] = Calc(interval, x_val, nonoptimal_step);
plot(x(1,:), x(2,:), 'DisplayName', sprintf('Current step = %0.5f', nonoptimal_step));
hold on
grid on
title('x2 versus x1');
legend show
%%
figure (3)
[t45, x45] = ode45(@fun_val, interval, x_val);
[t,x] = Calc(interval, x_val, optimal_step);

subplot(2,2,1);
plot(t45, x45(:,1),'b', 'DisplayName', sprintf('ode45'));
hold on
plot(t, x(1,:), 'r', 'DisplayName', sprintf('Selfmade ode for step %d', optimal_step));
hold on

[t,x] = Calc(interval, x_val, nonoptimal_step);
plot(t, x(1,:), 'g', 'DisplayName', sprintf('Selfmade ode for step %d', nonoptimal_step));
grid on
title('x1(t) calculated with ode45');
legend show

subplot(2,2,2);
[t,x] = Calc(interval, x_val, optimal_step);
plot(t45, x45(:,2), 'b', 'DisplayName', sprintf('ode45'));
hold on
plot(t, x(2,:), 'r', 'DisplayName', sprintf('Selfmade ode for step %d', optimal_step));
hold on

[t,x] = Calc(interval, x_val, nonoptimal_step);
plot(t, x(2,:), 'g', 'DisplayName', sprintf('Selfmade ode for step %d', nonoptimal_step));
grid on
title('x2(t) calculated with ode45');
legend show

subplot(2,2,3)
[t,x] = Calc(interval, x_val, optimal_step);
plot(t45, x45(:,1), 'b', 'DisplayName', sprintf('ode45'));
hold on
plot(t, x(1,:), 'r', 'DisplayName', sprintf('Current step = %0.5f', optimal_step));
hold on

[t,x] = Calc(interval, x_val, nonoptimal_step);
plot(t, x(1,:), 'g', 'DisplayName', sprintf('Current step = %0.5f', nonoptimal_step));
hold on
grid on
title('Graphs zoomed in to make it clearer what are the differences');
xlim([4.2, 5.1]);
legend show

subplot(2,2,4)
[t,x] = Calc(interval, x_val, optimal_step);
plot(t45, x45(:,2), 'b', 'DisplayName', sprintf('ode45'));
hold on
plot(t, x(2,:),'r', 'DisplayName', sprintf('Current step = %0.5f', optimal_step));
hold on

[t,x] = Calc(interval, x_val, nonoptimal_step);
plot(t, x(2,:), 'g', 'DisplayName', sprintf('Current step = %0.5f', nonoptimal_step));
hold on
grid on
title('Graphs zoomed in to make it clearer what are the differences');
xlim([2.7, 3.6]);
legend show
%%
figure(4);
[t,x] = Calc(interval, x_val, optimal_step);
plot(x45(:,1),x45(:,2),'b', 'DisplayName', sprintf('ode45'));
hold on
plot(x(1,:), x(2,:), 'r', 'DisplayName', sprintf('Selfmade ode for step %d', optimal_step));
hold on

[t,x] = Calc(interval, x_val, nonoptimal_step);
plot(x(1,:), x(2,:), 'g', 'DisplayName', sprintf('Selfmade ode for step %d', nonoptimal_step));
grid on
title('x2 versus x1 calculated with ode45 with x2 vesus x1 calculated with our method');
legend show
end
%%
function [out] = fun_val(t, x)
out = [x(2)+x(1)*(0.5-x(1)^2-x(2)^2); -x(1)+x(2)*(0.5-x(1)^2-x(2)^2)];
end
%%
function [t, y] = Calc(interval, x0, step)
%Allocation and initial values
steps = floor(abs(interval(2) - interval(1))/abs(step));
y(:,1) = x0;
t = zeros(1, steps + 1); %time
t(1) = interval(1);
temp_step = step;
new_index = 5;

%Beta parameters taken from the book
Beta_explicit = [1901/720, -2774/720, 2616/720, -1274/720, 251/720];
Beta_implicit = [475/1440, 1427/1440, -798/1440, 482/1440, -173/1440, 27/1440];

for index = 2:5
    %using an algorithm of RK4 to calculate the initial values of the
    %function to later use them in Adam's PC method. It's ran for times in
    %order to reduce any possible errors.
    t(index) = temp_step;
    temp_step = temp_step + step;
    
    k(:,1) = fun_val(t(index-1), y(:,index-1));
    
    k(:,2) = fun_val(t(index-1), y(:,index-1)+step*k(:,1)/2);
    
    k(:,3) = fun_val(t(index-1), y(:,index-1)+step*k(:,2)/2);
    
    k(:,4) = fun_val(t(index-1), y(:,index-1)+step*k(:,3));
    
    y(:,index) = y(:,index-1) + (step/6)*(k(:,1)+2*k(:,2)+2*k(:,3)+k(:,4));
end

for i = temp_step:step:interval(2)
    new_index = new_index + 1;
    t(new_index) = i;
    sum = 0;
    %Prediction
    for j = 1:1:5
        if new_index - j < 1
            break;
        end
        sum = sum + Beta_explicit(j) * fun_val(t(new_index-j), y(:, new_index-j));
    end
    xstep = y(:,new_index-1) + step * sum;
    %Correction
    sum = 0;
    for j = 1:1:5
        if new_index - j < 1
            break;
        end
        sum = sum + Beta_implicit(j+1) * fun_val(t(new_index-j), y(:,new_index-j));
    end
    y(:,new_index) = y(:,new_index-1) + step * sum + step * Beta_implicit(1) * fun_val(t(new_index-1), xstep);
end
end