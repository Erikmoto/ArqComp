library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is
	port(   instruction: 	in 	unsigned(15 downto 0);
			dec_en:			in 	std_logic;
			flag:			in	std_logic;
			mov_en: 		out std_logic;
			add_en: 		out std_logic;
			sub_en: 		out std_logic;
			cmp_en:			out std_logic;
			bger_en:		out std_logic;
			blr_en:			out std_logic;
			bgea_en:		out std_logic;
			bla_en:			out std_logic;
			st_en:			out std_logic;
			ld_en:			out std_logic;
			r_u:			out std_logic;
			Reg_source: 	out unsigned (2 downto 0);
			Reg_dest: 		out unsigned (2 downto 0);
			Const_source: 	out unsigned (15 downto 0);
			jump_en: 		out std_logic;
			endereco_j : 	out unsigned(9 downto 0);
			delta_j:		out unsigned(9 downto 0)
		);
end entity;

architecture a_decoder of decoder is
	signal opcode_r: unsigned (3 downto 0);
	signal opcode_j: unsigned (5 downto 0);
	signal jump_en_m: std_logic;
	signal bger_en_m: std_logic;
	signal blr_en_m: std_logic;
	signal bgea_en_m: std_logic;
	signal bla_en_m: std_logic;
	signal mov_en_m: std_logic;
	signal add_en_m: std_logic;
	signal sub_en_m: std_logic;
	signal cmp_en_m: std_logic;
	signal st_en_m:	std_logic;
	signal ld_en_m:	std_logic;
	signal r_u_m:	std_logic;
	
	begin
		--opcode tipo J nos 6 MSB
		opcode_j <= instruction(15 downto 10) ;
		--opcode tipo R nos 4 MSB
		opcode_r <= instruction(15 downto 12);
		--MOV
		mov_en_m <= '1' when opcode_r = "0100" and dec_en = '1' else
				'0';
		mov_en <= mov_en_m;
		
		--ADD
		add_en_m <= '1' when opcode_r = "0101" and dec_en = '1' else
				'0';
		add_en <= add_en_m;
		
		--SUB
		sub_en_m <= '1' when opcode_r = "1000" and dec_en = '1'  else
				'0';
		sub_en <= sub_en_m;

		--CMP
		cmp_en_m <= '1' when opcode_r = "1001" and dec_en = '1' else
					'0';
		cmp_en<=cmp_en_m;
		
		--ST
		st_en_m <= '1' when opcode_r = "1100" and dec_en = '1' else
					'0';
		st_en <= st_en_m;
		
		--LD
		ld_en_m <= '1' when opcode_r = "1101" and dec_en = '1' else
					'0';
		ld_en <= ld_en_m;
		--BGEA
		bgea_en_m <= '1' when opcode_j = "001000" and flag = '1' and dec_en  = '1' else
					'0';
		bgea_en <=bgea_en_m;
		
		--BLA
		bla_en_m <= '1' when opcode_j = "001100" and flag = '0' and dec_en = '1' else
					'0';
		bla_en <= bla_en_m;
		
		--BGER
		bger_en_m <= '1' when opcode_j = "001001" and flag = '1' and dec_en = '1' else
					'0';
		bger_en <= bger_en_m;
		
		--BLR
		blr_en_m <= '1' when opcode_j = "001101" and flag = '0' and dec_en = '1' else
				'0';
		blr_en <= blr_en_m;
			
		--JMP
		jump_en_m <= '1' when opcode_j="001111" and dec_en = '1' else
				   '0';
		jump_en<=jump_en_m;

		--Sources and destinations
		Reg_dest <= instruction (2 downto 0) when (mov_en_m or add_en_m or sub_en_m or cmp_en_m or st_en_m or ld_en_m)='1';
		Const_source(15 downto 8) <= "00000000";
		Const_source(7 downto 0) <= instruction(11 downto 4) when instruction (3) = '1' and instruction(15 downto 14)/="00";
		Reg_source <= instruction (11 downto 9) when (mov_en_m or add_en_m or sub_en_m or cmp_en_m or st_en_m or ld_en_m)='1';		
		
		--r_u_m <= '0' when ld_en_m = '1'  else '1';
		--r_u<= r_u_m;
		
		endereco_j <= instruction (9 downto 0) when (jump_en_m or bgea_en_m or bla_en_m) = '1' else "0000000000";
		delta_j <= instruction (9 downto 0) when (bger_en_m or blr_en_m) = '1' else "0000000000";		

end architecture;