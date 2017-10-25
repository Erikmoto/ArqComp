-- Arquitetura e Organização de Computadores
-- Arquivo: proto_UC.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 19/10/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity proto_UC is
	port (	uc_in	  : in unsigned (15 downto 0);
          clk, rst, pc_en : in std_logic
		);
end entity;

architecture a_proto_UC of proto_UC is

	signal pc_in_s, pc_out_s : unsigned (15 downto 0);

	component pc is
    port (	clk 		: in std_logic;
  			    rst 		: in std_logic;
  			    pc_ena 	: in std_logic;
  			    pc_in		: in unsigned(15 downto 0);
  			    pc_out	: out unsigned(15 downto 0)
		);
	end component;

	begin
  	pc_1: pc port map (	clk => clk, rst => rst, pc_ena => pc_en, pc_in => pc_in_s, pc_out => pc_out_s);

		pc_in_s <= uc_in + pc_out_s;
end architecture;
