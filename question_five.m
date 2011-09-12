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

resps = freqresp(G(7), w);
rsps(:) = resps(1,1,:);
A_m = abs(rsps);
O_m = 180 * angle(rsps) / pi;
A_db_m = 20 * log10(A_m);

error_A = abs((A - A_m) / mean(A_m));
error_O = abs((O - O_m) / mean(O_m));

for i = 1:12
  resps = freqresp(G(i), w);
  rsps(:) = resps(1,1,:);
  A_b(:,i) = abs(rsps);
  O_b(:,i) = 180 * angle(rsps) / pi;
  A_db_b(:,i) = 20 * log10(A_b(:,i));
  error_A_b(:,i) = abs((A_b(:,i) - A) / mean(A_db));
  error_O_b(:,i) = abs((O_b(:,i) - O) / mean(O));
  integrated_error_A(i) = sum(error_A_b(:,i));
  integrated_error_O(i) = sum(error_O_b(:,i));
end


% Output
figure(6);
subplot(2,2,1);
semilogx(w, A_db, w, A_db_m);
xlabel('Frequency (radians per second)');
ylabel('Response Magnitude (dB)');
legend('Measured', 'Model');
axis tight;

subplot(2,2,2);
semilogx(w, error_A);
xlabel('Frequency (radians per second)');
ylabel('Relative Error in Response Magnitude');
axis tight;

subplot(2,2,3);
semilogx(w, O, w, O_m);
xlabel('Frequency (radians per second)');
ylabel('Response Phase (degrees)');
legend('Measured', 'Model');
axis tight;

subplot(2,2,4);
semilogx(w, error_O);
xlabel('Frequency (radians per second)');
ylabel('Relative Error in Response Phase');
axis tight;

figure(8);
subplot(2,2,1);
semilogx(w, A_db_b(:,1), w, A_db_b(:,2), w, A_db_b(:,3), w, A_db_b(:,4), w, A_db_b(:,5), w, A_db_b(:,6), w, A_db_b(:,7), w, A_db_b(:,8), w, A_db_b(:,9), w, A_db_b(:,10), w, A_db_b(:,11), w, A_db_b(:,12), w, A_db);
xlabel('Frequency (radians per second)');
ylabel('Response Magnitude (dB)');
legend('Model 1 (0.6 Hz)', 'Model 2 (0.8 Hz)', 'Model 3 (1.0 Hz)', 'Model 4 (1.2 Hz)', 'Model 5 (1.4 Hz)', 'Model 6 (1.6 Hz)', 'Model 7 (1.8 Hz)', 'Model 8 (2.0 Hz)', 'Model 9 (2.2 Hz)', 'Model 10 (2.4 Hz)', 'Model 11 (2.6 Hz)', 'Model 12 (2.8 Hz)', 'Measured');
axis tight;

subplot(2,2,2);
semilogx(w, error_A_b(:,1), w, error_A_b(:,2), w, error_A_b(:,3), w, error_A_b(:,4), w, error_A_b(:,5), w, error_A_b(:,6), w, error_A_b(:,7), w, error_A_b(:,8), w, error_A_b(:,9), w, error_A_b(:,10), w, error_A_b(:,11), w, error_A_b(:,12));
xlabel('Frequency (radians per second)');
ylabel('Relative Error in Response Magnitude');
legend('Model 1 (0.6 Hz)', 'Model 2 (0.8 Hz)', 'Model 3 (1.0 Hz)', 'Model 4 (1.2 Hz)', 'Model 5 (1.4 Hz)', 'Model 6 (1.6 Hz)', 'Model 7 (1.8 Hz)', 'Model 8 (2.0 Hz)', 'Model 9 (2.2 Hz)', 'Model 10 (2.4 Hz)', 'Model 11 (2.6 Hz)', 'Model 12 (2.8 Hz)');
axis tight;

subplot(2,2,3);
semilogx(w, O_b(:,1), w, O_b(:,2), w, O_b(:,3), w, O_b(:,4), w, O_b(:,5), w, O_b(:,6), w, O_b(:,7), w, O_b(:,8), w, O_b(:,9), w, O_b(:,10), w, O_b(:,11), w, O_b(:,12), w, O);
xlabel('Frequency (radians per second)');
ylabel('Response Phase (degrees)');
legend('Model 1 (0.6 Hz)', 'Model 2 (0.8 Hz)', 'Model 3 (1.0 Hz)', 'Model 4 (1.2 Hz)', 'Model 5 (1.4 Hz)', 'Model 6 (1.6 Hz)', 'Model 7 (1.8 Hz)', 'Model 8 (2.0 Hz)', 'Model 9 (2.2 Hz)', 'Model 10 (2.4 Hz)', 'Model 11 (2.6 Hz)', 'Model 12 (2.8 Hz)', 'Measured');
axis tight;

subplot(2,2,4);
semilogx(w, error_O_b(:,1), w, error_O_b(:,2), w, error_O_b(:,3), w, error_O_b(:,4), w, error_O_b(:,5), w, error_O_b(:,6), w, error_O_b(:,7), w, error_O_b(:,8), w, error_O_b(:,9), w, error_O_b(:,10), w, error_O_b(:,11), w, error_O_b(:,12));
xlabel('Frequency (radians per second)');
ylabel('Relative Error in Response Phase');
legend('Model 1 (0.6 Hz)', 'Model 2 (0.8 Hz)', 'Model 3 (1.0 Hz)', 'Model 4 (1.2 Hz)', 'Model 5 (1.4 Hz)', 'Model 6 (1.6 Hz)', 'Model 7 (1.8 Hz)', 'Model 8 (2.0 Hz)', 'Model 9 (2.2 Hz)', 'Model 10 (2.4 Hz)', 'Model 11 (2.6 Hz)', 'Model 12 (2.8 Hz)');
axis tight;

figure(10);
semilogx(w, C, w, b);
xlabel('Frequency (radians per second)');
ylabel('Value');
legend('C', 'b');
axis tight;

figure(11);
semilogx(w, integrated_error_A, 'x', w, integrated_error_O, 'x');
xlabel('Frequency (radians per second)');
ylabel('Integrated Error');
legend('Magnitude', 'Phase');
axis tight;
