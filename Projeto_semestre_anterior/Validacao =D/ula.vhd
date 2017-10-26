--uProcessador2 - ULA
--Alunos: Guilherme Ono Sens e Suellen Guimaraes Mahfoud

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
	port (	in_1,in_2				:	in unsigned (15 downto 0);
			sel						:	in unsigned (1 downto 0);
			soma,sub,media,maior_igual:	inout unsigned (15 downto 0);
			saida_ula				:	out unsigned(15 downto 0);
			comp_flag				: 	out std_logic
		);
end entity;
	
architecture a_ula of ula is
begin
		soma <= in_1+in_2;
		sub <= in_1-in_2;
		media <= (in_1+in_2)/"0000000000000010";
		maior_igual <= "0000000000000001" when in_1>=in_2 else
				 "0000000000000000"; --aqui in_1 < in_2;
		
		saida_ula <=	soma when sel = "00" else
						sub when sel = "01" else
						media when sel = "10" else
						maior_igual when sel = "11" else
						"0000000000000000";
		comp_flag <= maior_igual(0);
end architecture;