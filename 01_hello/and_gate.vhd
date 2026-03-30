-- and_gate.vhd
library ieee;
use ieee.std_logic_1164.all;

entity and_gate is
    port (
        a : in  std_logic;
        b : in  std_logic;
        y : out std_logic
    );
end entity;

architecture rtl of and_gate is
begin
    y <= a and b;  -- "<=" は信号への代入
end architecture;