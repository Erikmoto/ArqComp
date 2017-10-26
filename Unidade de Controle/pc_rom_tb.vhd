-- Arquitetura e Organização de Computadores
-- Arquivo: pc_rom_tb.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 19/10/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_rom_tb is
end;

architecture a_pc_rom_tb of pc_rom_tb is
	component pc_rom
    port (
			top_out	  : out unsigned (14 downto 0);
      clk, rst : std_logic
    );
	end component;

	signal top_out  : unsigned (14 downto 0);
  signal clk, rst  : std_logic;

	begin
	uut:pc_rom port map(top_out => top_out, clk => clk, rst => rst);

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
			wait;
	end process;
end architecture;
