-- Arquitetura e Organização de Computadores
-- Arquivo: top16bits_tb.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 05/10/2017

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top16bits_tb is
end;

architecture a_top16bits_tb of top16bits_tb is
	component top16bits
		port (	top_in									: in unsigned (15 downto 0);
						selec_reg1, selec_reg2, selec_esc : in unsigned (2 downto 0);
						ula_sel										  			: in unsigned (1 downto 0);
						rstIn, clkIn, we_In, mux_sel			: in std_logic;
						debug 														: out unsigned (15 downto 0)
			);
	end component;

	signal top_in										: unsigned (15 downto 0);
	signal selec_reg1, selec_reg2, selec_esc 	: unsigned (2 downto 0);
	signal ula_sel										  			: unsigned (1 downto 0);
	signal rstIn, clkIn, we_In, mux_sel				: std_logic := '0';
	signal debug															: unsigned(15 downto 0);

	begin
	uut:top16bits port map(top_in=>top_in,
												selec_reg1=>selec_reg1, selec_reg2=>selec_reg2, selec_esc=>selec_esc,
												ula_sel=>ula_sel,
												rstIn=>rstIn, clkIn=>clkIn, we_In=>we_In, mux_sel=>mux_sel,
												debug=>debug
						);

	process
	begin
		clkIn <= '0';
		wait for 50 ns;
		clkIn <= '1';
		wait for 50 ns;
	end process;

	process
	begin
		rstIn <= '1';
		wait for 100 ns;
		rstIn <= '0';
		wait for 1000 ns;
		rstIn <= '1';
		wait;
	end process;

	process    -- sinais dos casos de teste
	begin
		top_in <= "0000000000000100";
		selec_reg1 <= "000";
		selec_reg2 <= "000";
		selec_esc <= "000";
		ula_sel <= "00";
		we_In <= '0';
		mux_sel <= '1';
		
		wait for 100 ns;
		we_In <= '1';

		-- sinais dos casos de teste
			wait for 100 ns;
			top_in <= "0000000000001000";
			selec_esc <= "111"; 			-- seleciona escrita no registrador 7
			selec_reg1 <= "000"; 				--apresenta dado registrador 0
			selec_reg2 <= "001";				--apresenta dado registrador 1
			
			wait for 100 ns;
			top_in <= "0000000000011000";
			selec_esc <= "110"; 			-- registrador 6
			selec_reg1 <= "001";
			selec_reg2 <= "010";

			wait for 100 ns;
			top_in <= "0001000000000000";
			selec_esc <= "101";				--registrador 5
			selec_reg1 <= "010";
			selec_reg2 <= "011";

			wait for 100 ns;
			top_in <= "0001000000000100";
			selec_esc <= "100";				--registrador 4
			selec_reg1 <= "011";
			selec_reg2 <= "100";

			wait for 100 ns;
			top_in <= "1000000000000100";
			selec_esc <= "011";				--registrador 3
			selec_reg1 <= "100";
			selec_reg2 <= "101";

			wait for 100 ns;
			top_in <= "0000010000000100";
			selec_esc <= "010";				--registrador 2
			selec_reg1 <= "101";
			selec_reg2 <= "110";

			wait for 100 ns;
			top_in <= "0000001110000100";
			selec_esc <= "001";				--registrador 1
			selec_reg1 <= "110";
			selec_reg2 <= "111";

			wait for 100 ns;
			top_in <= "0000000000000000";
			selec_esc <= "000";				--registrador 0
			selec_reg1 <= "111";
			selec_reg2 <= "000";
			mux_sel <= '0';
			wait;
	end process;
end architecture;
