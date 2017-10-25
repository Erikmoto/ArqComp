library ieee;
use ieee.std_logic_1164.all;
use	ieee.numeric_std.all;

entity ULA is
	port(	sel0		: in unsigned (15 downto 0);
			entr0,entr1	: in unsigned (15 downto 0);
			saida		: out unsigned (15 downto 0)
	);
end entity;

architecture a_ULA of ULA is
begin
	saida <= entr0 when sel1 = '0' and sel0 = '0' else
			 entr1 when sel1 = '0' and sel0 = '1' else
			 '0000000000000000';
end architecture;