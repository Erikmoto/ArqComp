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
		uc_en: in std_logic;
		instruction: in unsigned(14 downto 0);
		nop_s: out std_logic;
		jump_s: out std_logic;
		mov_s: 		out std_logic;
		add_s: 		out std_logic;
		sub_s: 		out std_logic;
		cmp_s:		out std_logic;
		blr_s:		out std_logic;
		st_s:		out std_logic;
		ld_s:		out std_logic;
		reg_fonte_s:out unsigned (2 downto 0);
		reg_dest_s:	out unsigned (2 downto 0);
		flag_s: out std_logic;
		destino_jump_s: out unsigned(15 downto 0);
		constante_s: out unsigned(15 downto 0);
		erro_op_s: out std_logic
	);
end entity;


architecture a_uc of uc is
	signal opc_r: 	unsigned (3 downto 0);
	signal opc_j: 	unsigned (5 downto 0);
	signal nop_m: std_logic;
	signal jump_m: 	std_logic;
	signal mov_m: 	std_logic;
	signal add_m: 	std_logic;
	signal sub_m: 	std_logic;
	signal cmp_m: 	std_logic;
	signal blr_m:	std_logic;
	signal st_m:	std_logic;
	signal ld_m:	std_logic;
	signal reg_fonte: unsigned(2 downto 0);
	signal reg_dest: unsigned(2 downto 0);
	signal flag: std_logic;
	signal destino_jump: unsigned(15 downto 0);
	signal constante: unsigned(15 downto 0);
	signal erro_op: std_logic;

	begin

		--opcode reg nos 4 MSB
		opc_r <= instruction(14 downto 11);

		--opcode tipo J nos 6 MSB
		opc_j <= instruction(14 downto 9) ;

		--MOV
		mov_m <= '1' when opc_r = "0100" and uc_en ='1' else '0';
		mov_s <= mov_m;

		--ADD
		add_m <= '1' when opc_r = "0101" and uc_en ='1' else '0';
		add_s <= add_m;

		--SUB
		sub_m <= '1' when opc_r = "1000" and uc_en ='1' else '0';
		sub_s <= sub_m;

		--CMP
		cmp_m <= '1' when opc_r = "1001" and uc_en ='1' else '0';
		cmp_s <=cmp_m;

		--ST
		st_m <= '1' when opc_r = "1100" and uc_en ='1' else '0';
		st_s <= st_m;

		--LD
		ld_m <= '1' when opc_r = "1101" and uc_en ='1' else '0';
		ld_s <= ld_m;

		--JMP
		jump_m <= '1' when opc_j = "001111" and uc_en ='1' else '0';
		jump_s <= jump_m;

		--BLR
		blr_m <= '1' when opc_j = "001101" and uc_en = '1' else '0';
		blr_s <= blr_m;

		--NOP
		nop_m <= '1' when instruction = "00000000000000" else '0';
		nop_s <= nop_m;

		flag <= instruction(3) when uc_en = '1' else '0';
		flag_s <= flag;

		reg_fonte <= instruction(10 downto 8) when uc_en = '1' and flag = '0' else "000";
		reg_fonte_s <= reg_fonte;

		reg_dest <= instruction(2 downto 0) when uc_en = '1' else "000";
		reg_dest_s <= reg_dest;

		destino_jump <= "0000000" & instruction(8 downto 0) when uc_en = '1' and instruction(8) = '0' else
										"1111111" & instruction(8 downto 0) when uc_en = '1' and instruction(8) = '1' else "0000000000000000";
		destino_jump_s <= destino_jump;

		constante <= "000000000" & instruction(10 downto 4) when uc_en = '1' and flag = '1' else "0000000000000000";
		constante_s <= constante;

		erro_op <= '0' when (nop_m or jump_m or blr_m or mov_m or add_m or sub_m or cmp_m or st_m or ld_m) = '1' else '1';
		erro_op_s <= erro_op;
end architecture;
