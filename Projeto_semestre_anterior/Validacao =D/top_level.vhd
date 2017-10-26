--top level

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity top_level is   
	port( 	Clk      : in std_logic;         
			Rst      : in std_logic;
			WE    	 : in std_logic; 				--write enable
			reg_out1 : in unsigned (2 downto 0); 	--seleciona qual o primeiro reg a ser lido.. 8 registradores, 3 bits
			reg_out2 : in unsigned (2 downto 0);	--seleciona qual o segundo reg a ser lido..8 registradores, 3 bits
			reg_wr	 : in unsigned (2 downto 0); 	-- seleciona em qual reg escrev
			tl_cte	 : in unsigned (15 downto 0); 	--constante
			mux_sel  : in std_logic;
			ula_sel  : in unsigned (1 downto 0);
			banc_clk : in std_logic;
			ram_or_ula: in std_logic;
			ram_in	 : in unsigned (15 downto 0);
			bank_out_1: out unsigned (15 downto 0);
			bank_out_2: out unsigned (15 downto 0);
			ula_out	 : out unsigned (15 downto 0);
			flag_ula : out std_logic
			
			
		);
end entity;

architecture a_top_level of top_level is
	component ula is
		port( 	in_1 		: in unsigned  (15 downto 0);
				in_2 		: in unsigned  (15 downto 0);
				sel  		: in unsigned (1 downto 0);
				soma		: inout unsigned (15 downto 0);
				sub			: inout unsigned (15 downto 0);
				media 		: inout unsigned (15 downto 0);
				maior_igual	: inout unsigned (15 downto 0);
				saida_ula	: out unsigned (15 downto 0);
				comp_flag	: out std_logic
		
			);
	end component;
	component mux_2x1 is
		port( 	sel 	: in std_logic;
				in_1	: in  unsigned (15 downto 0);
				in_2 	: in  unsigned (15 downto 0);
				out_mux : out unsigned (15 downto 0)
			);
	end component;
	component mux_16bits is
		port(	sel16: in std_logic;
				in_1: in unsigned(15 downto 0);
				in_2: in unsigned(15 downto 0);
				mux_16_out: out unsigned(15 downto 0) 
			);
	end component;
	component banco is
		port( 	clk      	: in std_logic;         
				rst      	: in std_logic;
				wr_en    	: in std_logic;
				sel_reg1 	: in unsigned (2 downto 0); --seleciona qual o primeiro reg a ser lido.. 8 registradores, 3 bits
				sel_reg2 	: in unsigned (2 downto 0);	--seleciona qual o segundo reg a ser lido..8 registradores, 3 bits
				sel_wr_reg	: in unsigned (2 downto 0); -- seleciona em qual reg escreve
				data_in  	: in unsigned(15 downto 0); --valor a ser escrito
				data_out1 	: out unsigned(15 downto 0); -- dado do primeiro reg
				data_out2 	: out unsigned(15 downto 0) -- dado do segundo reg
			);
	end component;
	
signal data_o1, data_o2, mux_out, ula_out1, mux_16_out_s: unsigned (15 downto 0):="0000000000000000";
signal comp_flag_s: std_logic;
--signal reg_out1_s, reg_out2_s, reg_wr_s: unsigned (2 downto 0);

begin
	ula1 		: ula 			port map (in_1=>data_o1, in_2=>mux_out, sel=>ula_sel, saida_ula=>ula_out1, comp_flag=>comp_flag_s);
	mux1 		: mux_2x1 		port map (in_1=>data_o2, in_2=>tl_cte, sel=>mux_sel, out_mux=>mux_out);
	mux_16bits1	: mux_16bits 	port map (sel16=>ram_or_ula, in_1=>ram_in, in_2=> ula_out1, mux_16_out=>mux_16_out_s);
	banco1		: banco 		port map (clk=>banc_clk,rst=>Rst,wr_en=>WE,sel_reg1=>reg_out1,sel_reg2=>reg_out2,sel_wr_reg=>reg_wr, data_in=>mux_16_out_s, 
										data_out1=>data_o1, data_out2=>data_o2);
	ula_out <= ula_out1;
	flag_ula <= comp_flag_s;
	bank_out_1 <= data_o1;
	bank_out_2 <= data_o2;
	--reg_out1_s<=reg_out1;
	--reg_out2_s<=reg_out2;
	--reg_wr_s<=reg_wr;
end architecture;
