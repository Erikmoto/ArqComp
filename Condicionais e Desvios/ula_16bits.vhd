-- Arquitetura e Organização de Computadores
-- Arquivo: mux_16bits_tb.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 21/09/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_16bits is
	port (	entr0, entr1									: in unsigned (15 downto 0);
			sel0											: in unsigned (1 downto 0);
			soma, subtrai, select_maior, modulo_adicao 		: out unsigned (15 downto 0);
			saida											: out unsigned(15 downto 0);
			compara											: out std_logic;
			carry: out std_logic
	);
end entity;


architecture a_ula_16bits of ula_16bits is
	signal soma_s, subtrai_s, select_maior_s, modulo_adicao_s: unsigned(15 downto 0);
	signal soma_carry: unsigned(16 downto 0);
	signal carry_s: std_logic;

	begin
		soma_s <= (entr0 + entr1);
		soma <= soma_s;

		subtrai_s <= (entr0 - entr1);
		subtrai <= subtrai_s;

		select_maior_s <= entr0 when (entr0 > entr1) else entr1;
		select_maior <= select_maior_s;

		modulo_adicao_s <= (soma_s) when (soma_s > "1111111111111111") else ("0000000000000000" - soma_s);
		modulo_adicao <= modulo_adicao_s;

		soma_carry <= ('0' & entr0) + ('0' & entr1);
		carry_s <= soma_carry(16);

		saida <= (soma_s) when sel0 = "00" else
						 (subtrai_s) when sel0 = "01" else
						 (select_maior_s) when sel0 = "10" else
						 (modulo_adicao_s) when sel0 = "11" else
						 "0000000000000000";

		compara <= '1' when (entr0 > entr1) else '0';
	end architecture;
