%%
%% Question Five
%%
clear;

% Init
K_p = 60;
f = [0.6 : 0.2 : 2.8]';
w = 2 * pi * f;

C = zeros(12,1);
b = zeros(12,1);
frsp = zeros(12,1);
rsps = zeros(12,1);

for i = 1:12
  S = load(['freq' int2str(i) '_data']);
  t{i} = S.(['freq' int2str(i) '_data'])(:,1);
  y{i} = S.(['freq' int2str(i) '_data'])(:,2);
end

% Calculations
for i = 1:12
  [C(i), b(i)] = identify(y{i}, t{i}, w(i));
  G(i) = tf([b(i)*K_p], [1 C(i) b(i)*K_p]);
  frsp(i) = evalfr(G(i), j*w(i));
end

A = abs(frsp);
O = 180 * angle(frsp) / pi;
A_db = 20 * log10(A);

for i = 1:12
  resps = freqresp(G(7), w);
  rsps(:) = resps(1,1,:);
  A_m(i) = abs(rsps);
  O_m(i) =  180 * angle(rsps) / pi;
  A_m_db(i) = 20 * log10(A_b);
end

error_A = abs((A - A_b) / mean(A_b));
error_O = abs((O - O_b) / mean(O_b));

% Output
figure(6);
subplot(2,1,1);
semilogx(w, A_db, w, A_db_b);
xlabel('Frequency (radians per second)');
ylabel('Response Magnitude (dB)');
legend('Measured', 'Model (Bode)');
axis tight;

subplot(2,1,2);
semilogx(w, error_A);
xlabel('Frequency (radians per second)');
ylabel('Error in Response Magnitude');
axis tight;

figure(7);
subplot(2,1,1);
semilogx(w, O, w, O_b);
xlabel('Frequency (radians per second)');
ylabel('Response Phase (degrees)');
legend('Measured', 'Model');
axis tight;

subplot(2,1,2);
semilogx(w, error_O);
xlabel('Frequency (radians per second)');
ylabel('Error in Response Phase');
axis tight;
