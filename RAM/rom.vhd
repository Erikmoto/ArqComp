-- Arquitetura e Organização de Computadores
-- Arquivo: rom.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 26/10/17

library	ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	port (
		clk		:in std_logic;
	  endereco	:in unsigned (15 downto 0);
	  dado		:out unsigned (14 downto 0)
	);
end entity;

architecture a_rom of rom is
	type mem is array (0 to 127) of unsigned (14 downto 0);
	constant conteudo_rom : mem := (


		-- lab 04

		--0 => "000000000000000", 	-- 0 -- NOP
		--1 => "000000000000001", 	-- 1 -- 1
		--2 => "000000000000010", 	-- 2 -- 2
		--3 => "000000000000011", 	-- 3 -- 3
		--4 => "000000000000100", 	-- 4 -- 4
		--5 => "000000000000101", 	-- 5 -- 5
		--6 => "000000000000110", 	-- 6 -- 6
		--7 => "000000000000111", 	-- 7 -- 7
		--8 => "000000000001000", 	-- 8 -- 8
		--9 => "000000000001001", 	-- 9 -- 9
		--10 => "000000000001010", -- 10 -- A
		--11 => "000000000001011", -- 11 -- B
		--12 => "000000000001100", -- 12 -- C
		--13 => "000000000001101", -- 13 -- D
		--14 => "000000000001110", -- 14 -- E
		--15 => "000000000001111", -- 15 -- F


		-- lab 05
		--------------------------------------
		-- tipo I
		-- opcode/source/Ad/BW/As/destination  -- MOV src,dst
		--  0100/ 0110 / 0/ 0/00/  0101	       -- MOV  R3, R5
		---------------------------------------

		--0 => "001111000001110",		-- JMP #14
		--1 => "010000000101011",		-- MOV 5, R3
		--2 => "010000001000100",		-- MOV 8, R4
		--3 => "000000000000000",		-- NOP
		--4 => "010110000000011",		-- ADD R4, R3
		--5 => "010001100000101",		-- MOV R3, R5
		--6 => "100000000001101",		-- SUB 1, R5
		--7 => "000000000000000",		-- NOP
		--8 => "000000000000000",  	-- NOP
		--9 => "000000000000001", 	-- 1
		--10 => "000000000000010", 	-- 2
		--11 => "000000000000011", 	-- 3
		--12 => "000000000000100", 	-- 4
		--13 => "000000000000101", 	-- 5
		--14 => "000000000000110", 	-- 6
		--15 => "000000000000111", 	-- 7
		--16 => "000000000001000", 	-- 8
		--17 => "000000000001001", 	-- 9
		--18 => "000000000001010", 	-- A
		--19 => "000000000001011", 	-- B
		--20 => "000000000001100", 	-- C
		--21 => "000000000001101", 	-- D
		--22 => "000000000001110", 	-- E
		--23 => "000000000001111", 	-- F
		--24 => "010010100000011", 	-- MOV R5, R3
		--25 => "001111000000100",	-- jmp 3

		
		-- lab 06
		
		--0 => "000000000000000",	-- NOP
		--1 => "010000000001011",	-- MOV 0, R3
		--2 => "010000000001100",	-- MOV 0, R4
		--3 => "000000000000000",	-- NOP
		--4 => "010101100000100",	-- ADD R3, R4
		--5 => "010100000011011",	-- ADD 1, R3
		--6 => "000000000000000",	-- NOP
		--7 => "100100011111011",	-- CMP 30, R3 (se R3 for maior ou igual a 2 o flag fica 1)
		--8 => "001101111111011",	-- BLR 	volta para -5
		--9 => "000000000000000",	-- NOP
		--10 => "010010000000101", -- MOV R4, R5

		-- lab 07 -- leitura e escrita na memória 
		
	--0 => "010000011111001",   		-- MOV 15,R1
	--1 => "010000001111010",	    	-- MOV 7,R2
	--2 => "000000000000000",   		-- NOP
	--3 => "110000100000010",   		-- ST R1,R2  (15 no endereço que tem o 7) Rs, @Rd
	--4 => "000000000000000",   		-- NOP
	--5 => "010000001011100",   		-- MOV 5,R4
	--6 => "010000010001101",   		-- MOV 8,R5    
	--7 => "000000000000000",   		-- NOP
	--8 => "010100001001100",  		-- ADD 4,R4
	--9 => "000000000000000",   		-- NOP
	--10 => "110111000000010",		-- LD R6, R2 	(carrega 15 no R6) Rs, @Rd
	--11 => "000000000000000",   		-- NOP
	--12 => "010100000101101",    	-- ADD 2,R5   
	--13 => "000000000000000",  		-- NOP
	--14 => "110101100000010",		-- LD R3, R2 	(carrega 15 no R3)	Rs, @Rd
	--15 => "000000000000000",		-- NOP
	--16 => "110010000000101", 		-- ST R4,R5    	(9 no endereco 10) Rs, @Rd
	--17 => "000000000000000",  		-- NOP
	--18 => "110010000000010", 		-- ST R4,R2    (escreve endereço 7 com 9)
	
	--Validação: Crivo de Eratóstenes
	--Passos: 
	--1 -> criar lista de 1 a 30
	--2 -> escreve 2 na lista
	--3 -> eliminar todos os múltiplos de 2 seguintes
	--4 -> escreve 3
	--5 -> eliminar todos os multiplos de 3 seguintes
	--6 -> escreve 5
	--7 -> eliminar todos os múltiplosd de 5 seguintes
	--8 -> escreve 7
	--9 -> eliminar todos os multiplos de 7 seguintes
	--10 -> escrever os números restantes, são os primos
	-- 2, 3, 5, 7, 11, 13, 17, 19, 23, 29
	
	--1 -> Criar lista de 1 a 30 na memoria
		0 => "000000000000000",		-- NOP
		1 => "010000000011001", 	-- MOV 1, R1 		-- usar como endereco 
		2 => "010000000011010", 	-- MOV 1, R2 		-- usar como dado
		3 => "000000000000000",		-- NOP
		4 => "010000000011011", 	-- MOV 1, R3 		-- variavel soma 1 
		5 => "010000100011100", 	-- MOV 33, R4 		-- quantidade de loops (33) - 33 comparacoes caso for igual 
		6 => "000000000000000",		-- NOP
									-- LOOP1:			--loop para escrita na memória 										
		7 => "000000000000000",		-- NOP
		8 => "110001000000001", 	-- ST R2,R1 		-- guarda dado na memoria    MOV R2,@R1
		9 => "000000000000000",		-- NOP
		10 => "010101100000001", 	-- ADD R3,R1 		-- incrementa 1 no R1 
		11 => "010101100000010", 	-- ADD R3,R2 		-- incrementa 1 no R2 
		12 => "000000000000000",	-- NOP
		13 => "100110000000010", 	-- CMP R4,R2 		-- se R6 for maior ou igual,seta a flag 
		14 => "001101111110110", 	-- BLR -6 			-- salta para LOOP1 (6)
	--*************************************************************************************************
	--2 -> escrever 2 na lista
		15 => "000000000000000",	-- NOP			
		16 => "010000000101001", 	-- MOV 2,R1		-- inicio com endereco em 2 
		17 => "010000000101010", 	-- MOV 2,R2		-- dado comecando em 2
		18 => "000000000000000",	-- NOP
	--*************************************************************************************************
	--3 -> eliminar todos os multiplos de 2 seguintes
									-- LOOP2 		-- zerara os multiplos 
		19 => "000000000000000",	-- NOP
		20 => "010100100000010", 	-- ADD R1,R2	--soma o valor do dado no endereço 
		21 => "000000000000000",	-- NOP
		22 => "110000000000010", 	-- ST R0,R2		--(endereço, dado) grava 0 no endereço 
		23 => "000000000000000",	-- NOP
		24 => "000000000000000",	-- NOP
		25 => "100110000000010", 	-- CMP R4,R2 	-- se R2 for maior ou igual,seta a flag  
		26 => "001101111110111", 	-- BLR -7 		-- salta para LOOP2
		27 => "000000000000000",	-- NOP
	
	
	
	
		others => (others => '0')
	);
begin
	process (clk)
	begin
		if (rising_edge (clk)) then
			dado <= conteudo_rom(to_integer(endereco));
		end if;
	end process;
end architecture;
