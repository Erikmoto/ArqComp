library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end entity;

architecture a_rom_tb of rom_tb is
	component rom
	port (	clk: in std_logic;
			endereco: in unsigned(9 downto 0);
			dado: out unsigned(15 downto 0) 
		);
	end component;
	signal clk: std_logic;
	signal endereco :unsigned(9 downto 0);
	signal dado: unsigned(15 downto 0) ;
	
begin
	uut: rom port map(clk=>clk, endereco=>endereco, dado=>dado);

		process -- sinal de clock
		begin
			clk <= '0';
			wait for 50 ns;
			clk <= '1';
			wait for 50 ns;
		end process;
		
			process
				begin
			
			endereco <= "0000000010";
			wait for 150 ns;
			endereco <= "0000000101";
			wait for 150 ns;
			endereco <= "0000000110";
			wait for 150 ns;
			endereco <= "0000000111";
			wait for 150 ns;
		
		
			end process;
end architecture;
