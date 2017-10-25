-- Arquitetura e Organização de Computadores
-- Arquivo: maquina_est.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 19/10/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity maquina_est is
	port( 	clk,rst				: in std_logic;
			estado				: out unsigned(1 downto 0);
			est_0, est_1, est_2	: out std_logic
		);
end entity;

architecture a_maquina_est of maquina_est is

signal est_maq								: unsigned(1 downto 0);
signal est_0_maq , est_1_maq, est_2_maq 	: std_logic;

begin
	process(clk,rst)
	begin
		if rst='1' then
			est_maq <= "00";
		elsif rising_edge(clk) then
			if est_maq = "10" then 
				est_maq <= "00"; 
			else
				est_maq <= est_maq+"01"; -- avança para proximo estado
			end if;
		end if;
	end process;
	est_0_maq <= '1' when est_maq = "00" else '0';
	est_0 <= '1' when rising_edge(est_0_maq) else '0';
	est_1_maq <= '1' when est_maq = "01" else '0';
	est_1 <= est_1_maq;
	est_2_maq <= '1' when est_maq = "10" else '0';
	est_2 <= est_2_maq;
	estado <= est_maq;

end architecture;