-- Arquitetura e Organização de Computadores
-- Arquivo: proto_UC.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 19/10/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_rom is
	port (
		top_out	  : out unsigned (14 downto 0);
    clk, rst, pc_en : in std_logic
	);
end entity;

architecture a_pc_rom of pc_rom is

	signal pc_in, pc_out : unsigned (15 downto 0);

	component pc is
    port (
			clk 		: in std_logic;
	    rst 		: in std_logic;
	    pc_en 	: in std_logic;
	    dado_in		: inout unsigned(15 downto 0);
	    dado_out	: out unsigned(15 downto 0)
		);
	end component;

	component rom is
		port (
			clk		:in std_logic;
		  endereco	:in unsigned (15 downto 0);
		  dado		:out unsigned (14 downto 0)
		);
	end component;

	begin
  	pc_1: pc port map (clk => clk, rst => rst, pc_en => pc_en, dado_in => pc_in, dado_out => pc_out);
		rom_1: rom port map (clk => clk, endereco => pc_out, dado => top_out);
end architecture;
