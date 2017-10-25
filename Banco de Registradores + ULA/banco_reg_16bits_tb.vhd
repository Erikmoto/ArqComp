-- Arquitetura e Organização de Computadores
-- Arquivo: banco_reg_16bits_tb.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega:

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_reg_16bits_tb is
end;

architecture a_banco_reg_16bits_tb of banco_reg_16bits_tb is
	component banco_reg_16bits
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

	signal clk, rst, wr_en	 					: std_logic := '0';
	signal selec_reg1, selec_reg2, selec_esc	: unsigned (2 downto 0):="000";
	signal data_in, data_out1, data_out2		: unsigned (15 downto 0):="0000000000000000";

	begin
		uut : banco_reg_16bits port map (clk => clk, rst => rst, wr_en => wr_en,
										   selec_reg1 => selec_reg1, selec_reg2 => selec_reg2, selec_esc => selec_esc,
										   data_in => data_in, data_out1 => data_out1, data_out2 => data_out2
										   );

	process
		begin
			--geração de sinal
				clk <= '0';
				wait for 50 ns;
				clk <= '1';
				wait for 50 ns;
	end process;

	process
		begin
			--teste para reset
				rst <= '1';
				wait for 100 ns;
				rst <= '0';
				wait for 1000 ns;
				rst <= '1';
				wait;
	end process;

	process
		begin
			-- sinais dos casos de teste
				wait for 100 ns;
				wr_en <= '1'; 					-- pino de escrita ativado em 1
				selec_esc <= "111"; 			-- seleciona escrita no registrador 7
				data_in <= "1000000110011111"; 	-- escreve num no registrador 1
				selec_reg1 <= "000"; 				--apresenta dado registrador 0
				selec_reg2 <= "001";				--apresenta dado registrador 1

				wait for 100 ns;
				selec_esc <= "110"; 			-- registrador 6
				data_in <= "1111111111111111";
				selec_reg1 <= "001";
				selec_reg2 <= "010";

				wait for 100 ns;
				selec_esc <= "101";				--registrador 5
				data_in <="0000000000000001";
				selec_reg1 <= "010";
				selec_reg2 <= "011";

				wait for 100 ns;
				selec_esc <= "100";				--registrador 4
				data_in <="0001000100010010";
				selec_reg1 <= "011";
				selec_reg2 <= "100";

				wait for 100 ns;
				selec_esc <= "011";				--registrador 3
				data_in <="0000000100101010";
				selec_reg1 <= "100";
				selec_reg2 <= "101";

				wait for 100 ns;
				selec_esc <= "010";				--registrador 2
				data_in <="0001000101010110";
				selec_reg1 <= "101";
				selec_reg2 <= "110";

				wait for 100 ns;
				selec_esc <= "001";				--registrador 1
				data_in <="0001000100010010";
				selec_reg1 <= "110";
				selec_reg2 <= "111";

				wait for 100 ns;
				selec_esc <= "000";				--registrador 7
				data_in <="0001000101010100";
				selec_reg1 <= "111";
				selec_reg2 <= "000";
				wait;
	end process;
end architecture;
