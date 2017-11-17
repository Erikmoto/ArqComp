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
		reset, clock : in std_logic;
		estado : out std_logic;
		PC : out unsigned(15 downto 0);
		instrucao : out unsigned(14 downto 0);
		saidaBanco1, saidaBanco2 : out unsigned(15 downto 0);
		saidaULA : out unsigned(15 downto 0)
	);
end entity;

architecture a_processador of processador is
	component pc is
		port (
			clk 		: in std_logic;
			rst 		: in std_logic;
			pc_en 		: in std_logic;
			dado_in		: in unsigned(15 downto 0);
			dado_out		: out unsigned(15 downto 0)
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
			instruction: in unsigned(15 downto 0);
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

	component top_level is
		port (
			top_in									: in unsigned (15 downto 0);
			selec_reg1, selec_reg2, selec_esc : unsigned (2 downto 0);
			ula_sel										  			: unsigned (1 downto 0);
			rstIn, clkIn, we_In, mux_sel			: in std_logic;
			debug 														: out unsigned (15 downto 0)
		);
	end component;

begin

end architecture;
