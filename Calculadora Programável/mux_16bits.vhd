-- Arquitetura e Organização de Computadores
-- Arquivo: mux_16bits.vhd
-- Anderson Cottica
-- Erik R. Yamamoto
-- Data: 


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_16bits is

	port (
		sel0: in std_logic;
		entr0: in unsigned(15 downto 0);
		entr1: in unsigned(15 downto 0);
		saida: out unsigned(15 downto 0)
	
	);

end entity;

architecture a_mux_16bits of mux_16bits is
begin

saida <= 	entr0 when sel0 = '0'  else
			entr1 when sel0 = '1';
			   
end architecture;