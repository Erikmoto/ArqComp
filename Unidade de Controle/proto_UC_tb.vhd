-- Arquitetura e Organização de Computadores
-- Arquivo: proto_UC_tb.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 19/10/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity proto_UC_tb is
end;

architecture a_proto_UC_tb of proto_UC_tb is
	component proto_UC
    port (	uc_in	  : in unsigned (15 downto 0);
            clk, rst, pc_en : in std_logic
      );
	end component;

	signal uc_in    : unsigned (15 downto 0);
  signal clk, rst, pc_en  : std_logic;

	begin
	uut:proto_UC port map(uc_in => uc_in, clk => clk, rst => rst, pc_en => pc_en);

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
  		uc_in <= "0000000000000001";
  		wait for 100 ns;
			wait;
	end process;
end architecture;
