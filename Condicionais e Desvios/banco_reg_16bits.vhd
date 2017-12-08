-- Arquitetura e Organização de Computadores
-- Arquivo: banco_reg_16bits_tb.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega:

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_reg_16bits is
	port (	clk		 	:in std_logic;
			rst		 	:in std_logic;
			wr_en	 	:in std_logic;
			selec_reg1	:in unsigned (2 downto 0); 		--seleção do primeiro dos 8 registradores
			selec_reg2  :in unsigned (2 downto 0); 		--seleção do segundo dos 8 registradores
			selec_esc   :in unsigned (2 downto 0); 		--seleção para qual registrador sera escrito
			data_in	:in unsigned (15 downto 0); 	--dados que serão escritos no registrador
			data_out1 	:out unsigned (15 downto 0);
			data_out2 	:out unsigned (15 downto 0)
		);

end entity;

architecture a_banco_reg_16bits of banco_reg_16bits is
	signal registrador0		: unsigned (15 downto 0) := "0000000000000000";
	signal registrador1		: unsigned (15 downto 0) := "0000000000000000";
	signal registrador2		: unsigned (15 downto 0) := "0000000000000000";
	signal registrador3		: unsigned (15 downto 0) := "0000000000000000";
	signal registrador4		: unsigned (15 downto 0) := "0000000000000000";
	signal registrador5		: unsigned (15 downto 0) := "0000000000000000";
	signal registrador6		: unsigned (15 downto 0) := "0000000000000000";
	signal registrador7		: unsigned (15 downto 0) := "0000000000000000";

begin
	data_out1 <=	registrador0 when selec_reg1 = "000" else
					registrador1 when selec_reg1 = "001" else
					registrador2 when selec_reg1 = "010" else
					registrador3 when selec_reg1 = "011" else
					registrador4 when selec_reg1 = "100" else
					registrador5 when selec_reg1 = "101" else
					registrador6 when selec_reg1 = "110" else
					registrador7 when selec_reg1 = "111" else
					"0000000000000000";

	data_out2 <=	registrador0 when selec_reg2 = "000" else
					registrador1 when selec_reg2 = "001" else
					registrador2 when selec_reg2 = "010" else
					registrador3 when selec_reg2 = "011" else
					registrador4 when selec_reg2 = "100" else
					registrador5 when selec_reg2 = "101" else
					registrador6 when selec_reg2 = "110" else
					registrador7 when selec_reg2 = "111" else
					"0000000000000000";

	process (clk, rst, wr_en)
	begin
		if rst = '1' then
			registrador0 <= "0000000000000000";
			registrador1 <= "0000000000000000";
			registrador2 <= "0000000000000000";
			registrador3 <= "0000000000000000";
			registrador4 <= "0000000000000000";
			registrador5 <= "0000000000000000";
			registrador6 <= "0000000000000000";
			registrador7 <= "0000000000000000";

		elsif wr_en = '1' then
				if rising_edge (clk) then
					if selec_esc = "000" then registrador0 <= "0000000000000000";
						elsif selec_esc = "001" then registrador1 <= data_in;
							elsif selec_esc = "010" then registrador2 <= data_in;
								elsif selec_esc = "011" then registrador3 <= data_in;
									elsif selec_esc = "100" then registrador4 <= data_in;
										elsif selec_esc = "101" then registrador5 <= data_in;
											elsif selec_esc = "110" then registrador6 <= data_in;
												elsif selec_esc = "111" then registrador7 <= data_in;
					end if;
				end if;
		end if;
	end process;
end architecture;
