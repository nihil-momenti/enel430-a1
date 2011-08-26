%%
%% Question Five
%%
clear;

% Init
K_p = 60;
f = [0.6 : 0.2 : 2.8]';
w = 2 * pi * f;

for i = 1:12
  S = load(['freq' int2str(i) '_data']);
  t{i} = S.(['freq' int2str(i) '_data'])(:,1);
  y{i} = S.(['freq' int2str(i) '_data'])(:,2);
end

% Calculations

C = zeros(12,1);
b = zeros(12,1);
for i = 1:12
  [C(i), b(i)] = identify(y{i}, t{i}, w(i));
  [y_m{i}, t_m{i}] = y_model(C(i), b(i), w(i), max(t{i}));
end
% A = sqrt(A_1^2 + A_2^2)
%   = K_bar / sqrt(C^2 * w^2 + w^4 - 2 * w^2 * K + K^2)
K = b * K_p;
A = (0.06 * K) / sqrt(C.^2 .* w.^2 + w.^4 - 2 * w.^2 .* K + K.^2);
A_db = 20 * log10(A);
% O -> phase
% O = atan(A1 / A2) ( + pi if A2 < 0 )
O = atan((C .* w) ./ (w.^2 - K)) + pi * (sign(w.^2 - K) - 1) / (-2);


% Output

figure(6);
semilogx(w, A_db);
figure(7);
semilogx(w, O);

