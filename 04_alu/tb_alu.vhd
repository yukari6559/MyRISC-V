-- tb_alu.vhd
library ieee;
use ieee.std_logic_1164.all;

entity tb_alu is
end entity;

architecture sim of tb_alu is
	signal op						: std_logic_vector(3 downto 0);
	signal src_a, src_b, result		: std_logic_vector(31 downto 0);
	signal zero						: std_logic;
begin
	uut: entity work.alu
		port map(
			op => op,
			src_a => src_a,
			src_b => src_b,
			result => result,
			zero => zero
		);
	process
	begin
		op <= "0000"; src_a <= x"00000005"; src_b <= x"00000003"; wait for 10 ns;  -- ADD
		op <= "0001"; src_a <= x"00000005"; src_b <= x"00000005"; wait for 10 ns;  -- SUB
		op <= "0010"; src_a <= x"FF00FF00"; src_b <= x"0F0F0F0F"; wait for 10 ns;  -- AND
		op <= "0110"; src_a <= x"80000000"; src_b <= x"00000001"; wait for 10 ns;  -- SRL
		op <= "0111"; src_a <= x"80000000"; src_b <= x"00000001"; wait for 10 ns;  -- SRA
		wait for 10 ns;
		wait;
	end process;
end architecture;