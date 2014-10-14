function h = qmf_filters_iterator(h0, h1, number_levels);

h{number_levels + 1} = h1;
h0iterated = h0;
for (k = number_levels : -1 : 2)
	h{k} = conv(h0, upsample(h{k + 1}, 2));
	
	h0iterated = conv(h0,upsample(h0iterated, 2));
end
h{1} = h0iterated;

L = max([length(h{1}) length(h{2})]);

for (k = number_levels : -1 : 2)
	h{k}=[zeros(1,L-length(h{k})) h{k}];
end 

