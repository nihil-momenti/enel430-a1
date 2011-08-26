function [y, t] = y_model(C, b, w, t_end)
  frequency = 1000;
  K_p = 60;
  
  K = b * K_p;
  K_bar = 0.06 * b * K_p;
  
  t = [0 : 1/frequency : t_end]';
  A_1 = - (K_bar * C * w) / ( C^2 * w^2 + w^4 - 2 * w^2 * K + K^2 );
  A_2 = - (K_bar * (w^2 - K)) / ( C^2 * w^2 + w^4 - 2 * w^2 * K + K^2 );
  
  y = A_1 .* cos(w * t) + A_2 .* sin(w * t);
