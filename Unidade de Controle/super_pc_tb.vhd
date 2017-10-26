-- Arquitetura e Organização de Computadores
-- Arquivo: pc_tb.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 19/10/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity super_pc_tb is
end;

architecture a_super_pc_tb of super_pc_tb is
	component super_pc
		port (
			clk 		: in std_logic;
			rst 		: in std_logic;
			pc_en 	: in std_logic
		);
	end component;

	signal dado_in, dado_out : unsigned (15 downto 0);
  signal clk, rst, pc_en  : std_logic;

	begin
	uut:super_pc port map(clk => clk, rst => rst, pc_en => pc_en);

	process
  	begin
  		clk <= '0';
  		wait for 50 ns;
  		clk <= '1';
  		wait for 50 ns;
  	end process;

	process
	begin
		rst <= '1';
		wait for 100 ns;
		rst <= '0';
		wait;
	end process;

	process
  	begin
      pc_en <= '1';
			wait;
	end process;
end architecture;
