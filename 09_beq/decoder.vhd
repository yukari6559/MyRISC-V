-- decoder.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is
	port (
		instr	: in std_logic_vector(31 downto 0);
		rs1		: out std_logic_vector(4 downto 0);
		rs2		: out std_logic_vector(4 downto 0);
		rd		: out std_logic_vector(4 downto 0);
		imm		: out std_logic_vector(31 downto 0);
		alu_op	: out std_logic_vector(3 downto 0);
		reg_we	: out std_logic;
		mem_we	: out std_logic
	);
end entity;

architecture rtl of decoder is
	signal opcode : std_logic_vector(6 downto 0);
begin
	rs1 <= instr(19 downto 15);
	rs2 <= instr(24 downto 20);
	rd  <= instr(11 downto  7);
	opcode <= instr(6 downto 0);
	process(instr)
	begin
		case instr(6 downto 0) is
			when "0110011" => -- R型（add）
				alu_op <= "0000";
				reg_we <= '1';
				mem_we <= '0';
				imm	<= (others => '0');
			when "0010011" => -- I型（addi）
				alu_op <= "0000";
				reg_we <= '1';
				mem_we <= '0';
				imm <= std_logic_vector(resize(signed(instr(31 downto 20)), 32));
			when "0000011" =>  -- lw
				alu_op <= "0000";
				reg_we <= '1';
				mem_we <= '0';
				imm    <= std_logic_vector(resize(signed(instr(31 downto 20)), 32));
			when "0100011" =>  -- sw
				alu_op <= "0000";
				reg_we <= '0';
				mem_we <= '1';
				imm    <= std_logic_vector(resize(signed(instr(31 downto 25) & instr(11 downto 7)), 32));
			when "1100011" => -- beq
				alu_op <= "0001";
				reg_we <= '0';
				mem_we <= '0';
				imm <= std_logic_vector(resize(signed(instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0'), 32));
			when others =>
				alu_op <= "0000";
				reg_we <= '0';
				mem_we <= '0';
				imm <= (others => '0');
		end case;
	end process;
end architecture;