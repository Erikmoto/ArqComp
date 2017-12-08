-- Arquitetura e Organização de Computadores
-- Arquivo: processador.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 09/11/17


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
	port(
		top_out	  : out unsigned (14 downto 0);
		clk, rst, pc_en : in std_logic;
		erro: out std_logic
	);
end entity;

architecture a_processador of processador is
	signal mux_sel, uc_en, nop_en, jump_en, mov_en, add_en, sub_en, cmp_en, blr_en, st_en, ld_en, compara, wr_en, flag, erro_op: std_logic;
	signal estado, ula_sel : unsigned (1 downto 0);
	signal selec_reg1, selec_reg2, reg_fonte, reg_dest, selec_esc : unsigned (2 downto 0);
	signal instrucao, uc_in : unsigned (14 downto 0);
	signal pc_in, pc_out, destino_jump, constante, ula_out, soma, subtrai, select_maior, modulo_adicao, reg_out1, reg_out2, mux_in, mux_out : unsigned (15 downto 0);

	component pc is
		port (
			clk 		: in std_logic;
			rst 		: in std_logic;
			pc_en 		: in std_logic;
			dado_in		: in unsigned(15 downto 0);
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

	component maq_estados is
		port(
			clk,rst	: in std_logic;
			estado : out unsigned(1 downto 0)
		);
	end component;

	component uc is
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
	end component;

	component banco_reg_16bits is
		port(	clk		 	:in std_logic;
				rst		 	:in std_logic;
				wr_en	 	:in std_logic;
				selec_reg1	:in unsigned (2 downto 0); 		--seleção do primeiro dos 8 registradores
				selec_reg2  :in unsigned (2 downto 0); 		--seleção do segundo dos 8 registradores
				selec_esc   :in unsigned (2 downto 0); 		--seleção para qual registrador sera escrito
				data_in		:in unsigned (15 downto 0); 	--dados que serão escritos no registrador
				data_out1 	:out unsigned (15 downto 0);
				data_out2 	:out unsigned (15 downto 0)
		);
	end component;

	component ula_16bits is
		port(	entr0, entr1									: in unsigned (15 downto 0);
				sel0											: in unsigned (1 downto 0);
				soma, subtrai, select_maior, modulo_adicao 		: inout unsigned (15 downto 0);
				saida											: out unsigned(15 downto 0);
				compara											: out std_logic
		);
	end component;

	component mux_16bits is
		port(	sel0: in std_logic;
				entr0: in unsigned(15 downto 0);
				entr1: in unsigned(15 downto 0);
				saida: out unsigned(15 downto 0)
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

	begin

		pc1: pc port map(clk => clk, rst => rst, pc_en => pc_en, dado_in => pc_in, dado_out => pc_out);

		-- Entrada de endereços da ROM é ligada na saída do PC
		rom1: rom port map (clk => clk, endereco => pc_out, dado => instrucao);

		maq_est: maq_estados port map (clk => clk, rst => rst, estado => estado);

		uc1: uc port map(uc_en => uc_en, instruction => uc_in, nop_s => nop_en, jump_s => jump_en, mov_s => mov_en, add_s => add_en, sub_s => sub_en, cmp_s => cmp_en,
		 									blr_s => blr_en, st_s => st_en, ld_s => ld_en, reg_fonte_s => reg_fonte, reg_dest_s => reg_dest,
											flag_s => flag, destino_jump_s => destino_jump, constante_s => constante, erro_op_s => erro_op);

		-- Entrada de dados do Banco é ligada na saída da ULA
		banco_reg1: banco_reg_16bits port map (clk => clk, rst => rst, wr_en => wr_en,
												selec_reg1 => selec_reg1, selec_reg2 => selec_reg2, selec_esc => selec_esc,
												data_in => ula_out, data_out1 => reg_out1, data_out2 => reg_out2);

		-- Uma entrada de dados da ULA é ligada na saída de dados do registrador destino do Banco
		-- A outra entrada de dados da ULA é ligada na saída do MUX
		ula: ula_16bits port map (entr0 => reg_out2, entr1 => mux_out, compara => compara,
									sel0 => ula_sel, soma => soma, subtrai => subtrai,
									select_maior => select_maior, modulo_adicao => modulo_adicao,
									saida => ula_out);

		-- Uma entrada de dados do MUX é ligada na saída de dados do registrador fonte do Banco
		-- A outra entrada de dados do MUX é ligada na saída da ROM
		mux_banco_ula: mux_16bits port map (sel0 => mux_sel, entr0 => reg_out1, entr1 => mux_in, saida => mux_out);

		--rever conexões ram
		--ram1: ram port map (clk => clk, endereco => endereco, dado_in => dado_in, dado_out => dado_out, wr_en => wr_en);

		-----------------------------------------------------------------------
		-------------------------------- Fetch --------------------------------
		-----------------------------------------------------------------------
		-- Atualização do PC: adiciona 1 quando não é jump ou é nop, recebe o endereço de destino quando é jump
		pc_in <= 	"0000000000000000" when estado = "00" and rst = '1' else
							destino_jump when estado = "00" and jump_en = '1' else -- Jump incondicional
							pc_out + destino_jump when estado = "00" and blr_en = '1' else -- Branch
							pc_out + "0000000000000001" when estado = "00" and erro_op = '0' else pc_in;

		erro <= erro_op; -- Serve para verificar opcodes inválidos e se algum tipo de instrução está ativo

		------------------------------------------------------------------------
		-------------------------------- Decode --------------------------------
		------------------------------------------------------------------------
		uc_en <= '1' when estado = "01" else uc_en;

		uc_in <= instrucao when estado = "01" else uc_in;
		top_out <= uc_in;

		-------------------------------------------------------------------------
		-------------------------------- Execute --------------------------------
		-------------------------------------------------------------------------
		-- Entrada de dados do MUX para soma de constante
		mux_in <= constante when estado = "10" else mux_in;

		-- Seletor do MUX: Registro (Flag = 0) ou Constante (Flag = 1)
		mux_sel <= flag when estado = "10" else mux_sel;

		-- Seleção de operação da ULA
		ula_sel <= "00" when estado = "10" and (add_en or mov_en) = '1' else
								"01" when estado = "10" and sub_en = '1' else ula_sel;

		-- Seleção dos registradores fonte e destino
		selec_reg1 <= reg_fonte when estado = "10" else selec_reg1;
		selec_reg2 <= reg_dest when estado = "10" else selec_reg2;

		selec_esc <= reg_dest when estado = "10" else selec_esc;
		wr_en <= '1' when estado = "10" and (mov_en or add_en or sub_en) = '1' else '0';
end architecture;
