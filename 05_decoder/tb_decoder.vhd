-- tb_decoder.vhd
library ieee;
use ieee.std_logic_1164.all;

entity tb_decoder is
end entity;

architecture sim of tb_decoder is
    -- 1. 信号宣言（decoderのポートと同じ型で用意する）
    signal instr  : std_logic_vector(31 downto 0);
    signal rs1, rs2, rd : std_logic_vector(4 downto 0);
    signal imm    : std_logic_vector(31 downto 0);
    signal alu_op : std_logic_vector(3 downto 0);
    signal reg_we, mem_we : std_logic;
begin
    -- 2. インスタンス化
    uut: entity work.decoder
        port map(
			instr => instr,
			rs1 => rs1,
			rs2 => rs2,
			rd => rd,
			imm => imm,
			alu_op => alu_op,
			reg_we => reg_we,
			mem_we => mem_we
		);

    -- 3. テスト用プロセス
    process
    begin
        instr <= x"003100B3"; wait for 10 ns;  -- add x1, x2, x3
        instr <= x"00510093"; wait for 10 ns;  -- addi x1, x2, 5
        wait;
    end process;
end architecture;