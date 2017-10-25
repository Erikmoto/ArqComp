-- Arquitetura e Organização de Computadores
-- Arquivo: mux_16bits_tb.vhd
-- Anderson Cottica
-- Erik R. Yamamoto
-- Data 15/09/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_16bits_tb is
end;

architecture a_mux_16bits_tb of mux_16bits_tb is
	component mux_16bits
		port(entr0, entr1, sel0 : in std_logic; 
			saida : out std_logic
			);
	end component;
	
	signal entr0, entr1, sel0, saida : std_logic;
	
	begin uut: mux_16bits port map(entr0 => entr0, entr1 => entr1, sel0 => sel0, saida => saida);
	
	process
		begin
			entr0 <= "0000000000000000";
			entr1 <= "1111111111111111";
			sel0 <= "00";
			wait for 50 ns;
			sel0 <= "01";
			wait for 50 ns;
			sel0 <= "10";
			wait for 50 ns;
			sel0 <= "11";
			wait for 50 ns;
			wait;
		
	end process;
end architecture;	