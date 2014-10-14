clear all; close all; clc

load('ecgsinal', 'ecg', 'fs');
x = ecg; 

[h0, h1, g0, g1] = wfilters('db45');

[y, y_struct] = ...
qmf_multilevel_decomposition...
(x, h0, h1, 5);

figure; plot(x);
figure; plot(y);
