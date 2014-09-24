function [H,f]=resposta_freq(h,N)
	if nargin < 2
		N = 1e6;
	end 
	H = fft(h,N);
	H=fftshift(H);
	f = linspace(-.5,.5,N);