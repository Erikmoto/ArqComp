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

architecture a_maquina_est_tb of maquina_est_tb is
	component maquina_est is
		port( clk, rst : in std_logic;
					est_o : out std_logic);
	end component;

	signal clk, rst, est_o : std_logic;

begin
	uut: maquina_est port map (clk=>clk, rst=>rst, est_o=>est_o);

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
