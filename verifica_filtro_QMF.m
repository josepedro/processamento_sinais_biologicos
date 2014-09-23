function y = verifica_filtro_QMF(H0, H1, G0, G1)
	
	max_array = [length(H0) length(H1) length(G0) length(G1)];


	if(max(max_array) == mean(max_array))
		%não faz nada
	else
		H0(length(H0) + 1 : max(max_array)) = 0;
		H1(length(H1) + 1 : max(max_array)) = 0;
		G0(length(G0) + 1 : max(max_array)) = 0;
		G1(length(G1) + 1 : max(max_array)) = 0;
	end

	condicao = -1;

	%primeira condicao
	resultado_condicao_1 = conv(H0, G0) + conv(H1,G1);
	if (length(resultado_condicao_1) -  sum(resultado_condicao_1(:) == 0) == 1)
		condicao = condicao + 1;
	end

	%segunda condicao
	 H0_ = H0.*[(-1).^(0:length(H0)-1)];
	 H1_ = H1.*[(-1).^(0:length(H1)-1)];
	resultado_condicao_2 = conv(H0_, G0);
	resultado_condicao_2 = resultado_condicao_2 + conv(H1_, G1);
	if (sum(resultado_condicao_2) == 0)
		condicao = condicao + 1;
	end

	if (condicao ~= 1)
		condicao = 0;
	end

	y = condicao;