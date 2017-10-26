-- Arquitetura e Organização de Computadores
-- Arquivo: maquina_est.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 19/10/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity maq_estados is
	port( 	clk,rst				: in std_logic;
			estado				: out unsigned(1 downto 0)
		);
end entity;

architecture a_maq_estados of maq_estados is
	signal estado_s				: unsigned(1 downto 0);

begin
	process(clk,rst)
	begin
		if rst='1' then
			estado_s <= "00";
		elsif rising_edge(clk) then
			if estado_s = "10" then 
				estado_s <= "00"; 
			else
				estado_s <= estado_s+1; -- avança para proximo estado
			end if;
		end if;
	end process;
	estado <= estado_s;
end architecture;