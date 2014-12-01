clear all; close all; clc

fs = 10000;         % Sampling frequency (samples/sec)
t = -1:1/fs:1;      % Time Vector
w = .8;             % Triangle Width
x = tripuls(t,w);   % Sampled aperiodic triangle
x = repmat(x, 1, 10);
t = linspace(0, 10, length(x));

variance_vector = linspace(1e-14, 1e-4, 1000);
for(k = 1 : length(variance_vector))
    v = variance_vector(k);
    xnoise = x + randn(size(x)) * sqrt(v);
    
    snr_input_dB(k) = 10 * log10 (sum(x.^2) / sum((xnoise - x).^2));
    
    [h0, h1, g0, g1] = wfilters('haar');
    
    [y, c_struct_threshold, c_struct_no_threshold] = multirate_threshold(xnoise, h0, h1, g0, g1, 4, [0 0.2 0.7 0.8  0.9]);

    snr_output_dB(k) = 10 * log10 (sum(x.^2) / sum((y - x).^2));
    if(k/10 == round(k/10))
        disp(k);
    end
end

plot(t, xnoise);
figure;
plot(t, y);

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

