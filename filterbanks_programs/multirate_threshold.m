function [y, c_struct_threshold, c_struct_no_threshold] = ...
   multirate_threshold(x, h0, h1, g0, g1, number_levels, relative_threshold);

if (nargin < 7)
  relative_threshold = 0.8;
end

if (length(relative_threshold) == 1)
  relative_threshold = ...
    (2 .^ (0 : number_levels)) * relative_threshold / 2^number_levels;
end

[c, c_struct_no_threshold] = ...
         qmf_multilevel_decomposition...
         (x, h0, h1, number_levels);

c_struct_threshold{number_levels + 1} = 0;

for k = 1 : number_levels + 1
  c = c_struct_no_threshold{k};
  rt = relative_threshold(k);
  c = (c >= rt * max(abs(c))) .* c;
  c_struct_threshold{k} = c;
end

y = qmf_multilevel_reconstruction...
    (c_struct_threshold, g0, g1, number_levels, length(x));

