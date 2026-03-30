-- tb_dff.vhd
library ieee;
use ieee.std_logic_1164.all;

entity tb_dff is

end entity;

architecture sim of tb_dff is
	signal clk, d, q : std_logic;
begin
	uut: entity work.dff
		port map (
			clk => clk,
			d => d,
			q => q
		);
	process
	begin
		clk <= '0'; wait for 5 ns;
    	clk <= '1'; wait for 5 ns;
	end process;
	process
	begin
		d <= '0'; wait for 3 ns;
		d <= '1'; wait for 3 ns;
		d <= '0'; wait for 3 ns;
	end process;
end architecture;