-- Arquitetura e Organização de Computadores
-- Arquivo: pc.vhd
-- Anderson Cottica
-- Erik Ryuichi Yamamoto
-- Data entrega: 19/10/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
	port (
		clk 		: in std_logic;
		rst 		: in std_logic;
		pc_en 		: in std_logic;
		pc_in		: inout unsigned(15 downto 0);
		pc_out		: out unsigned(15 downto 0)
	);
end entity;

architecture a_pc of pc is
	signal registro : unsigned(15 downto 0);
	signal proto_out : unsigned(15 downto 0);
	signal proto_const : unsigned(15 downto 0) := "0000000000000001";

	component proto_uc is
		port (
			dado_in, const_in : in unsigned (15 downto 0);
			dado_out	  : out unsigned (15 downto 0)
		);
	end component;

begin
	proto: proto_uc port map(dado_in => registro, const_in => proto_const, dado_out => proto_out);

	pc_in <= proto_out;
	pc_out <= registro;

	process (clk,rst,pc_en)
		begin
			if rst='1' then
				registro <= "0000000000000000";
				elsif pc_en = '1' then
					if rising_edge(clk) then
						registro <= pc_in;
					end if;
			end if;
	end process;
end architecture;
