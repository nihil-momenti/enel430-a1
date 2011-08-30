%%
%% Question One and Two
%%
clear;

% Init
C = 5;
b = 1;
f = 1.8;
w = 2 * pi * f;
t_end = 3;

% Calculations
[y1, t1] = y_model(C, b, w, t_end);
[y2, t2] = y_sim(C, b, w, t_end);

% Output
figure(1);

subplot(2,1,1);
plot(t1, y1, t2, y2);
legend('Model', 'Simulation');
xlabel('Time (s)');
ylabel('y');

subplot(2,1,2);
plot(t1, abs(y1-y2));
xlabel('Time (s)');
ylabel('Difference between Model y and Simulated y');

