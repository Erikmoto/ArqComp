-- Arquitetura e Organização de Computadores
-- Arquivo: pc.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 19/10/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity super_pc is
	port (
		clk 		: in std_logic;
		rst 		: in std_logic;
		pc_en 	: in std_logic
	);
end entity;

architecture a_super_pc of super_pc is
	signal clk, rst, pc_en : std_logic;
	signal pc_in, pc_out, proto_out : unsigned(15 downto 0);
	signal proto_const : unsigned(15 downto 0) := "0000000000000001";

	component pc is
		port (
			clk 		: in std_logic;
			rst 		: in std_logic;
			pc_en 		: in std_logic;
			dado_in		: in unsigned(15 downto 0);
			dado_out	: out unsigned(15 downto 0)
		);
	end component;

	component proto_uc is
		port (
			dado_in, const_in : in unsigned (15 downto 0);
			dado_out	  : out unsigned (15 downto 0)
		);
	end component;

	begin
		pc: pc port map(clk => clk, rst => rst, pc_en => pc_en, dado_in => pc_in, dado_out => pc_out);
		proto: proto_uc port map(dado_in => pc_out, const_in => proto_const, dado_out => proto_out);

		pc_in <= proto_out;
end architecture;
