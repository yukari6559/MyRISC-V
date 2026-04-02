-- imem.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity imem is
	port (
		addr	: in std_logic_vector(31 downto 0);
		instr	: out std_logic_vector(31 downto 0)
	);
end entity;

architecture rtl of imem is
	type mem_array is array(0 to 15) of std_logic_vector(31 downto 0);
	constant mem : mem_array := (
		0 => x"00000013",  -- NOP
		1 => x"00500093",  -- addi x1, x0, 5
		2 => x"00500113",  -- addi x2, x0, 5
		3 => x"00208463",  -- beq x1, x2, 8  → pc+8でindex5へ
		4 => x"06300193",  -- addi x3, x0, 99（スキップされるはず）
		5 => x"02A00213",  -- addi x4, x0, 42（ここに飛んでくる）
		others => x"00000000"
	);
begin
    process(addr)
    begin
        if is_x(addr) then
            instr <= x"00000000";
        elsif to_integer(unsigned(addr)) / 4 < 16 then
            instr <= mem(to_integer(unsigned(addr)) / 4);
        else
            instr <= x"00000000";
        end if;
    end process;
end architecture;