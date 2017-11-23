-- Arquitetura e Organização de Computadores
-- Arquivo: maquina_est.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 19/10/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity maquina_est is
	port( clk, rst : in std_logic;
				est_o : out std_logic);
end entity;

architecture a_maquina_est of maquina_est is
	signal est_s : std_logic;

	begin
		process(clk,rst)
			begin
				if rst='1' then
					est_s <= '0';
					elsif rising_edge(clk) then
						est_s <= not est_s;
				end if;
		end process;

		est_o <= est_s;
end architecture;
