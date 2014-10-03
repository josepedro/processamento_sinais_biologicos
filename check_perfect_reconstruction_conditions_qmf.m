function [p, h, h_] = check_perfect_reconstruction_conditions_qmf(h0, h1, g0, g1, tol);

% [p, h, h_] = check_perfect_reconstruction_conditions_qmf(h0, h1, g0, g1, tol);
%
% Checks whether the decomposition filters  h0, h1 and the reconstruction
% filters g0,  g1 satisfy  the conditions  for perfect  reconstruction in
% a  quadrature  mirror filterbank  (QMF).  The  test uses  a  tolerance,
% specified by  the input  tol, in  defining whether  the alias  term and
% vanishes and whether the  relationship between the reconstructed signal
% and the input signal includes a  single term in the z-transform domain.
% The default value for tol is zero.
% 
% Outputs  p: one  if  the  filters satisfy  the  conditions for  perfect
% reconstruction, with the specified tolerance. Zero otherwise.
% 
% h: vector  with the coeficients  of the polynomial that  represents the
% relation between  the output  of the filterbank  (reconstructed signal)
% and its input, without the alias term, in the z-transform domain.
% 
% h_: vector with  the coeficients of the polynomial  that represents the
% alias  term, in  the  relation  between the  output  of the  filterbank
% (reconstructed signal) and its input.
% =======================================================================
% Prepared by the Biological signals processing class,
% University of Brasilia at Gama
% 02/2014

if nargin < 5
	tol = 0;
end

h = [];
h_ = [];

[n, h] = number_nonzero_elements_sum_products_filters(h0, h1, g0, g1, tol);
if(n > 1)
	p = 0;
else
	h0(2 : 2 : end) = -h0(2 : 2 : end);
	h1(2 : 2 : end) = -h1(2 : 2 : end);
	[n, h_] = number_nonzero_elements_sum_products_filters(h0, h1, g0, g1, tol);
	if(n > 0)
		p = 0;
	else
		p = 1;
	end
end

function [n, h] = number_nonzero_elements_sum_products_filters(h0, h1, g0, g1, tol);
ha = conv(h0, g0);
hb = conv(h1, g1);
ha = ha(:).';
hb = hb(:).';
L = max([length(ha) length(hb)]);
ha = [ha zeros(1, L - length(ha))];
hb = [hb zeros(1, L - length(hb))];
h = 0.5 * (ha + hb);
n = sum(abs(h) > tol);
