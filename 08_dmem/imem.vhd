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
		0 => x"00500093",  -- addi x1, x0, 5
		1 => x"00000013",  -- NOP
		2 => x"00102023",  -- sw x1, 0(x0)
		3 => x"00002103",  -- lw x2, 0(x0)
		others => x"00000000"
	);
begin
    instr <= mem(to_integer(unsigned(addr)) / 4)
        when to_integer(unsigned(addr)) / 4 < 16
        else x"00000000";
end architecture;