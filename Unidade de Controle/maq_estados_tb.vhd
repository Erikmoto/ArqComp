-- Arquitetura e Organização de Computadores
-- Arquivo: maquina_est_tb.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 19/10/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maquina_est_tb is
end entity;

architecture a_maq_estados_tb of maq_estados_tb is
	component maq_estados is
	port (	clk		: in std_logic;
			rst		: in std_logic;
			estado	: out unsigned(1 downto 0)
			
		);
	end component;

	signal clk,rst	: std_logic;
	signal estado	:unsigned(1 downto 0);
	
begin
	uut: maq_estados port map (clk=>clk, estado=>estado, rst=>rst);

		process 			-- sinal de clock
			begin
				clk <= '0';
				wait for 50 ns;
				clk <= '1';
				wait for 50 ns;
		end process;

		process 			-- sinal de reset
			begin
				rst <= '1';
				wait for 100 ns;
				rst <= '0';
				wait;
		end process;
end architecture;
