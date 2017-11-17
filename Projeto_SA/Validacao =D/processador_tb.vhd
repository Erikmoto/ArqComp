library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador_tb is
end entity;

architecture a_processador_tb of processador_tb is
	component processador
	port(	clk : in std_logic;
			rst : in std_logic;
			--wr_en : in std_logic;
			data_out: out unsigned(15 downto 0)
		);
	end component;
	
signal clk,rst: std_logic;
signal data_out :unsigned(15 downto 0):= "0000000000000000";
	
begin
	uut: processador port map(clk=>clk, rst=>rst, data_out=>data_out);

		process -- sinal de clock
		begin
			clk <= '0';
			wait for 50 ns;
			clk <= '1';
			wait for 50 ns;
		end process;
		
		process -- sinal de reset
		begin
			rst <= '1';
			wait for 100 ns;
			rst <= '0';
			wait;
		end process;
		
		--process -- sinais de casos de teste
		--begin
			--wr_en <= '0';
			--wait for 200 ns;
			--wr_en <= '1';
			--wait for 8000 ns;
			--wait;
		--end process;
		
end architecture;
