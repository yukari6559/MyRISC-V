-- alu.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity alu is
	port (
		op		: in std_logic_vector(3 downto 0);
		src_a	: in std_logic_vector(31 downto 0);
		src_b	: in std_logic_vector(31 downto 0);
		result	: out std_logic_vector(31 downto 0);
		zero	: out std_logic
	);
end entity;

architecture rtl of alu is
	signal result_i : std_logic_vector(31 downto 0);
begin
	process(op, src_a, src_b)
	begin
		case op is
			when "0000" => result_i <= std_logic_vector(signed(src_a) + signed(src_b));											-- ADD
			when "0001" => result_i <= std_logic_vector(signed(src_a) - signed(src_b));											-- SUB
			when "0010" => result_i <= src_a and src_b;																			-- AND
			when "0011" => result_i <= src_a or src_b;																			-- OR
			when "0100" => result_i <= src_a xor src_b; 																			-- XOR
			when "0101" => result_i <= std_logic_vector(shift_left(unsigned(src_a), to_integer(unsigned(src_b(4 downto 0)))));	-- SLL
			-- src_b(4 downto 0) → シフト量は下位5bitだけ使う（RISC-Vの仕様）
			when "0110" => result_i <= std_logic_vector(shift_right(unsigned(src_a), to_integer(unsigned(src_b(4 downto 0)))));	-- SRL
			when "0111" => result_i <= std_logic_vector(shift_right(signed(src_a), to_integer(unsigned(src_b(4 downto 0)))));		-- SRA
			when others => result <= (others => '0');
		end case;
	end process;
	result <= result_i;
	zero <= '1' when result_i = x"00000000" else '0';
end architecture;