function [y, y_struct] = ...
         qmf_multilevel_decomposition...
         (x, h0, h1, number_levels);

y_struct{number_levels + 1} = [];
h = qmf_filters_iterator(h0, h1, number_levels);

downsample_factor = 2 ^ (number_levels);
y_struct{1} = conv(h{1}, x);
y_struct{1} = downsample(y_struct{1}, ...
              downsample_factor);
y = y_struct{1};
y = (y(:)).';

for(k = 2 : number_levels + 1)
	y_struct{k} = conv(h{k}, x);
	y_struct{k} = downsample(y_struct{k}, ...
                      downsample_factor);
	y_ = y_struct{k};
	y_ = (y_(:)).';
	y = [y y_];
	downsample_factor = downsample_factor / 2;
end

if(size(x, 1) > 1 & size(x, 2) == 1)
	y = y(:);
end
