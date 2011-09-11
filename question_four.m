%%
%% Question Four
%%
clear;

% Init
f = [0.6 : 0.2 : 2.8]';
w = 2 * pi * f;
num = 0;

for i = 1:12
  S = load(['freq' int2str(i) '_data']);
  t{i} = S.(['freq' int2str(i) '_data'])(:,1);
  y{i} = S.(['freq' int2str(i) '_data'])(:,2);
end

% Calculations
[C, b] = identify(y{7}, t{7}, w(7));

fprintf('Question four:\n');
fprintf('Identified cart values:\n');
fprintf('    C: %7.5f\n', C);
fprintf('    b: %7.5f\n\n', b);

for i = 1:12
  [y_m{i}, t_m{i}] = y_model(C, b, w(i), max(t{i}));
  scaled_errors{i} = abs(y_m{i} - y{i}) / mean(abs(y{i}));
  mean_error(i) = mean(scaled_errors{i});
  median_error(i) = median(scaled_errors{i});
  error_bars(i) = 1.65 * std(scaled_errors{i}) / sqrt(1);
end

total_errors = [scaled_errors{1};  scaled_errors{2};  scaled_errors{3};
                scaled_errors{4};  scaled_errors{5};  scaled_errors{6};
                scaled_errors{7};  scaled_errors{8};  scaled_errors{9};
                scaled_errors{10}; scaled_errors{11}; scaled_errors{12};];

total_mean_error = mean(total_errors);
total_median_error = median(total_errors);
total_CI = 1.65 * std(total_errors) / sqrt(1);

% Output

headings = {'Frequency', 'Median error', '90% CI'};
formats = {'%3.1f', '%7.5f', '%7.5f'};
table = [f, median_error', error_bars'];

fprintf('Question Four:\n');
print_table(headings, formats, table);
fprintf(' Totals:\n')
fprintf('    Median Error: %7.5f\n', total_median_error);
fprintf('    90%% CI    : %7.5f\n', total_CI);

%figure(4);
%clf reset;
%hold on;
%for i = 1:12
%  plot(t{i}, scaled_errors{i});
%end
%hold off;

figure(4);
clf reset
hold on
errorbar(w, mean_error, error_bars, 'X');
plot(w, median_error, 'or');
hold off
xlabel('Frequency (radians per second)');
ylabel('Error in predicted cart values');

figure(5);
hist(total_errors, 1000);
ylabel('Count');
xlabel('Error in predicted cart values');
