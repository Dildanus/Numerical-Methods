function RungeKutta
%%
%declaring interval and values of x (x_val) given in the task
interval = [0, 15];
% x_val = [0, -0.3];
x_val = [8,7];

optimal_step = 0.01; %I set a new variable to make it easier to look for the step
nonoptimal_step = 0.3; %Similar as above, I set a new variable to make it easier to draw a non-optimal step

%%
%drawing plots of two different step-sizes to show why 0.01 is the most optimal
%one
figure(1)

[x,t] = Calc(nonoptimal_step, interval, x_val);
subplot(2,2,1);
plot(t, x(1,:), 'DisplayName', sprintf('Current step = %0.5f', nonoptimal_step));
hold on

[x,t] = Calc(optimal_step, interval, x_val);
plot(t, x(1,:), 'DisplayName', sprintf('Current step = %0.5f', optimal_step));
hold on
grid on
title('x1(t)');
xlim([0, 15]);
legend show


[x,t] = Calc(nonoptimal_step, interval, x_val);
subplot(2,2,2);
plot(t, x(2,:), 'DisplayName', sprintf('Current step = %0.5f', nonoptimal_step));
hold on

[x,t] = Calc(optimal_step, interval, x_val);
plot(t, x(2,:), 'DisplayName', sprintf('Current step = %0.5f', optimal_step));
hold on;
grid on;
title('x2(t)');
xlim([0, 15]);
legend show

subplot(2,2,3)
[x,t] = Calc(nonoptimal_step, interval, x_val);
plot(t, x(1,:), 'DisplayName', sprintf('Current step = %0.5f', nonoptimal_step));
hold on

[x,t] = Calc(optimal_step, interval, x_val);
plot(t, x(1,:), 'DisplayName', sprintf('Current step = %0.5f', optimal_step));
hold on
grid on
title('x1(t) zoomed in to make it more clear what are the steps');
xlim([4.4, 5.01]);
legend show

subplot(2,2,4)
[x,t] = Calc(nonoptimal_step, interval, x_val);
plot(t, x(2,:), 'DisplayName', sprintf('Current step = %0.5f', nonoptimal_step));
hold on

[x,t] = Calc(optimal_step, interval, x_val);
plot(t, x(2,:), 'DisplayName', sprintf('Current step = %0.5f', optimal_step));
hold on
grid on
title('x2(t) zoomed in to make it more clear what are the steps');
xlim([2.92, 3.45]);
legend show

%%
%x2 versus x1 on one plot for non optimal and optimal step-sizes
figure(2)
[x,t] = Calc(nonoptimal_step, interval, x_val);
plot(x(1,:), x(2,:),'r', 'DisplayName', sprintf('Step = %0.5f', nonoptimal_step));
hold on

[x,t] = Calc(optimal_step, interval, x_val);
plot(x(1,:), x(2,:),'b', 'DisplayName', sprintf('Step = %0.5f', optimal_step));
hold on
grid on
title(sprintf('x2 versus x1'));
legend show

%%
%comparing x1(t) and x2(t) graphs for optimal and non-optimal step-sizes to built-in matlab function
%ode45
figure(3)
%optimal stepsize obtained by trial and error is 0.01
[t45, x45] = ode45(@fun_val, interval, x_val);

subplot(2,2,1);
%Here I draw two graphs: one for a non-optimal step-size and one for an
%optimal step-size
[x,t] = Calc(nonoptimal_step, interval, x_val);
plot(t45, x45(:,1),'b', 'DisplayName', sprintf('ode45'));
hold on
plot(t, x(1,:), 'r', 'DisplayName', sprintf('Selfmade ode for step %d', nonoptimal_step));
hold on

[x,t] = Calc(optimal_step, interval, x_val);
plot(t, x(1,:), 'g', 'DisplayName', sprintf('Selfmade ode for step %d', optimal_step));
grid on
title('x1(t) calculated with ode45');
legend show

subplot(2,2,2);
[x,t] = Calc(nonoptimal_step, interval, x_val);
plot(t45, x45(:,2), 'b', 'DisplayName', sprintf('ode45'));
hold on
plot(t, x(2,:), 'r', 'DisplayName', sprintf('Selfmade ode for step %d', nonoptimal_step));
hold on

%Reseting the step size to show that 0.02 fits worse than 0.01
[x,t] = Calc(optimal_step, interval, x_val);
plot(t, x(2,:), 'g', 'DisplayName', sprintf('Selfmade ode for step %d', optimal_step));
grid on
title('x2(t) calculated with ode45');
legend show

subplot(2,2,3);
%Here I draw two graphs: one for a non-optimal step-size and one for an
%optimal step-size
[x,t] = Calc(nonoptimal_step, interval, x_val);
plot(t45, x45(:,1),'b', 'DisplayName', sprintf('ode45'));
hold on
plot(t, x(1,:), 'r', 'DisplayName', sprintf('Selfmade ode for step %d', nonoptimal_step));
hold on

[x,t] = Calc(optimal_step, interval, x_val);
plot(t, x(1,:), 'g', 'DisplayName', sprintf('Selfmade ode for step %d', optimal_step));
grid on
title('Zoomed in graph to make the differences clearer');
xlim([4.28, 5.13]);
legend show
subplot(2,2,4);
[x,t] = Calc(nonoptimal_step, interval, x_val);
plot(t45, x45(:,2), 'b', 'DisplayName', sprintf('ode45'));
hold on
plot(t, x(2,:), 'r', 'DisplayName', sprintf('Selfmade ode for step %d', nonoptimal_step));
hold on

%Reseting the step size to show that 0.02 fits worse than 0.01
[x,t] = Calc(optimal_step, interval, x_val);
plot(t, x(2,:), 'g', 'DisplayName', sprintf('Selfmade ode for step %d', optimal_step));
grid on
title('Zoomed in graph to make the differences clearer');
xlim([2.76, 3.6]);
legend show

%%
%comparing x2 versus x1 of the selfmade ode calculator to the one built in
%matlab
figure(4);
[x,t] = Calc(nonoptimal_step, interval, x_val);
plot(x45(:,1),x45(:,2),'b', 'DisplayName', sprintf('ode45'));
hold on
plot(x(1,:), x(2,:), 'r', 'DisplayName', sprintf('Selfmade ode for step %d', nonoptimal_step));
hold on

%Reseting the step size to show that 0.02 fits worse than 0.01
[x,t] = Calc(optimal_step, interval, x_val);
plot(x(1,:), x(2,:), 'g', 'DisplayName', sprintf('Selfmade ode for step %d', optimal_step));
grid on
title('x2 versus x1 calculated with ode45 with x2 vesus x1 calculated with our method');
legend show

end
%%
%function that stores both ODE in one array for convinience.

function [out] = fun_val(t, x)
out = [x(2)+x(1)*(0.5-x(1)^2-x(2)^2); -x(1)+x(2)*(0.5-x(1)^2-x(2)^2)];
end
%%
%function that calculates x and t values using RK4 method

function [y, t] = Calc(step, interval, x_val)
steps = floor(abs(interval(2) - interval(1))/abs(step));
index = 1;
t = zeros(1, steps + 1);
t(1) = interval(1);
y(:,1) = x_val;
for i = interval(1) + step:step:interval(2)
    
    k(:,1) = fun_val(t(index), y(:,index));
    
    k(:,2) = fun_val(t(index), y(:,index)+step*k(:,1)/2);
    
    k(:,3) = fun_val(t(index), y(:,index)+step*k(:,2)/2);
    
    k(:,4) = fun_val(t(index), y(:,index)+step*k(:,3));
    
    %evaluating new y for next iteration
    index = index + 1;
    t(index) = i;
    
    y(:,index) = y(:,index-1) + (step/6)*(k(:,1)+2*k(:,2)+2*k(:,3)+k(:,4));
end
end
%%