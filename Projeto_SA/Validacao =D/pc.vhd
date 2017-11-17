library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
	port (	clk : in std_logic;
			rst : in std_logic;
			pc_en : in std_logic;
			data_in_pc: in unsigned(9 downto 0);
			data_out_pc: out unsigned(9 downto 0)
		);
end entity;

architecture a_PC of PC is
	signal registro : unsigned(9 downto 0);
begin

	process (clk,rst,pc_en)
	begin
		if rst='1' then
			registro <= "0000000000";
			elsif pc_en='1' then
				if rising_edge(clk) then
				registro <= data_in_pc;
				end if;
		end if;
	end process;
	
	data_out_pc <= registro;
			   
end architecture;