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
    port (	top_in	  : in unsigned (14 downto 0);
						top_out	  : out unsigned (15 downto 0);
	          clk, rst, pc_en : std_logic
      );
	end component;

	signal top_in : unsigned (14 downto 0);
	signal top_out  : unsigned (15 downto 0);
  signal clk, rst, pc_en  : std_logic;

	begin
	uut:pc_rom port map(top_in => top_in, top_out => top_out, clk => clk, rst => rst, pc_en => pc_en);

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
  		top_in <= "000000000000000";
  		wait for 100 ns;

			top_in <= "000000000000001";
  		wait for 100 ns;

			top_in <= "000000000000010";
  		wait for 100 ns;

			top_in <= "000000000000100";
  		wait for 100 ns;
			wait;
	end process;
end architecture;
