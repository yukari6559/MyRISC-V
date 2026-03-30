-- tb_reg.vhd
library ieee;
use ieee.std_logic_1164.all;

entity tb_reg is
end entity;

architecture sim of tb_reg is
	signal clk, we 					: std_logic;
	signal rs1, rs2, rd				: std_logic_vector(4 downto 0);
	signal wdata, rdata1, rdata2	: std_logic_vector(31 downto 0);
begin
	uut: entity work.reg 
		port map(
			clk   	=> clk,
			we		=> we,
			wdata	=> wdata,
			rdata1	=> rdata1,
			rdata2	=> rdata2,
			rs1		=> rs1,
			rs2		=> rs2,
			rd		=> rd
		);
	process
	begin
		clk <= '0'; wait for 5 ns;
    	clk <= '1'; wait for 5 ns;
	end process;
	-- テスト用プロセス
	process
	begin
		-- 1. レジスタ1に'1'を書き込む
		rd    <= "00001";
		wdata <= x"00000001";
		we    <= '1';
		wait for 10 ns;

		-- 2. 書き込み終わり
		we <= '0';

		-- 3. レジスタ1を読み出す
		rs1 <= "00001";
		wait for 10 ns;
		-- 1. x1に x"DEADBEEF" を書き込む
		rd <= "00001"; wdata <= x"DEADBEEF"; we <= '1';
		wait for 10 ns;

		-- 2. x2に x"12345678" を書き込む
		rd <= "00010"; wdata <= x"12345678"; we <= '1';
		wait for 10 ns;

		-- 3. x1とx2を同時に読み出す
		we  <= '0';
		rs1 <= "00001";
		rs2 <= "00010";
		wait for 10 ns;

		-- 4. x0に書き込もうとしても0のまま
		rd    <= "00000";
		wdata <= x"FFFFFFFF";
		we    <= '1';
		wait for 10 ns;

		we  <= '0';
		rs1 <= "00000";  -- x0を読み出す
		wait for 10 ns;

		wait;

	end process;
	

end architecture;