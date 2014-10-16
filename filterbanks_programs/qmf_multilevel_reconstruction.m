function [xr_no_delay, xr, x_struct, delay] = ...
         qmf_multilevel_reconstruction...
         (y_struct, g0, g1, number_levels, N);

x_struct{number_levels + 1} = [];
[g, additional_delay] = qmf_filters_iterator...
             (g0, g1, number_levels, 1);

upsample_factor = 2 ^ (number_levels);
x_struct{1} = upsample(y_struct{1}, ...
              upsample_factor);
x_struct{1} = x_struct{1}(1 : end - (upsample_factor - 1));
x_struct{1} = conv(g{1}, x_struct{1});
x_struct{1} = (x_struct{1}(:)).';
xr = x_struct{1};

for(k = 2 : number_levels + 1)
	x_struct{k} = upsample(y_struct{k}, ...
              upsample_factor);
	x_struct{k} = x_struct{k}(1 : end - (upsample_factor - 1));
	x_struct{k} = conv(g{k}, x_struct{k});
	x_struct{k} = (x_struct{k}(:)).';
	upsample_factor = upsample_factor / 2;
	L = max([length(xr) length(x_struct{k})]);
	xr = [xr zeros(1, L - length(xr))] + [x_struct{k} zeros(1, L - length(x_struct{k}))];
end

delay = additional_delay + length(g1) - 1;
% delay = (2^(number_levels) - 1) * (length(g1) - 1);

xr_no_delay = xr(1 + delay : end);
if(nargin >= 5)
	%disp(length(xr_no_delay))
	%disp(N)
	xr_no_delay = xr_no_delay(1 : N);
end

%figure; plot(xr_no_delay, 'r');