clear all; close all; clc

[h0, h1] = wfilters('bior6.8');

[dtfts, frequencies] = dtfts_iterated_qmf_filters...
    (h0, h1, 3, 1e5, 1, 1);
