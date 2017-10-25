-- Arquitetura e Organização de Computadores
-- Arquivo: mux_16bits_tb.vhd
-- Anderson Cottica
-- Erik R. Yamamoto
-- Data 15/09/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_16bits is
	port (	entr0, entr1														  : in unsigned (15 downto 0);
			sel0																				  : in unsigned (1 downto 0);
			soma, subtrai, select_maior, modulo_adicao 		: inout unsigned (15 downto 0);
			saida																				  : out unsigned(15 downto 0);
			compara																			  : out std_logic
	);
end entity;

--Fazer operação de incremento ou decremento

architecture a_ula_16bits of ula_16bits is
begin
		soma <= (entr0 + entr1);
		subtrai <= (entr0 - entr1);
		select_maior <= entr0 when (entr0 > entr1) else entr1;
		modulo_adicao <= (soma) when (soma > "1111111111111111") else (soma + "1111111111111110");
		--media <= ((entr0 + entr1) / "0000000000000010");

		saida <= (soma) when sel0 = "00" else
						 (subtrai) when sel0 = "01" else
						 (select_maior) when sel0 = "10" else
						 (modulo_adicao) when sel0 = "11" else
						 "0000000000000000";

		compara <= '1' when (entr0 > entr1) else
				 		'0';
end architecture;
