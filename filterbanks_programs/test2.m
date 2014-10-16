clear all; close all; clc

load('ecgsinal');
x = ecg;

[h0, h1, g0, g1] = wfilters('haar');
[p, h, h_] = check_perfect_reconstruction_conditions_qmf(h0, h1, g0, g1);
delay = find(abs(h) == max(abs(h)));
delay = delay(1) - 1;
number_levels = 1;

[y, y_struct] = ...
qmf_multilevel_decomposition...
(x, h0, h1, number_levels);

[xr, xr_delay, x_struct] = ...
qmf_multilevel_reconstruction...
(y_struct, g0, g1, number_levels, length(x));
figure; plot(x);
figure; plot(y);
figure; plot(xr, 'r');
