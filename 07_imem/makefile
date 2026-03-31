# 設定
TB_FILE := $(wildcard tb_*.vhd)
TOP := $(basename $(TB_FILE))
# ディレクトリ内の全.vhdファイルを自動取得
FILES := reg.vhd alu.vhd decoder.vhd cpu_top.vhd tb_cpu_top.vhd
STOP_TIME = 200ns

# コマンド
.PHONY: all sim wave clean

all: sim clean-ocf

sim:
	ghdl -a $(FILES)
	ghdl -e $(TOP)
	ghdl -r $(TOP) --vcd=wave.vcd --stop-time=$(STOP_TIME)
	@echo "✅ シミュレーション完了"

wave: sim
	gtkwave wave.vcd

clean:
	rm -f wave.vcd *.o *.cf $(TOP)

clean-ocf:
	rm -f *.o *.cf $(TOP)