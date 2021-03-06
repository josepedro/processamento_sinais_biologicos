function [y0, y1] = decomposition_1level_qmf(h0, h1, x);

% [y0, y1] = decomposition_1level_qmf(h0, h1, x);


y0 = conv(h0, x);
y0 = downsample(y0, 2);

y1 = conv(h1, x);
y1 = downsample(y1, 2);
