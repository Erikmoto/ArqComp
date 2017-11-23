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
PAUSE





ghdl -e pc

PAUSE
ghdl -e rom

PAUSE
ghdl -e maquina_est

PAUSE

ghdl -e uc

PAUSE

ghdl -e pc_rom

PAUSE

ghdl -e pc_rom_tb
PAUSE





ghdl -r pc_rom_tb --stop-time=3000ns --wave=pc_rom.ghw


PAUSE


gtkwave pc_rom.ghw
