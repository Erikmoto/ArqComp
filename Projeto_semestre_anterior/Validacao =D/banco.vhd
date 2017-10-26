--o banco usando o reg16bits como referencia

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
 
entity banco is   
	port( 	clk      	: in std_logic;         
			rst      	: in std_logic;
			wr_en    	: in std_logic;
			sel_reg1 	: in unsigned (2 downto 0); 	--seleciona qual o primeiro reg a ser lido.. 8 registradores, 3 bits
			sel_reg2 	: in unsigned (2 downto 0);		--seleciona qual o segundo reg a ser lido..8 registradores, 3 bits
			sel_wr_reg	: in unsigned (2 downto 0); 	-- seleciona em qual reg escreve
			data_in  	: in unsigned(15 downto 0); 	--valor a ser escrito
			data_out1 	: out unsigned(15 downto 0); 	-- dado do primeiro reg
			data_out2 	: out unsigned(15 downto 0)		-- dado do segundo reg		
		);
end entity;

architecture a_banco of banco is
   signal registro0: unsigned(15 downto 0):="0000000000000000";
   signal registro1: unsigned(15 downto 0):="0000000000000000";
   signal registro2: unsigned(15 downto 0):="0000000000000000";
   signal registro3: unsigned(15 downto 0):="0000000000000000";
   signal registro4: unsigned(15 downto 0):="0000000000000000";
   signal registro5: unsigned(15 downto 0):="0000000000000000";
   signal registro6: unsigned(15 downto 0):="0000000000000000";
   signal registro7: unsigned(15 downto 0):="0000000000000000";
   
begin
	data_out1 <= registro0 when sel_reg1 = "000" else
				 registro1 when sel_reg1 = "001" else
				 registro2 when sel_reg1 = "010" else
				 registro3 when sel_reg1 = "011" else
				 registro4 when sel_reg1 = "100" else
				 registro5 when sel_reg1 = "101" else
				 registro6 when sel_reg1 = "110" else
				 registro7 when sel_reg1 = "111" else
				 "0000000000000000";

	data_out2 <= registro0 when sel_reg2 = "000" else
				 registro1 when sel_reg2 = "001" else
				 registro2 when sel_reg2 = "010" else
				 registro3 when sel_reg2 = "011" else
			 	 registro4 when sel_reg2 = "100" else
				 registro5 when sel_reg2 = "101" else
				 registro6 when sel_reg2 = "110" else
				 registro7 when sel_reg2 = "111" else
				 "0000000000000000";
	
   process(clk,rst,wr_en,sel_wr_reg)  -- acionado se houver mudança em clk, rst ou wr_en
   begin
		if rst='1' then
			registro0 <= "0000000000000000";
			registro1 <= "0000000000000000";
			registro2 <= "0000000000000000";
			registro3 <= "0000000000000000";
			registro4 <= "0000000000000000";
			registro5 <= "0000000000000000";
			registro6 <= "0000000000000000";
			registro7 <= "0000000000000000";
		elsif wr_en='1' then
			if rising_edge(clk) then
				if sel_wr_reg = "000" then registro0 <= "0000000000000000"; end if;
				if sel_wr_reg = "001" then registro1 <= data_in; end if;
				if sel_wr_reg = "010" then registro2 <= data_in; end if;
				if sel_wr_reg = "011" then registro3 <= data_in; end if;
				if sel_wr_reg = "100" then registro4 <= data_in; end if;				
				if sel_wr_reg = "101" then registro5 <= data_in; end if;
				if sel_wr_reg = "110" then registro6 <= data_in; end if;
				if sel_wr_reg = "111" then registro7 <= data_in; end if;
			end if;
		end if;
	end process;
end architecture;

