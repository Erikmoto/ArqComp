-- Arquitetura e Organização de Computadores
-- Arquivo: ula_16bits_tb.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_16bits_tb is
end;

architecture a_ula_16bits_tb of ula_16bits_tb is
	component ula_16bits
		port (	entr0, entr1								: in unsigned (15 downto 0);
			sel0											: in unsigned (1 downto 0);
			soma, subtrai, select_maior, modulo_adicao 		: inout unsigned (15 downto 0);
			saida											: out unsigned(15 downto 0);
			compara											: out std_logic
		);
	end component;

	signal entr0, entr1, saida, soma, subtrai, select_maior, maior_igual, modulo_adicao : unsigned (15 downto 0);
	signal sel0 : unsigned (1 downto 0);
	signal compara : std_logic;

	begin uut : ula_16bits port map(entr0 => entr0, entr1 => entr1,
																	sel0 => sel0,
																	saida => saida, subtrai => subtrai, select_maior => select_maior, modulo_adicao => modulo_adicao,
																	compara => compara);

	process
		begin
			------------------------------ Teste Soma ------------------------------

			sel0 <= "00";

			entr0 <= "0000000000000000"; -- 0d
			entr1 <= "0000000000000000"; -- 0d
			-- saida = "0000_h" = 0d
			wait for 50 ns;

			entr0 <= "0000000000000000"; -- 0d
			entr1 <= "1111111111111111"; -- -1d
			-- saida = "FFFF_h" = -1d
			wait for 50 ns;

			entr0 <= "1111111111111111"; -- -1d
			entr1 <= "0000000000000000"; -- 0d
			-- saida = "FFFF_h" = -1d
			wait for 50 ns;

			entr0 <= "1111111111111111"; -- -1d
			entr1 <= "1111111111111111"; -- -1d
			-- saida = "FFFE_h" = -2d
			wait for 50 ns;

			entr0 <= "0000000000100000"; -- 32d
			entr1 <= "0000000000010000"; -- 16d
			-- saida = "0030_h" = 48d
			wait for 50 ns;

			entr0 <= "0000000100000000"; -- 256d
			entr1 <= "0000000010000000"; -- 128d
			-- saida = "0180_h" = 384d
			wait for 50 ns;

			entr0 <= "0000010000000000"; -- 1024d
			entr1 <= "0000001000000000"; -- 512d
			-- saida = "0600_h" = 1536d
			wait for 50 ns;

			entr0 <= "0000100000000000"; -- 2048d
			entr1 <= "0001000000000000"; -- 4096d
			-- saida = "1800_h" = 6144d
			wait for 50 ns;

			entr0 <= "0010000000000000"; -- 8192d
			entr1 <= "0001000000000000"; -- 4096d
			-- saida = "3000_h" = 12288d
			wait for 50 ns;

			entr0 <= "0100000000000000"; -- 16384d
			entr1 <= "0100000000000000"; -- 16384d
			-- saida = "8000_h" = 32768d = -32768d
			wait for 50 ns;

			entr0 <= "1000000000000000"; -- -32768d
			entr1 <= "1000000000000000"; -- -32768d
			-- saida = "0000_h" = -65536d = 0d
			wait for 50 ns;

			------------------------------ Teste Subtração ------------------------------

			sel0 <= "01";

			entr0 <= "0000000000000000"; -- 0d
			entr1 <= "0000000000000000"; -- 0d
			-- saida = "0000_h" = 0d
			wait for 50 ns;

			entr0 <= "0000000000000000"; -- 0d
			entr1 <= "1111111111111111"; -- -1d
			-- saida = "0001_h" = +1d
			wait for 50 ns;

			entr0 <= "1111111111111111"; -- -1d
			entr1 <= "0000000000000000"; -- 0d
			-- saida = "FFFF_h" = -1d
			wait for 50 ns;

			entr0 <= "1111111111111111"; -- -1d
			entr1 <= "1111111111111111"; -- -1d
			-- saida = "0000_h" = 0d
			wait for 50 ns;

			entr0 <= "0000010000000000"; -- 1024d
			entr1 <= "0000001000000000"; -- 512d
			-- saida = "0200_h" = 512d
			wait for 50 ns;

			entr0 <= "0001000000000000"; -- 4096d
			entr1 <= "0000001000000000"; -- 512d
			-- saida = "0E00_h" = 3584d
			wait for 50 ns;

			entr0 <= "0010000000000000"; -- 8192d
			entr1 <= "0000010000000000"; -- 1024d
			-- saida = "1C00_h" = 7168d
			wait for 50 ns;

			entr0 <= "0100000000000000"; -- 16384d
			entr1 <= "0000001000000000"; -- 512d
			-- saida = "3E00_h" = 15872d
			wait for 50 ns;

			entr0 <= "1000000000000000"; -- -32768d
			entr1 <= "1000000000000000"; -- -32768d
			-- saida = "0000_h" = 0d
			wait for 50 ns;

			entr0 <= "1000000000000000"; -- -32768d
			entr1 <= "0111111111111111"; -- 32767d
			-- saida = "0001_h" = -65535d = 1d
			wait for 50 ns;

			------------------------------ Teste Seleciona Maior ------------------------------

			sel0 <= "10";

			entr0 <= "0000000000000000"; -- 0d
			entr1 <= "0000000000000000"; -- 0d
			-- saida = "0000_h" = 0d
			wait for 50 ns;

			entr0 <= "0000000000000000"; -- 0d
			entr1 <= "1111111111111111"; -- -1d
			-- saida = "0000_h" = 0d
			wait for 50 ns;

			entr0 <= "1111111111111111"; -- -1d
			entr1 <= "0000000000000000"; -- 0d
			-- saida = "0000_h" = 0d
			wait for 50 ns;

			entr0 <= "1111111111111111"; -- -1d
			entr1 <= "1111111111111111"; -- -1d
			-- saida = "FFFF_h" = -1d
			wait for 50 ns;

			entr0 <= "0000000000100000"; -- 32d
			entr1 <= "0000000000010000"; -- 16d
			wait for 50 ns;

			entr0 <= "0000000100000000"; -- 256d
			entr1 <= "0000000010000000"; -- 128d
			wait for 50 ns;

			entr0 <= "0000001000000000"; -- 512d
			entr1 <= "0000010000000000"; -- 1024d
			wait for 50 ns;

			entr0 <= "0000100000000000"; -- 2048d
			entr1 <= "0001000000000000"; -- 4096d
			wait for 50 ns;

			entr0 <= "0001000000000000"; -- 4096d
			entr1 <= "0010000000000000"; -- 8192d
			wait for 50 ns;

			------------------------------ Teste Módulo da Adição ------------------------------

			sel0 <= "11";

			entr0 <= "0000000000000000"; -- 0d
			entr1 <= "0000000000000000"; -- 0d
			-- saida = "0000_h" = 0d
			wait for 50 ns;

			entr0 <= "0000000000000000"; -- 0d
			entr1 <= "1111111111111111"; -- -1d
			-- saida = "0001_h" = 1d
			wait for 50 ns;

			entr0 <= "1111111111111111"; -- -1d
			entr1 <= "0000000000000000"; -- 0d
			-- saida = "0001_h" = 1d
			wait for 50 ns;

			entr0 <= "1111111111111111"; -- -1d
			entr1 <= "1111111111111111"; -- -1d
			-- saida = "0002_h" = 2d
			wait for 50 ns;

			entr0 <= "0000000000100000"; -- 32d
			entr1 <= "0000000000010000"; -- 16d
			wait for 50 ns;

			entr0 <= "0000000100000000"; -- 256d
			entr1 <= "0000000010000000"; -- 128d
			wait for 50 ns;

			entr0 <= "0000010000000000"; -- 1024d
			entr1 <= "0000001000000000"; -- 512d
			wait for 50 ns;

			entr0 <= "0000100000000000"; -- 2048d
			entr1 <= "0001000000000000"; -- 4096d
			wait for 50 ns;

			entr0 <= "0010000000000000"; -- 8192d
			entr1 <= "0001000000000000"; -- 4096d
			wait for 50 ns;

			wait;

	end process;
end architecture;
