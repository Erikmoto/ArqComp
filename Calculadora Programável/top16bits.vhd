-- Arquitetura e Organização de Computadores
-- Arquivo: top16bits_tb.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega:

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top16bits is
	port (	
		top_in									: in unsigned (15 downto 0);
		selec_reg1, selec_reg2, selec_esc : unsigned (2 downto 0);
		ula_sel										  			: unsigned (1 downto 0);
		rstIn, clkIn, we_In, mux_sel			: in std_logic;
		debug 														: out unsigned (15 downto 0)
	);
end entity;

architecture a_top16bits of top16bits is

	signal ula_out						  : unsigned (15 downto 0);
	signal soma, subtrai, select_maior, modulo_adicao : unsigned (15 downto 0);
	signal compara									  : std_logic;
	signal data_out1, data_out2			  : unsigned (15 downto 0);
	signal mux_out 				  : unsigned(15 downto 0);

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

	begin
	banco_reg1: banco_reg_16bits port map (	clk => clkIn, rst => rstIn, wr_en => we_In,
											selec_reg1 => selec_reg1, selec_reg2 => selec_reg2, selec_esc => selec_esc,
											data_in => ula_out, data_out1 => data_out1, data_out2 => data_out2
										);

	ula: ula_16bits port map (	entr0 => data_out1, entr1 => mux_out, compara => compara,
								sel0 => ula_sel, soma => soma, subtrai => subtrai,
								select_maior => select_maior, modulo_adicao => modulo_adicao,
								saida => ula_out
							);

	mux_banco_ula: mux_16bits port map ( sel0 => mux_sel, entr0 => data_out2, entr1 => top_in, saida => mux_out);



end architecture;
