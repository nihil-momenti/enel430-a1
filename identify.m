function [C, b] = identify(y, t, w)
  K_p = 60;

  M = [cos(w * t)' sin(w * t)'];

  result = (M' * M) \ (M' * y');
  A_1 = result(1);
  A_2 = result(2);

  b = (w^2 * (A_1^2 + A_2^2)) / (K_p * (A_1^2 + A_2^2) - 0.06 * K_p * A_2);
  K_bar = 0.06 * b * K_p;
  C = - (A_1 * K_bar) / (w * (A_1^2 + A_2^2));
