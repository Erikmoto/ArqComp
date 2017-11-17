-- Arquitetura e Organização de Computadores
-- Arquivo: rom_tb.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega 09/11/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end entity;

architecture a_rom_tb of rom_tb is
	component rom
		port (clk		: in std_logic;
			  endereco	: in unsigned(14 downto 0);
			  dado		: out unsigned(15 downto 0)
			  );
	end component;

	signal clk			: std_logic;
	signal endereco 	: unsigned(14 downto 0);
	signal dado			: unsigned(15 downto 0) ;

begin
	uut: rom port map(clk=>clk, endereco=>endereco, dado=>dado);

		process
			begin
				clk <= '0';
				wait for 50 ns;
				clk <= '1';
				wait for 50 ns;
				clk <= '0';
				wait for 50 ns;
				clk <= '1';
				wait for 50 ns;
		end process;

		process
			begin
				endereco <= "000000000000100";
				wait for 100 ns;
				endereco <= "000000000000010";
				wait for 100 ns;
				endereco <= "000000000000001";
				wait for 100 ns;
				endereco <= "000000000001111";
				wait for 100 ns;

		end process;
end architecture;
