clear all; close all; clc;

load ecgsinal
x = ecg;

[h0, h1, g0, g1] = wfilters('db45');

[y0, y1] = decomposicao_qmf_1nivel(h0, h1, x);
y = [y0; y1];
xr = reconstrucao_qmf_1nivel(g0, g1, y0, y1);

figure; plot((0:length(x) - 1)/fs, x);
figure; plot(y);
figure; plot((0:length(xr) - 1)/fs, xr);
a = axis;
figure(1); axis(a);

h = 0.5*(conv(h0, g0) + conv(h1, g1));
atraso = ceil(length(h)/2) - 1;

xr_adiantado = xr(1 + atraso : end);
L = max([length(xr_adiantado) length(x)])
xr_adiantado(length(xr_adiantado) + 1 : L) = 0;
x(length(x) + 1 : L) = 0;

figure; plot(xr_adiantado - x)

snr_db = 20 * log10(norm(x)/norm(xr_adiantado - x));
snr_db = 10 * log10(norm(x)^2/norm(xr_adiantado - x)^2);
snr = norm(x)^2/norm(xr_adiantado - x)^2;











