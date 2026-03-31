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
        0 => x"003100B3",  -- add x1, x2, x3
        1 => x"00510093",  -- addi x1, x2, 5
        others => x"00000000"
    );
begin
    instr <= mem(to_integer(unsigned(addr)) / 4)
        when to_integer(unsigned(addr)) / 4 < 16
        else x"00000000";
end architecture;