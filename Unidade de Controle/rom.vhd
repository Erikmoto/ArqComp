-- Arquitetura e Organização de Computadores
-- Arquivo: rom.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 19/10/17

library	ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	port (clk		:in std_logic;
		  endereco	:in unsigned (15 downto 0);
		  dado		:out unsigned (14 downto 0)
	);
end entity;

architecture a_rom of rom is
	type mem is array (0 to 127) of unsigned (14 downto 0);
	constant conteudo_rom : mem := (

		0 => "000000000000000", 	-- 0 -- NOP
		1 => "000000000000001", 	-- 1 -- 1
		2 => "000000000000010", 	-- 2 -- 2
		3 => "000000000000011", 	-- 3 -- 3
		4 => "000000000000100", 	-- 4 -- 4
		5 => "000000000000101", 	-- 5 -- 5
		6 => "000000000000110", 	-- 6 -- 6
		7 => "000000000000111", 	-- 7 -- 7
		8 => "000000000001000", 	-- 8 -- 8
		9 => "000000000001001", 	-- 9 -- 9
		10 => "000000000001010", -- 10 -- A
		11 => "000000000001011", -- 11 -- B
		12 => "000000000001100", -- 12 -- C
		13 => "000000000001101", -- 13 -- D
		14 => "000000000001110", -- 14 -- E
		15 => "000000000001111", -- 15 -- F

		--------------------------------------
		-- tipo I
		-- opcode/source/Ad/BW/As/destination  -- MOV src,dst
		--  0100/ 0110 / 0/ 0/00/  0101	       -- MOV  R3, R5
		---------------------------------------

		-- teste para somar dois valores --

		--0 => "0000000000000000",	-- NOP
		--1 => "0100000001011011",	-- MOV 5, R3
		--2 => "0100000001001100",	-- MOV 5, R4
		--3 => "0000000000000000",	-- NOP
		--4 => "0101100000000011",	-- ADD R4, R3
		--5 => "0000000000000000",	-- NOP

		-- teste para subtrair valores --

		--0 => "0000000000000000",	-- NOP
		--1 => "0100000001011011",	-- MOV 5, R3
		--2 => "0100011000000101",	-- MOV R3, R5
		--3 => "1000000000011101",	-- SUB 1, R5
		--4 => "0000000000000000",	-- NOP

		-- teste de salto --
		--0 => "0000000000000000",	-- NOP
		--1 => "0100000001011011",	-- MOV 5, R3
		--2 => "0100000001001100",	-- MOV 5, R4
		--3 => "0000000000000000",	-- NOP
		--4 => "0101100000000011",	-- ADD R4, R3
		--5 => "0000000000000000",	-- NOP
		--6 => "0100011000000101",	-- MOV R3, R5
		--7 => "1000000000011101",	-- SUB 1, R5
		--8 => "0011110000000111",	-- JMP #6 -- 7 linha



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
