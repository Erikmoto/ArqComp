-- Arquitetura e Organização de Computadores
-- Arquivo: reg_16bits_tb.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_16bits_tb is
end;

entity a_reg_16bits_tb of reg_16bits is
	component reg_16bits
		port (	clk		 :in std_logic;
				rst		 :in std_logic;
				wr_en	 :in std_logic;
				data_in	 :in unsigned (15 downto 0);
				data_out :out unsigned(15 downto 0)
			);
	end component;
	
	signal clk,rst,wr_en: std_logic;
	signal data_in, data_out : unsigned (15 downto 0);
	
	begin
		uut: reg_16bits port map (clk=>clk, rst=>rst,wr_en=>wr_en
									data_in=>data_in,data_out=>data_out);
		process							
		begin
			clk <= '0';
			wait for 50 ns;
			clk	<= '1';
			wait for 50 ns;
		end process;
		
		process
		begin
			rst <= '1';
			wait for 100 ns;
			rst <= '0';
			wait;
		end process;

		process
		begin
			wait for 100 ns;
			wr_en <= '0';
			data_in <= "1111111111111111";
			wait for 100 ns;
			data_in <= "1000110100000000";
			wait for 100 ns;
			wait;
		end process
end architecture		
			