clear all; close all; clc

load ecgsinal;
x = (ecg(:)).';
x = x(1:4096);
[h0, h1, g0, g1] = wfilters('bior6.8');
number_levels = 10;

[y, y_struct] = ...
qmf_multilevel_decomposition...
(x, h0, h1, number_levels);

[xr, xr_delay, x_struct, delay] = ...
qmf_multilevel_reconstruction...
(y_struct, g0, g1, number_levels, length(x));

plot(x);
hold on; plot(xr, 'r');
grid on;
figure; plot(y);
grid on;
figure; plot(xr - x); title('Reconstruction error.');
grid on;







