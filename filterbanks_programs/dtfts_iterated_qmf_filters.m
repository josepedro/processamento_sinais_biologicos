function [dtfts, frequencies] = dtfts_iterated_qmf_filters...
(h0, h1, number_levels, number_frequency_points, plot_dtfts,...
normalize_frequency_response);

if(nargin < 4)
	number_frequency_points = 1e5;
end

if(nargin < 5)
	plot_dtfts = 0;
end

if(nargin < 6)
	normalize_frequency_response = 0;
end

h = qmf_filters_iterator(h0, h1, number_levels, 0);


frequencies = linspace(-0.5, 0.5, number_frequency_points);
for(k = 1 : number_levels + 1)
	dtfts{k}=fftshift(fft(h{k}, number_frequency_points));
	if(max(abs(dtfts{k})))
		M = max(abs(dtfts{k}));
	end
end

if(normalize_frequency_response)
	for(k = 1 : number_levels + 1)
		dtfts{k} = dtfts{k} / max(abs(dtfts{k}));
	end
end

colors = {'r'; 'b'; 'k'; 'g'};

if(plot_dtfts)
	figure;
	for(k = 1 : number_levels + 1)
		plot(frequencies, abs(dtfts{k}),...
		     colors{1 + mod(k - 1, length(colors))});
		hold on;
	end
	a = axis;
	if(~normalize_frequency_response)
		axis([0 0.5 a(3) a(4)]);
	else
		axis([0 0.5 a(3) a(4)+.5]);
	end
	grid on;
	xlabel('Normalized frequency');
	ylabel('DTFT (magnitude) of the iterated QMF filters')
end











