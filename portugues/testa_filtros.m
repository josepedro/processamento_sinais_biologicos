function teste_filtros
	clear all; close all;

	[h0,h1,g0,g1] = wfilters('bior6.8');

	[H0,f0] = resposta_freq(h0);

	figure;plot(h0);title('passa-baixas');
	figure;plot(f0,abs(H0));xlabel('Frequencia linear normalizada.');ylabel('Modulo da resposta em frequência.');title('Filtro analise passa-baixas');grid;
	figure;plot(f0,angle(H0));xlabel('Frequencia linear normalizada.');ylabel('Fase da resposta em frequência.');title('Filtro analise passa-baixas');grid;

	condicao = verifica_filtro_QMF(H0,h1,g0,g1,0.001)