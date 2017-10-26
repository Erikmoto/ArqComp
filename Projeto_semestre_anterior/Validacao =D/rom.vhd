library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	port(   clk : in std_logic;
			endereco : in unsigned(9 downto 0);
			dado : out unsigned(15 downto 0)
		);
end entity;

architecture a_rom of rom is
	type mem is array (0 to 127) of unsigned(15 downto 0);
	constant conteudo_rom : mem := (

-- Inicializacao de variaveis (dado, endereco,)	
				0 => "0000000000000000",		-- NOP
				1 => "0100000000011001", 		-- MOV 1, R1 		-- endereco 
				2 => "0100000000011010", 		-- MOV 1, R2 		-- dado
				3 => "0000000000000000",		-- NOP
				4 => "0100000000011011", 		-- MOV 1, R3 		-- variavel soma 1 
				5 => "0100001000011100", 		-- MOV 33, R4 		-- quantidade de loops (33) - ateh 33 pq em COMP para quando for igual 
				6 => "0000000000000000",		-- NOP
--LOOPMEM: 										--loop de preenchimento de memoria
				7 => "0000000000000000",		-- NOP
				8 => "1100010000000001", 		-- ST R2,R1 		-- guarda dado na memoria    MOV R2,@R1
				9 => "0000000000000000",		-- NOP
				10 => "0101011000000001", 		-- ADD R3,R1 		-- incrementa 1 no R1 
				11 => "0101011000000010", 		-- ADD R3,R2 		-- incrementa 1 no R2 
				12 => "0000000000000000",		-- NOP
				13 => "1001100000000010", 		-- CMP R4,R2 		-- se R6 for maior ou igual,seta a flag 
				14 => "0011011111110110", 		-- BLR -10 			-- LOOPMEM  
--********************************************* 
--			FIM DO PREENCHIMENTO DE MEMORIA 
--			Inicio do processo e deteccao dos primos
				15 => "0000000000000000",		-- NOP			-- comeca com multiplos de 2
				16 => "0100000000101001", 		-- MOV 2,R1		-- inicio com endereco em 2 
				17 => "0100000000101010", 		-- MOV 2,R2		-- dado comecando em 2
				18 => "0000000000000000",		-- NOP
--ZERA_DADO:		-- LOOP QUE ZERA OS MULTIPLOS DE PRIMOS 
				19 => "0000000000000000",		-- NOP
				20 => "0101001000000010", 		-- ADD R1,R2	--soma o valor do dado no endereço 
				21 => "0000000000000000",		-- NOP
				22 => "1100000000000010", 		-- ST R0,R2		--(endereço, dado) grava 0 no endereço 
				23 => "0000000000000000",		-- NOP
				24 => "0000000000000000",		-- NOP
				25 => "1001100000000010", 		-- CMP R4,R2 		-- se R2 for maior ou igual,seta a flag  
				26 => "0011011111110111", 		-- BLR -7 			-- ZERA_DADO
				27 => "0000000000000000",		-- NOP
--			FIM DE ZERAR AS POSICOES PARA UM VALOR 
				28 => "0100001000000010", 		-- MOV R1,R2		-- pega o dado do ultimo valor usado e coloca no endereço 
				29 => "0000000000000000",
--CHECKNEXT: 									-- loop de comparacao com 0 para ver so o numero ja foi zerado ou nao
												-- se o dado no endereco ja tiver sido zerado, continua no loop
												-- se o dado nao for zero, vai para a instrucao de zerar_dado para zerar os multiplos deste
				30 => "0101011000000001", 		-- ADD R3,R1		-- soma 1 no endereço pra pegar o próximo 
				31 => "0000000000000000",		-- NOP
				32 => "1101010000000001", 		-- LD R2,R1			-- pega no R1 o valor do endereco pra ver se já esta zero 
				33 => "0000000000000000",		-- NOP
				34 => "1001100000000001",		-- CMP R4,R1
				35 => "0010000000100111",		-- BGEA 39          -- comparacao necessaria para sair do loop quando terminar
				36 => "0000000000000000",		-- NOP
				37 => "1001011000000010", 		-- CMP R3,R2		-- compara com 1 para ver se é = 0 
				38 => "0011000000011110", 		-- BLA 30			-- CHECKNEXT 
				39 => "0000000000000000",		-- NOP
--			SAIU DO LOOP, NO R2 ESTA O PROXIMO VALOR A SER ZERADO 
				40 => "0000000000000000",		-- NOP
				41 => "0100001000000010", 		-- MOV R2,R1		-- coloca o dado = endereço
				42 => "0000000000000000",		-- NOP
				43 => "1001100000000001", 		-- CMP R4,R1 		-- compara se ja chegou no final 
				44 => "0011000000010011", 		-- BLA 19			-- LOOP ZERA 
				45 => "0000000000000000",		-- NOP
--********************************************* 
--		CHEGOU AQUI, ACABOU O PROGRAMA 
--		LER AS MEMORIAS EM ORDEM PRA VER SE TA TUDO CERTO 
				-- Reinicializacao de variaveis (dado, endereco,)	
				46 => "0100000000011001", 		-- MOV 1, R1 		-- endereco
				47 => "0100000000011010", 		-- MOV 1, R2 		-- dado 
				48 => "0000000000000000",		-- NOP
--CHECKNEXT2: 									-- detecta se dado no endereco eh zero, para achar os primos
				49 => "0101011000000001", 		-- ADD R3,R1		-- soma 1 no endereço pra pegar o próximo 
				50 => "0000000000000000",		-- NOP
				51 => "1101010000000001", 		-- LD R2,R1			-- pega no R1 o valor do endereco pra ver se já esta zero 
				52 => "0000000000000000",		-- NOP
				53 => "1001100000000001",		-- CMP R4,R1
				54 => "0010000000111011",		-- BGEA 59          -- MANDA PRA R5 -- comparacao necessaria para sair do loop quando terminar
				55 => "0000000000000000",		-- NOP
				56 => "1001011000000010", 		-- CMP R3,R2		-- compara com 1 para ver se é = 0 
				57 => "0011000000110000", 		-- BLA 48			-- CHECKNEXT 2
				58 => "0000000000000000",		-- NOP
--MANDA PRA R5:									-- escreve em R5
				59 => "1001100000000001",		-- CMP R4,R1		
				60 => "0010000001000111",		-- BGEA 70          -- ACABOU -- comparacao necessaria para sair do loop quando terminar
				61 => "0000000000000000",		-- NOP
				
				62 => "1001011000000010", 		-- CMP R3,R2		-- compara com 1 para ver se é = 0 
				63 => "0011000000110000", 		-- BLA 48			-- CHECKNEXT 2
				64 => "0000000000000000",		-- NOP
				
				65 => "1101101000000001",		-- LD R5,R1			-- escreve o primo em R5
				66 => "0000000000000000",		-- NOP
				
				67 => "0100001000000010", 		-- MOV R2,R1		-- coloca o dado = endereço
				68 => "0000000000000000",		-- NOP
				69 => "1001100000000001", 		-- CMP R4,R1 		-- compara se ja chegou no final 
				70 => "0011000000110000", 		-- BLA 48			-- CHECKNEXT2
--ACABOU 

	
	
	
	
	

	-- uProcessador 4
	-- VERIFICACAO DO CODIGO DE JMP
	--				0 => "0000000000000010",
	--				1 => "0011110000000011",	--JMP 3	- pula para o endereco 3
	--				2 => "0000000000000100",
	--				3 => "0000000000001000",	-- continua
	--				4 => "0000000000010000",
	--				5 => "0000000000100000",
	--				6 => "0011110000000011",	--JMP 3	- volta pro endereco 3 , loop eterno
	--				7 => "0000000010000000",
	--				8 => "0000000100000000",
	--				9 => "0000001000000000",
	--				10 => "0000010000000000",
	
	-- uProcessador 5
	-- VERIFICACAO	DO PROCESSADOR COM OPERACOES DA ULA E BANCO DE REGISTRADORES (MOV, ADD, SUB)		
	--				0 => "0000000000000000",	-- NOP
	--				1 => "0100000001011011",	-- MOV 5, R3
	--				2 => "0100000010001100",	-- MOV 8, R4
	--				3 => "0000000000000000",	-- NOP
	--				4 => "0101100000000011",	-- ADD R4, R3
	--				5 => "0100011000000101",	-- MOV R3, R5
	--				6 => "1000000000011101",	-- SUB 1, R5
	--				7 => "0011110000010110",	-- JMP #21
	--				8 => "0000000000000000",  	-- NOP
	--				9 => "0000000000000001", 	-- 1
	--				10 => "0000000000000010", 	-- 2
	--				11 => "0000000000000011", 	-- 3
	--				12 => "0000000000000100", 	-- 4
	--				13 => "0000000000000101", 	-- 5
	--				14 => "0000000000000110", 	-- 6
	--				15 => "0000000000000111", 	-- 7
	--				16 => "0000000000001000", 	-- 8
	--				17 => "0000000000001001", 	-- 9
	--				18 => "0000000000001010", 	-- A
	--				19 => "0000000000001011", 	-- B
	--				20 => "0000000000001100", 	-- C
	--				21 => "0000000000001101", 	-- D
	--				22 => "0100101000000011", 	-- MOV R5, R3
	--				23 => "0011110000000100",	-- JMP #3
	
	-- uProcessador 6
	-- VERIFICACAO DOS SALTOS/DESVIOS CONDICIONAIS E COMPARADOR (BGEA, BGER, BLA, BLR, CMP)
	--				0 => "0000000000000000",	-- NOP
	--				1 => "0100000000001011",	-- MOV 0, R3
	--				2 => "0100000000001100",	-- MOV 0, R4
	--				3 => "0000000000000000",	-- NOP
	--				4 => "0101011000000100",	-- ADD R3, R4
	--				5 => "0101000000011011",	-- ADD 1, R3
	--				6 => "0000000000000000",	-- NOP
	--				7 => "1001000111101011",	-- CMP 30, R3 (se R3 for maior ou igual a 2 o flag fica 1)
	--				8 => "0011011111111011",	-- BLR -5
	--				9 => "0000000000000000",	-- NOP
	--				10 => "0100100000000101",	-- MOV R4, R5
	

	-- uProcessador 7 
	-- VERIFICACAO DAS OPERACOES COM RAM (ST E LD)				
	--				0 => "0000000000000000",		-- NOP
	--				1 => "0100000011111001",   		-- MOV 15,R1
	--				2 => "0100000001111010",		-- MOV 7,R2
	--				3 => "0000000000000000",   		-- NOP
	--				4 => "1100001000000010",   		-- ST R1,R2 	-- (15 no endereço 7) Rs, @Rd
	--				5 => "0000000000000000",   		-- NOP
	--				6 => "0100000001011100",   		-- MOV 5,R4
	--				7 => "0100000010001101",   		-- MOV 8,R5    
	--				8 => "0000000000000000",   		-- NOP
	--				9 => "0101000001001100",  		-- ADD 4,R4
	--				10 => "0000000000000000",   	-- NOP
	--				11 => "1101110000000010",		-- LD R6, R2 	-- carrega 15 no R6 -> Rs, @Rd
	--				12 => "0000000000000000",   	-- NOP
	--				13 => "0101000000101101",   	-- ADD 2,R5   
	--				14 => "0000000000000000",  		-- NOP
	--				15 => "1101011000000010",		-- LD R3, R2 	-- carrega 15 no R3 ->	Rs, @Rd
	--				16 => "0000000000000000",		-- NOP
	--				17 => "1100100000000101", 		-- ST R4,R5    -- (9 no endereco 10) Rs, @Rd
	--				18 => "0000000000000000",  		-- NOP
	--				19 => "1100100000000010", 		-- ST R4,R2    -- escreve endereço 7 com 9
	--				20 => "0000000000000000",  		-- NOP

	-- abaixo: casos omissos => (zero em todos os bits)
	others => (others=>'0')
	);
	
begin
	process(clk)
	begin
		if(	rising_edge(clk)) then
			dado <= conteudo_rom(to_integer(endereco));
		end if;
	end process;
end architecture;