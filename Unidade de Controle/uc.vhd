-- Arquitetura e Organização de Computadores
-- Arquivo: decoder.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 26/10/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
	port(
		instruction: in unsigned(14 downto 0);
		jump_s: out std_logic;
		mov_s: 		out std_logic;
		add_s: 		out std_logic;
		sub_s: 		out std_logic;
		cmp_s:		out std_logic;
		st_s:		out std_logic;
		ld_s:		out std_logic;
		reg_fonte_s:out unsigned (2 downto 0);
		reg_dest_s:	out unsigned (2 downto 0)
	);
end entity;


architecture a_uc of uc is
	signal opc_r: 	unsigned (3 downto 0);
	signal opc_j: 	unsigned (5 downto 0);
	signal jump_m: 	std_logic;
	signal mov_m: 	std_logic;
	signal add_m: 	std_logic;
	signal sub_m: 	std_logic;
	signal cmp_m: 	std_logic;
	signal st_m:	std_logic;
	signal ld_m:	std_logic;

	begin

		--opcode reg nos 4 MSB
		opc_r <= instruction(14 downto 11);

		--opcode tipo J nos 6 MSB
		opc_j <= instruction(14 downto 9) ;

		--MOV
		mov_m <= '1' when opc_r = "0100" else '0';
		mov_s <= mov_m;

		--ADD
		add_m <= '1' when opc_r = "0101" else '0';
		add_s <= add_m;

		--SUB
		sub_m <= '1' when opc_r = "1000" else '0';
		sub_s <= sub_m;

		--CMP
		cmp_m <= '1' when opc_r = "1001" else '0';
		cmp_s <=cmp_m;

		--ST
		st_m <= '1' when opc_r = "1100" else '0';
		st_s <= st_m;

		--LD
		ld_m <= '1' when opc_r = "1101" else '0';
		ld_s <= ld_m;

		--JMP
		jump_m <= '1' when opc_j="001111" else '0';
		jump_s<=jump_m;

		--ligações

end architecture;
