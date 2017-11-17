ghdl -a pc.vhd
PAUSE
ghdl -a rom.vhd
PAUSE
ghdl -a maquina_est.vhd
PAUSE
ghdl -a uc.vhd
PAUSE
ghdl -a pc_rom.vhd
PAUSE
ghdl -a pc_rom_tb.vhd

ghdl -e pc
ghdl -e rom
ghdl -e maquina_est
ghdl -e uc
ghdl -e pc_rom
ghdl -e pc_rom_tb

ghdl -r pc_rom_tb --stop-time=3000ns --wave=pc_rom.ghw

gtkwave pc_rom.ghw
