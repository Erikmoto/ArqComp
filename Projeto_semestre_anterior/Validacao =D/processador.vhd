library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
	port(	clk : in std_logic;
			rst : in std_logic;
			--wr_en : in std_logic;
			data_out: out unsigned(15 downto 0)
		);
end entity;

architecture a_processador of processador is
	component PC is
		port(	clk : in std_logic;
				rst : in std_logic;
				pc_en : in std_logic;
				data_in_pc: in unsigned(9 downto 0);
				data_out_pc: out unsigned(9 downto 0)
			);
	end component;
	
	component rom is
		port(	clk : in std_logic;
				endereco : in unsigned(9 downto 0);
				dado : out unsigned(15 downto 0)
			);
	end component;
	
	component maquina is
		port( 	clk: in std_logic;
				rst: in std_logic;
				estado: out unsigned(1 downto 0);
				estado_0, estado_1, estado_2: out std_logic
			);
	end component;

	component decoder is
		port(	instruction: 	in 	unsigned(15 downto 0);
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
	end component;
	
	component top_level is
		port(	Clk      : in std_logic;         
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
	end component;
	
	component ram is
		port(	clk : in std_logic;
				endereco : in unsigned(6 downto 0);
				wr_en : in std_logic;
				dado_in : in unsigned(15 downto 0);
				dado_out : out unsigned(15 downto 0)
			);
	end component;
 
signal data_out_s, data_in_s, endereco_j_s, delta_j_s : unsigned(9 downto 0);
signal jump_en_s : std_logic;
signal dado_s, data_out_1: unsigned (15 downto 0);

signal estado_maquina_s: unsigned (1 downto 0);
signal estado_0_s, estado_1_s, estado_2_s: std_logic;

signal mov_en_s, add_en_s, sub_en_s, cmp_en_s: std_logic;
signal bgea_en_s, bla_en_s, bger_en_s, blr_en_s: std_logic;
signal dec_en_s, st_en_s, ld_en_s, r_u_s: std_logic;
signal Reg_source_s, Reg_dest_s: unsigned (2 downto 0);
signal Const_source_s: unsigned (15 downto 0);

signal WE_s, mux_sel_s, pc_en_s, flag_ula_s: std_logic;
signal reg_out1_s, reg_out2_s, reg_wr_s: unsigned (2 downto 0);
signal tl_cte_s, ula_out_s: unsigned (15 downto 0);
signal ula_sel_s: unsigned (1 downto 0);

signal mux16_sel_s, wr_ram_en_s : std_logic;
signal bank_out_1_s, bank_out_2_s, ram_out_s : unsigned (15 downto 0);

begin
	PC1 : PC port map (rst=>rst, clk=>clk, pc_en=>pc_en_s, data_out_pc=> data_out_s, data_in_pc => data_in_s);	
	
	rom1: rom port map (clk=>clk, endereco => data_out_s, dado=> dado_s);
	
	maquina1: maquina port map (clk => clk, rst => rst, estado => estado_maquina_s, estado_0 => estado_0_s, 
								estado_1 => estado_1_s, estado_2 => estado_2_s);
	
	decoder1: decoder port map (instruction => data_out_1, jump_en=>jump_en_s, endereco_j=>endereco_j_s, delta_j => delta_j_s, 
								dec_en => dec_en_s, mov_en => mov_en_s, add_en => add_en_s, sub_en => sub_en_s, 
								cmp_en => cmp_en_s, Reg_source => Reg_source_s, Reg_dest => Reg_dest_s, bgea_en=>bgea_en_s,
								bla_en => bla_en_s, bger_en => bger_en_s, blr_en => blr_en_s, Const_source => Const_source_s,
								flag => flag_ula_s, st_en => st_en_s, ld_en => ld_en_s, r_u => r_u_s);
	
	top_level1: top_level port map (Clk => clk, Rst => rst, WE => WE_s, reg_out1 => reg_out1_s, reg_out2 => reg_out2_s, 
									reg_wr => reg_wr_s, tl_cte => tl_cte_s, mux_sel => mux_sel_s, ula_sel => ula_sel_s,
									ula_out => ula_out_s, banc_clk => estado_2_s, flag_ula => flag_ula_s,
									ram_or_ula => r_u_s, ram_in => ram_out_s, bank_out_1 => bank_out_1_s, bank_out_2 => bank_out_2_s);
	
	ram1: ram port map (clk => clk, endereco => bank_out_1_s(6 downto 0), dado_in => bank_out_2_s, dado_out => ram_out_s, wr_en => wr_ram_en_s);
									
--FETCH	
	pc_en_s <= '1' ;
	data_in_s <= "0000000000" when rst = '1'  else 
				endereco_j_s when (jump_en_s or bgea_en_s or bla_en_s) = '1' and pc_en_s ='1' and rising_edge(estado_0_s) else
				data_out_s + delta_j_s when ((bger_en_s) or (blr_en_s))='1' and pc_en_s ='1' and rising_edge(estado_0_s) else
				data_out_s + "0000000001" when pc_en_s = '1' and rising_edge(estado_0_s)  else
				data_out_s when pc_en_s = '0' and rising_edge(estado_0_s);
					
--DECODE
	
	dec_en_s <= '1' when rising_edge(estado_1_s) ; --when estado_maquina_s = "01" else '0';
	data_out_1 <= dado_s when rising_edge(estado_1_s);
	data_out<= data_out_1;
	
	
--EXECUTE
	
----- selecionar operaçao ULA 
	ula_sel_s <= "00" when (mov_en_s = '1' or add_en_s = '1') and estado_2_s = '1' else -- soma ou mov
				"01" when sub_en_s = '1' and estado_2_s = '1' else  -- sub
				"11" when cmp_en_s = '1' and estado_2_s = '1'; -- cmp
				
	-- neste caso, MOV adiciona uma constante com o valor de R0 que eh sempre 0 para escrever no registrador de destino
----- selecionar MUX (constante ou registrador)	
	mux_sel_s <= data_out_1(3) when rising_edge(estado_2_s);
	
----- selecionar registadores para leitura
	reg_out1_s <= "000" when mov_en_s = '1' and rising_edge(estado_2_s) else
				 Reg_dest_s when (sub_en_s or add_en_s or cmp_en_s or st_en_s or ld_en_s) = '1' and rising_edge(estado_2_s);
	
	reg_out2_s <= "000" when mux_sel_s = '1' and rising_edge(estado_2_s) else
				 Reg_source_s when ((mux_sel_s = '0' and data_out_1(15 downto 14) /= "00") or st_en_s='1') and rising_edge(estado_2_s);
				 
------ define constante
	tl_cte_s <= Const_source_s  when data_out_1(15 downto 14) /= "00" and rising_edge(estado_2_s);
	
------ define registrador para escrita
	reg_wr_s <= Reg_dest_s when (mov_en_s or add_en_s or sub_en_s)='1' and rising_edge(estado_2_s) else 
				Reg_source_s when ld_en_s = '1' and rising_edge(estado_2_s) else
				"000" when (data_out_1 (15 downto 14) = "00" or cmp_en_s='1') and rising_edge(estado_2_s);

------ habilita escrita no banco de registradores
	WE_s <= '1' when (data_out_1(15 downto 14) /= "00") and rising_edge(estado_2_s) else
			'0' when (cmp_en_s = '1' or st_en_s ='1' or data_out_1(15 downto 14) = "00") and rising_edge(estado_2_s);

------ habilita escrita na RAM
	wr_ram_en_s <= '1' when st_en_s = '1' and rising_edge(estado_2_s) else '0';
	
	r_u_s <= '0' when ld_en_s = '1' or (falling_edge (ld_en_s) and estado_1_s = '1') else '1';
		
------ implementa NOP
	--data_in_s <= data_out_s + "0000000001" when WE_s = '0' and estado_maquina_s = "10";
	
end architecture;
