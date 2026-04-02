-- reg.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity reg is
	port(
		clk		: in std_logic;
		rs1		: in std_logic_vector(4 downto 0);
		rs2		: in std_logic_vector(4 downto 0);
		rd		: in std_logic_vector(4 downto 0);
		we		: in std_logic;
		wdata	: in std_logic_vector(31 downto 0);
		rdata1	: out std_logic_vector(31 downto 0);
		rdata2	: out std_logic_vector(31 downto 0)
	);
end entity;

architecture rtl of reg is
    -- 1. レジスタ配列の宣言
	type reg_array is array(0 to 31) of std_logic_vector(31 downto 0);
	signal regs : reg_array := (others => (others => '0'));

begin
	-- 2. 書き込み処理（process + rising_edge）
	process(clk)
	begin
		if rising_edge(clk) then
			if we = '1' then
				regs(to_integer(unsigned(rd))) <= wdata;
			end if;
		end if;
	end process;
	-- 3. 読み出し処理（並行処理文でOK）
	rdata1 <= (others => '0') when rs1 = "00000" 
		else regs(to_integer(unsigned(rs1)));
	rdata2 <= (others => '0') when rs2 = "00000"
		else regs(to_integer(unsigned(rs2)));
end architecture;