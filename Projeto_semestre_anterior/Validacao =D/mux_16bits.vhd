library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_16bits is

	port (
		sel16: in std_logic;
		in_1: in unsigned(15 downto 0);
		in_2: in unsigned(15 downto 0);
		mux_16_out: out unsigned(15 downto 0)
	
	);

end entity;

architecture a_mux_16bits of mux_16bits is
begin

mux_16_out <= 	in_1 when sel16='0'  else
				in_2 when sel16='1';
			   
end architecture;