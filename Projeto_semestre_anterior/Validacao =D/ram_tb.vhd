library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_tb is
--comentario
end;

architecture a_ram_tb of ram_tb is
	component ram
	port (	
		 clk : in std_logic;
		 endereco : in unsigned(9 downto 0);
		 wr_en : in std_logic;
		 dado_in : in unsigned(15 downto 0);
		 dado_out : out unsigned(15 downto 0) 
		
	);
	end component;
	signal dado_in,dado_out: unsigned(15 downto 0);
	signal endereco: unsigned (9 downto 0);
	signal clk,wr_en : std_logic;
	
begin
	uut: ram port map( clk=>clk, wr_en=>wr_en, endereco=>endereco, dado_in=>dado_in, dado_out=>dado_out );
	process -- sinal de clock
		begin
			clk <= '0';
			wait for 50 ns;
			clk <= '1';
			wait for 50 ns;
	end process;
	
		process -- sinais de casos de teste
		begin
			wr_en <= '0';			-- teste de enable = 0
			endereco <= "0000000000";
			wait for 200 ns;
			
			wr_en <= '1';			 -- guarda 4 no endereco 1
			endereco <= "0000000001";
			dado_in <= "0000000000000100";
			wait for 200 ns;
			
			wr_en <= '1';			-- guarda 16 no endereco 2
			endereco <= "0000000010";
			dado_in <= "0000000000010000";
			wait for 200 ns;
			
			wr_en <= '0';				-- testa se ele escreve quando o wr_en = 0
			endereco <= "0000000001";  
			dado_in <= "1000000000000000";
			wait for 200 ns;
			
			wr_en <= '0';          -- de novo
			endereco <= "0000000010";
			dado_in <= "1000000000000000";
			wait for 300 ns;
			
			wr_en <= '1';			
			endereco <= "0000000001";
			dado_in <= "0000000000000111";
			wait for 200 ns;
			
			wr_en <= '1';			
			endereco <= "0000000111";
			dado_in <= "1000000000000011";
			wait for 300 ns;
			
	
	end process;
		
end architecture;
