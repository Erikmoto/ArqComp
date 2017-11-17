-- Arquitetura e Organização de Computadores
-- Arquivo: proto_UC.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 09/11/17

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
	signal estado, jump_en, mov_en, add_en, sub_en, cmp_en, st_en, ld_en : std_logic;
	signal reg_fonte, reg_dest : unsigned (2 downto 0);
	signal instrucao : unsigned (14 downto 0);

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

	component maquina_est is
		port(
			clk, rst : in std_logic;
			est_o : out std_logic
		);
	end component;

	component uc is
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
	end component;

	begin
		pc1: pc port map(clk => clk, rst => rst, pc_en => pc_en, dado_in => pc_in, dado_out => pc_out);
		rom1: rom port map (clk => clk, endereco => pc_out, dado => instrucao);
		maq_est: maquina_est port map (clk => clk, rst => rst, est_o => estado);
		uc1: uc port map(instruction => instrucao, jump_s => jump_en, mov_s => mov_en, add_s => add_en, sub_s => sub_en, cmp_s => cmp_en,
		 									st_s => st_en, ld_s => ld_en, reg_fonte_s => reg_fonte, reg_dest_s => reg_dest);

		--instrucao <= top_out;

		pc_in <= pc_out + "0000000000000001" when estado = '1' and jump_en = '0' else
							pc_in + ("000000" & instrucao(8 downto 0)) when estado = '1' and jump_en = '1' else
							pc_in when estado = '0' else
							"0000000000000000";

end architecture;
