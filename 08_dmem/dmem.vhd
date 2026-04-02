-- dmem.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dmem is
	port (
		clk		: in std_logic;
		we		: in std_logic;
		addr	: in std_logic_vector(31 downto 0);
		wdata	: in std_logic_vector(31 downto 0);
		rdata	: out std_logic_vector(31 downto 0)
	);
end entity;

architecture rtl of dmem is
    type mem_array is array(0 to 255) of std_logic_vector(31 downto 0);
    signal mem      : mem_array := (others => (others => '0'));
    signal addr_int : integer := 0;  -- range制約を外す
begin
    process(addr)
    begin
        if is_x(addr) then
            addr_int <= 0;
        elsif to_integer(unsigned(addr)) / 4 < 256 then
            addr_int <= to_integer(unsigned(addr)) / 4;
        else
            addr_int <= 0;
        end if;
    end process;

    rdata <= mem(addr_int);

    process(clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                mem(addr_int) <= wdata;
            end if;
        end if;
    end process;
end architecture;