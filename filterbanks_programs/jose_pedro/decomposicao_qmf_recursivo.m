function [y0, y1] = decomposicao_qmf(h0,h1,y0,i);
	if(i ~= 1)
		i = i - 1;
		[y0, y1] = decomposicao_qmf_1nivel(h0, h1, y0);
		[y0, y1] = decomposicao_qmf(h0, h1, y0, i);		
	else
		[y0, y1] = decomposicao_qmf_1nivel(h0, h1, y0);
	end