library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity maquina is
	port( 	clk,rst: in std_logic;
			estado: out unsigned(1 downto 0);
			estado_0, estado_1, estado_2: out std_logic
		);
end entity;

architecture a_maquina of maquina is

signal estado_m: unsigned(1 downto 0);
signal estado_0_m , estado_1_m, estado_2_m : std_logic;

begin
	process(clk,rst)
	begin
		if rst='1' then
			estado_m <= "00";
		elsif rising_edge(clk) then
			if estado_m="10" then -- se agora esta em 2
			estado_m <= "00"; -- o prox vai voltar ao zero
			else
			estado_m <= estado_m+"01"; -- senao avanca
			end if;
		end if;
	end process;
	estado_0_m <= '1' when estado_m = "00" else '0';
	estado_0<= '1' when rising_edge(estado_0_m) else '0';
	estado_1_m <= '1' when estado_m = "01" else '0';
	estado_1<= estado_1_m;
	estado_2_m <= '1' when estado_m = "10" else '0';
	estado_2<= estado_2_m;
	estado <= estado_m;

end architecture;