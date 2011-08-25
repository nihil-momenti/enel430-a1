%%
%% Question Three
%%
clear;

% Init
C = 5;
b = 1;
f = 1.8;
w = 2 * pi * f;
t_end = 1;

noise_levels = 0.00 : 0.01 : 0.40;
trials = 100;

% Calculations
results = zeros(trials, length(noise_levels),2);
for i = 1 : length(noise_levels)
  for j = 1 : trials
    [y, t] = noisy_model(C, b, w, t_end, noise_levels(i));
    [results(j,i,1), results(j,i,2)] = identify(y, t, w);
  end
end

means = mean(results);

medians = median(results);

errors = 1.65 * std(results) / sqrt(trials);

% Output
headings = {'Noise Level', 'Median (C)', '90% CI (C)', 'Median (b)', '90% CI (b)'};
formats  = {'%4.2f', '%7.5f', '%7.5f', '%7.5f', '%7.5f'};
table = [noise_levels', medians(1,:,1)', errors(1,:,1)', medians(1,:,2)', errors(1,:,2)'];

fprintf('Question Three:\n');
print_table(headings, formats, table);

figure(2);
clf reset;

subplot(2,1,1);
errorbar(noise_levels, means(:,:,1), errors(:,:,1), 'O');
hold on
plot(noise_levels, medians(:,:,1), 'X');
hold off

subplot(2,1,2);
errorbar(noise_levels, means(:,:,2), errors(:,:,2), 'O');
hold on
plot(noise_levels, medians(:,:,2), 'X');
hold off
