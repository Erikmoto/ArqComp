library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_2x1 is
	port( 	sel : in std_logic;
			in_1, in_2 : in  unsigned(15 downto 0);
			out_mux : out unsigned (15 downto 0)
		);
end entity;

architecture a_mux_2x1 of mux_2x1 is
begin
	out_mux <= 	in_1 when sel = '0' else
				in_2 when sel = '1' else
				"0000000000000000"; -- esse '0' é pra quando "der pau" em sel1 ou sel0
end architecture;