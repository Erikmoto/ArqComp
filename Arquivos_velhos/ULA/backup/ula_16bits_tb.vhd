-- Arquitetura e Organização de Computadores
-- Arquivo: mux_16bits_tb.vhd
-- Anderson Cottica
-- Erik R. Yamamoto
-- Data 15/09/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_16bits_tb is
end;

architecture a_ula_16bits_tb of ula_16bits_tb is
	component ula_16bits
		port (	entr0, entr1										  			: in unsigned (15 downto 0);
			sel0																	  			: in unsigned (1 downto 0);
			soma, subtrai, select_maior, modulo_adicao 		: inout unsigned (15 downto 0);
			saida																	  			: out unsigned(15 downto 0);
			compara																  			: out std_logic
		);
	end component;

	signal entr0, entr1, saida, soma, subtrai, select_maior, maior_igual, modulo_adicao : unsigned (15 downto 0);
	signal sel0 : unsigned (1 downto 0);
	signal compara : std_logic;

	begin uut : ula_16bits port map(entr0 => entr0, entr1 => entr1,
																	sel0 => sel0,
																	saida => saida, subtrai => subtrai, select_maior => select_maior, modulo_adicao => modulo_adicao,
																	compara => compara);

	process
		begin
			-- Teste Soma
			entr0 <= "0000000000000000"; -- 0
			entr1 <= "1111111111111111"; -- -1
			sel0 <= "00";
			-- saida = "FFFF_h" = -1
			wait for 50 ns;
			entr0 <= "1111111111111111"; -- -1
			entr1 <= "1111111111111111"; -- -1
			sel0 <= "00";
			wait for 50 ns;
			-- saida = "FFFE_h" = -2

			-- Teste Subtração
			entr0 <= "1111111111111111"; -- -1
			entr1 <= "0000000000000000"; -- 0
			sel0 <= "01";
			wait for 50 ns;
			-- saida = "FFFF_h" = -1
			entr0 <= "0000000000000000"; -- 0
			entr1 <= "1111111111111111"; -- -1
			sel0 <= "01";
			wait for 50 ns;
			-- saida = "0001_h" = +1

			-- Teste Seleciona Maior
			entr0 <= "0000000000000000"; -- 0
			entr1 <= "0000000000000000"; -- 0
			sel0 <= "10";
			wait for 50 ns;
			-- saida = "0000_h" = 0
			entr0 <= "0000000000000000"; -- 0
			entr1 <= "1111111111111111"; -- -1
			sel0 <= "10";
			wait for 50 ns;
			-- saida = "FFFF_h" = -1
			entr0 <= "1111111111111111"; -- -1
			entr1 <= "0000000000000000"; -- 0
			sel0 <= "10";
			wait for 50 ns;
			-- saida = "FFFF_h" = -1

			-- Teste Módulo da Adição
			entr0 <= "1111111111111111"; -- -1
			entr1 <= "0000000000000000"; -- 0
			sel0 <= "11";
			wait for 50 ns;
			-- saida = "0001_h" = 1
			entr0 <= "0000000000000000"; -- 0
			entr1 <= "1111111111111111"; -- -1
			sel0 <= "11";
			wait for 50 ns;
			-- saida = "0001_h" = 1

			wait;

	end process;
end architecture;
