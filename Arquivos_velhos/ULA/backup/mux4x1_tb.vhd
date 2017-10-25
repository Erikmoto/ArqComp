library ieee;
use ieee.std_logic_1164.all;

entity mux4x1_tb is
end;

architecture a_mux4x1_tb of mux4x1_tb is
	component mux4x1
		port(entr0, entr1, entr2, entr3, sel0, sel1 : in std_logic; saida : out std_logic);
	end component;
	
	signal entr0, entr1, entr2, entr3, sel0, sel1, saida : std_logic;
	
	begin uut: mux4x1 port map(entr0 => entr0, entr1 => entr1, entr2 => entr2, entr3 => entr3, sel0 => sel0, sel1 => sel1, saida => saida);
	
	process
		begin
			entr0 <= '0';
			entr1 <= '1';
			entr2 <= '0';
			entr3 <= '1';
			sel0 <= '0';
			sel1 <= '0';
			wait for 50 ns;
			sel0 <= '1';
			sel1 <= '0';
			wait for 50 ns;
			sel0 <= '0';
			sel1 <= '1';
			wait for 50 ns;
			sel0 <= '1';
			sel1 <= '1';
			wait for 50 ns;
			wait;
		
	end process;
end architecture;	