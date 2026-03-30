-- tb_or_gate.vhd
library ieee;
use ieee.std_logic_1164.all;

entity tb_and_gate is
    -- テストベンチはポートなし
end entity;

architecture sim of tb_and_gate is

    -- テスト対象の部品を接続するための信号を用意
    signal a, b, y : std_logic;

begin
    -- テスト対象を「インスタンス化」する
    uut: entity work.and_gate
        port map (
            a => a,
            b => b,
            y => y
        );

    -- 入力を時系列で与える
    process
    begin
        a <= '0'; b <= '0'; wait for 10 ns;  -- 00 → y=0
        a <= '0'; b <= '1'; wait for 10 ns;  -- 01 → y=0
        a <= '1'; b <= '0'; wait for 10 ns;  -- 10 → y=0
        a <= '1'; b <= '1'; wait for 10 ns;  -- 11 → y=1
		wait for 10 ns;
        wait;  -- シミュレーション終了
    end process;

end architecture;