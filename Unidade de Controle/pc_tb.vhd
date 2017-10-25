-- Arquitetura e Organização de Computadores
-- Arquivo: pc_tb.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 19/10/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_tb is
end;

architecture a_pc_tb of pc_tb is
	component pc
		port (	clk 		: in std_logic;
						rst 		: in std_logic;
						pc_ena 		: in std_logic;
						pc_in		: in unsigned(15 downto 0);
						pc_out		: out unsigned(15 downto 0)
			);
	end component;

	signal pc_in, pc_out    : unsigned (15 downto 0);
  signal clk, rst, pc_ena  : std_logic;

	begin
	uut:pc port map(pc_in => pc_in, pc_out => pc_out, clk => clk, rst => rst, pc_ena => pc_ena);

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
      pc_ena <= '1';
  		pc_in <= "0000000000000000";
  		wait for 100 ns;

			pc_in <= "0000100000000000";
			wait for 100 ns;

			pc_in <= "0000000001110000";
			wait for 100 ns;

			pc_ena <= '0';
			pc_in <= "1111111111111111";
			wait for 100 ns;
			wait;
	end process;
end architecture;
