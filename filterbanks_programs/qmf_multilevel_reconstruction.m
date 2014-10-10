function [xr_no_delay, xr, x_struct, delay] = ...
         qmf_multilevel_reconstruction...
         (y_struct, g0, g1, number_levels, delay);

x_struct{number_levels + 1} = [];
g = qmf_filters_iterator(g0, g1, number_levels);

upsample_factor = 2 ^ (number_levels);
x_struct{1} = upsample(y_struct{1}, ...
              upsample_factor);
x_struct{1} = x_struct{1}(1 : end - (upsample_factor - 1));
x_struct{1} = conv(g{1}, x_struct{1});
x_struct{1} = (x_struct{1}(:)).';
xr = x_struct{1};
L = length(xr);

for(k = 2 : number_levels + 1)
	x_struct{k} = upsample(y_struct{k}, ...
              upsample_factor);
	x_struct{k} = x_struct{k}(1 : end - (upsample_factor - 1));
	x_struct{k} = conv(g{k}, x_struct{k});
	x_struct{k} = (x_struct{k}(:)).';
	upsample_factor = upsample_factor / 2;
	relative_delay = L - length(x_struct{k});
	x_struct{k} = [zeros(1, relative_delay) x_struct{k}];
	xr = xr + x_struct{k};
end

xr_no_delay = xr(abs(relative_delay + delay) + 1 : end);
