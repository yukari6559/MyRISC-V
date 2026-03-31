-- tb_cpu_top.vhd
library ieee;
use ieee.std_logic_1164.all;

entity tb_cpu_top is
end entity;

architecture sim of tb_cpu_top is
	signal clk		: std_logic;
	signal rst		: std_logic;
	signal instr	: std_logic_vector(31 downto 0);
	signal pc		: std_logic_vector(31 downto 0);
begin
	uut: entity work.cpu_top 
		port map(
			clk => clk,
			rst => rst,
			pc => pc
		);
	process
	begin
		rst <= '1'; wait for 5 ns;
		rst <= '0'; wait for 5 ns;
		wait;
	end process;
	process
	begin
		clk <= '0'; wait for 5 ns;
		clk <= '1'; wait for 5 ns;
	end process;
end architecture;