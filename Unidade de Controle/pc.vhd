-- Arquitetura e Organização de Computadores
-- Arquivo: pc.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 19/10/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
	port (	clk 		: in std_logic;
			rst 		: in std_logic;
			pc_ena 		: in std_logic;
			pc_in		: in unsigned(14 downto 0);
			pc_out		: out unsigned(14 downto 0)
		);
end entity;

architecture a_pc of pc is
	signal registro : unsigned(14 downto 0);
begin

	process (clk,rst,pc_ena)
	begin
		if rst='1' then
			registro <= "000000000000000";
			elsif pc_ena = '1' then
				if rising_edge(clk) then
					registro <= pc_in;
				end if;
		end if;
	end process;

	pc_out <= registro;

end architecture;
