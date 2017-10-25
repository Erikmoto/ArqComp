-- Arquitetura e Organização de Computadores
-- Arquivo: pc_rom.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 19/10/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_rom is
	port (
					top_in : in unsigned (14 downto 0);
					top_out	  : out unsigned (15 downto 0);
          clk, rst, pc_en : std_logic
		);
end entity;

architecture a_pc_rom of pc_rom is

	signal endereco : unsigned (14 downto 0);

	component pc is
    port (	clk		: in std_logic;
  			rst 	: in std_logic;
  			pc_ena 	: in std_logic;
  			pc_in	: in unsigned(14 downto 0);
  			pc_out	: out unsigned(14 downto 0)
		);
	end component;

	component rom is
		port (clk		: in std_logic;
			  endereco	: in unsigned (14 downto 0);	-- bit_ROM: 15
			  dado		: out unsigned (15 downto 0)
		);
	end component;


	begin
  	pc_1: pc port map (	clk => clk, rst => rst, pc_ena => pc_en, pc_in => top_in, pc_out => endereco);

		rom_1: rom port map (clk => clk, endereco => endereco, dado => top_out);
end architecture;
