-- Arquitetura e Organização de Computadores
-- Arquivo: proto_UC.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 09/11/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_rom is
	port (
		top_out	  : out unsigned (14 downto 0);
    clk, rst : in std_logic
	);
end entity;

architecture a_pc_rom of pc_rom is

	signal pc_in, pc_out, proto_out : unsigned (15 downto 0);
	signal pc_en, estado : std_logic;

	component pc is
		port (
			clk 		: in std_logic;
			rst 		: in std_logic;
			pc_en 		: in std_logic;
			dado_in		: in unsigned(15 downto 0);
			dado_out	: out unsigned(15 downto 0)
		);
	end component;

	component proto_uc is
		port (
			dado_in : in unsigned (15 downto 0);
			dado_out	  : out unsigned (15 downto 0)
		);
	end component;

	component rom is
		port (
			clk		:in std_logic;
		  endereco	:in unsigned (15 downto 0);
		  dado		:out unsigned (14 downto 0)
		);
	end component;

	component maquina_est is
		port(
			clk, rst : in std_logic;
			est_o : out std_logic
		);
	end component;

	begin
		pc1: pc port map(clk => clk, rst => rst, pc_en => pc_en, dado_in => pc_in, dado_out => pc_out);
		proto: proto_uc port map(dado_in => pc_out, dado_out => proto_out);
		rom_1: rom port map (clk => clk, endereco => pc_out, dado => top_out);
		maq_est: maquina_est port map (clk => clk, rst => rst, est_o => estado);

		pc_en <= '1' when estado = '1' else
							'0';

end architecture;
