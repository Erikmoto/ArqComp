-- Arquitetura e Organização de Computadores
-- Arquivo: ram.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 24/11/17


entity ram_tb is

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
	process 
		begin
			clk <= '0';
			wait for 50 ns;
			clk <= '1';
			wait for 50 ns;
	end process;
	
		process 								
		begin
			wr_en <= '0';						-- teste de enable = 0
			endereco <= "0000000000";
			wait for 200 ns;
			
			wr_en <= '1';			 			-- guardar 6 no endereco 1
			endereco <= "0000000001";
			dado_in <= "0000000000000010";
			wait for 200 ns;
			
			wr_en <= '1';						
			endereco <= "0000000010";
			dado_in <= "0000000000001111";
			wait for 200 ns;
			
			wr_en <= '0';						-- testa se ele escreve 
			endereco <= "0000000001";  
			dado_in <= "1000000000000000";
			wait for 200 ns;
			
			wr_en <= '0';          					
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