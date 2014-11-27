clear all; close all; clc;

fs = 10000;
t = -1:1/fs:1;
w = .8;
x = tripuls(t,w);
x = repmat(x,1,10);
t = linspace(0,10,length(x));
plot(t,x);

variance_vector = linspace(1e-4, 1e-4, 1);

for k = 1 : length(variance_vector)
  v = variance_vector(k);
  xnoise = x + randn(size(x)) * sqrt(v);

  [h0, h1, g0, g1] = wfilters('haar');
  [y, c_struct_threshold, c_struct_no_threshold] = multirate_threshold ...
    (xnoise, h0, h1, g0, g1, 4, 0.8);

end

figure;

plot(t, y);
a = axis;

figure; plot(t, xnoise);

axis(a);
