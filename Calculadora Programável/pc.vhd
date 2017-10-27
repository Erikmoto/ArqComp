-- Arquitetura e Organização de Computadores
-- Arquivo: pc.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 19/10/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
	port (
		clk 		: in std_logic;
		rst 		: in std_logic;
		pc_en 		: in std_logic;
		dado_in		: in unsigned(15 downto 0);
		dado_out		: out unsigned(15 downto 0)
	);
end entity;

architecture a_pc of pc is
	signal registro : unsigned(15 downto 0);

	begin
		process (clk,rst,pc_en)
			begin
				if rst='1' then
					registro <= "0000000000000000";
					elsif pc_en = '1' then
						if rising_edge(clk) then
							registro <= dado_in;
						end if;
				end if;
		end process;

		dado_out <= registro;
end architecture;
