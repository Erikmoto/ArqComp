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

		--0 => "010000001011011",		-- MOV 5, R3
		--1 => "010000010001100",		-- MOV 8, R3
		--2 => "010110000000011",		-- ADD R4, R3
		--3 => "010001100000101",		-- MOV R3, R5
		--4 => "100000000001101",		-- SUB 1, R5
		--5 => "001111000010100",		-- JMP #20
		--6 => "100000000000000",		-- NOP
		--7 => "000000000000000",		-- NOP
		--8 => "000000000000000",  	-- NOP
		--9 => "000000000000001", 	-- 1
		--10 => "000000000000010", 	-- 2
		--11 => "000000000000011", 	-- 3
		--12 => "000000000000100", 	-- 4
		--13 => "000000000000101", 	-- 5
		--14 => "001111000000001", 	-- JMP #1
		--15 => "000000000000111", 	-- 7
		--16 => "000000000001000", 	-- 8
		--17 => "000000000001001", 	-- 9
		--18 => "000000000001010", 	-- A
		--19 => "000000000001011", 	-- B
		--20 => "010001010000011", 	-- MOV R5, R3
		--21 => "001111000000010", 	-- JMP #2
		--22 => "000000000001110", 	-- E
		--23 => "000000000001111", 	-- F
		--24 => "010010100000011", 	-- MOV R5, R3
		--25 => "001111000000100",	-- jmp 3


		-- lab 06

		--0 => "010000000001011",		-- MOV 0, R3
		--1 => "010000000001100",		-- MOV 0, R4
		--2 => "010101100000100",		-- ADD R3, R4
		--3 => "010100000011011",		-- ADD 1, R3
		--4 => "100100111101011",		-- CMP 30, R3
		--5 => "001101111111101",		-- JMP -3
		--6 => "010010000000101",		-- MOV R4, R5
		--7 => "000000000000000",		-- NOP


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
		0 => "010000000011001",		-- MOV 1, R1 		-- usar como endereco
		1 => "010000000011010", 	-- MOV 1, R2 		-- usar como dado
		2 => "010000000011011", 	-- MOV 1, R3 		-- variavel soma 1
		3 => "010001000011100",		-- MOV 33, R4 		-- quantidade de loops (33) - 33 comparacoes caso for igual
		-- LOOP1:			--loop para escrita na memória
		4 => "110001000000001", 	-- ST R2,R1 		-- guarda dado na memoria    MOV R2,@R1
		5 => "010101100000001", 	-- ADD R3,R1 		-- incrementa 1 no R1
		6 => "010101100000010",		-- ADD R3,R2 		-- incrementa 1 no R2
		7 => "100110000000010",		-- CMP R4,R2 		-- compara R4 com R2: se verdadeiro (R2 < R4), próxima instrução, senão pula a próxima instrução
		8 => "001101111111100", 	-- BLR -4 			-- salta para LOOP1 (Endereço 4)
	--*************************************************************************************************
	--2 -> escrever 2 na lista
		9 => "010000000101001",		-- MOV 2,R1		-- inicio com endereco em 2
		10 => "010000000011110", 	-- MOV 1,R6		-- registrador utilizado para evitar acesso à endereços maiores que o número a ser comparado
	--*************************************************************************************************
	--3 -> eliminar todos os multiplos de 2 seguintes
		-- LOOP2 		-- zerara os multiplos
		11 => "010000100000010", 	-- MOV R1,R2	-- copia R1 em R2
		12 => "010100100000010", 	-- ADD R1,R2	-- soma R1 em R2: próximo múltiplo de R1
		13 => "110110100000010", 	-- LD R5,R2		-- carrega R5 com dado do endereço de R2
		14 => "100110100000000",	-- CMP R5,R0	-- compara R5 com zero: se verdadeiro (R0 < R5), próxima instrução, senão pula a próxima instrução
		15 => "110000000000010",	-- ST R0,R2		-- (endereço, dado) grava 0 no endereço
		16 => "010001000000101", 	-- MOV R2,R5	-- copia R2 em R5
		17 => "010111000000101", 	-- ADD R6,R5	-- soma R6 em R5 para verificar se ocorrerá acesso a um endereço de memória indevido
		18 => "100110000000101", 	-- CMP R4,R5 	-- compara R4 com R5: se verdadeiro (R5 < R4), próxima instrução, senão pula a próxima instrução
		19 => "001101111111001", 	-- BLR -7 		-- salta -7
	--*************************************************************************************************
	--4 -> compara o numero com zero pra saber se ja foi zerado
		-- LOOP3
		20 => "110110100000001", 	-- LD R5,R1		-- carrega R5 com dado do endereço de R1
		21 => "100110100000000",	-- CMP R5,R0	-- compara R5 com zero: se verdadeiro (R0 < R5), próxima instrução, senão pula a próxima instrução
		22 => "110111100000001", 	-- LD R7,R1		-- saída: carrega R7 com dado do endereço de R1
		23 => "010101100000001", 	-- ADD R3,R1	-- soma 1 no endereço anterior pra ir ao proximo endereço
		24 => "010101100000110", 	-- ADD R3,R6	-- soma 1 no R6
		25 => "110110100000001", 	-- LD R5,R1		-- carrega R5 com dado do endereço de R1
		26 => "100110100000000",	-- CMP R5,R0	-- compara R5 com zero: se verdadeiro (R0 < R5), próxima instrução, senão pula a próxima instrução
		27 => "001101111110000",	-- BLR -16		-- salta -16
		28 => "100110000000101",	-- CMP R4,R5	-- compara R4 com R5: se verdadeiro (R5 < R4), próxima instrução, senão pula a próxima instrução
		29 => "001101111111010",	-- BLR -6			-- salta -6
		30 => "000000000000000", 	-- NOP

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
