function [h, additional_delay] = qmf_filters_iterator...
             (h0, h1, number_levels,...
              complete_zeros_to_the_left);

% 

if nargin < 4
	complete_zeros_to_the_left = 0;
end

h{number_levels + 1} = h1;
h0iterated = h0;
for (k = number_levels : -1 : 2)
	temp = upsample(h{k + 1}, 2);
	temp = temp(1 : end - 1);
	h{k} = conv(h0, temp);
	temp = upsample(h0iterated, 2);
	temp = temp(1 : end - 1);
	h0iterated = conv(h0, temp);
end
h{1} = h0iterated;

additional_delay = 0;
if(complete_zeros_to_the_left)
	h{1} = (h{1}(:)).';
	h{2} = (h{2}(:)).';
	L = max([length(h{1}) length(h{2})]);
	for(k = 1 : length(h))
		h{k} = [zeros(1, L - length(h{k}))...
		        (h{k}(:)).'];
	end
	additional_delay = L - length(h1);
end
