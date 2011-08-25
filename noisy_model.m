function [y, t] = noisy_model(C, b, w, t_end, noise_level)
  [y, t] = y_model(C, b, w, t_end);

  % Assuming normally distributed x% noise means normal distribution
  % mean = 1, std deviation = x%.

  y = y .* (1 + noise_level * randn(1,length(y)));
