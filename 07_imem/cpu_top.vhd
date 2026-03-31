-- cpu_top.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpu_top is
	port (
		clk		: in std_logic;
		rst		: in std_logic;
		pc		: out std_logic_vector(31 downto 0)
	);
end entity;

architecture rtl of cpu_top is

    -- 内部信号（各モジュールをつなぐ配線）
    signal rs1_addr, rs2_addr, rd_addr	: std_logic_vector(4 downto 0);
    signal alu_op						: std_logic_vector(3 downto 0);
    signal imm, alu_src_a, alu_src_b	: std_logic_vector(31 downto 0);
    signal alu_result					: std_logic_vector(31 downto 0);
    signal rdata1, rdata2				: std_logic_vector(31 downto 0);
    signal reg_we, mem_we, zero			: std_logic;
	signal pc_reg						: std_logic_vector(31 downto 0) := (others => '0');
	signal instr						: std_logic_vector(31 downto 0);

begin
	u_reg: entity work.reg
    port map(
        clk    => clk,
        rs1    => rs1_addr,
        rs2    => rs2_addr,
        rd     => rd_addr,
        we     => reg_we,
        wdata  => alu_result,  -- ALUの結果をレジスタに書き込む
        rdata1 => rdata1,
        rdata2 => rdata2
    );
	u_alu: entity work.alu
	port map(
		op => alu_op,
		src_a => alu_src_a,
		src_b => alu_src_b,
		result => alu_result,
		zero => zero
	);
	u_decoder: entity work.decoder
	port map(
		instr => instr,
		rs1 => rs1_addr,
		rs2 => rs2_addr,
		rd => rd_addr,
		imm => imm,
		alu_op => alu_op,
		reg_we => reg_we,
		mem_we => mem_we
	);
	u_imem: entity work.imem
		port map(
			addr => pc_reg,
			instr => instr
		);
	alu_src_a <= rdata1;
	alu_src_b <= rdata2 when instr(6 downto 0) = "0110011"
		else imm;
	process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				pc_reg <= (others => '0');  -- リセット
			else
				pc_reg <= std_logic_vector(unsigned(pc_reg) + 4);  -- 次のPC
			end if;
		end if;
	end process;

	pc <= pc_reg;  -- 出力に接続
end architecture;