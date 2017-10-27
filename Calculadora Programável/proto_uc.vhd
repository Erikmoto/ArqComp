-- Arquitetura e Organização de Computadores
-- Arquivo: pc_rom.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 19/10/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity proto_uc is
	port (
		dado_in, const_in : in unsigned (15 downto 0);
		dado_out	  : out unsigned (15 downto 0)
	);
end entity;

architecture a_proto_uc of proto_uc is
	begin
		dado_out <= dado_in + const_in;
end architecture;
