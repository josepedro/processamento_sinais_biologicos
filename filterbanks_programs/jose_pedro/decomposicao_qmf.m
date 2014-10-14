function [y y_struct] = decomposicao_qmf(h0,h1,sinal,number_levels);

	sinal = (sinal(:)).';
	y_struct{number_levels + 1} = [];
	[y0, y1] = decomposicao_qmf_recursivo(h0,h1,sinal,1);
	y_struct{1} = y1;
	y = y1;

	for(k = 2 : number_levels)
		[y0, y1] = decomposicao_qmf_recursivo(h0,h1,sinal,k);
		y_struct{k} = y1;
		y = [y1 y];
	end
	[y0, y1] = decomposicao_qmf_recursivo(h0,h1,sinal,number_levels);
	y_struct{end} = y0;
	
