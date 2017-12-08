ghdl -a banco_reg_16bits.vhd

PAUSE


ghdl -a maq_estados.vhd

PAUSE


ghdl -a mux_16bits.vhd

PAUSE


ghdl -a pc.vhd

PAUSE

ghdl -a rom.vhd
PAUSE
ghdl -a uc.vhd

PAUSE


ghdl -a ula_16bits.vhd
PAUSE
ghdl -a processador.vhd

PAUSE

ghdl -a processador_tb.vhd
PAUSE



ghdl -e banco_reg_16bits

ghdl -e maq_estados

ghdl -e mux_16bits

ghdl -e pc
ghdl -e rom

ghdl -e uc
ghdl -e ula_16bits

ghdl -e processador

ghdl -e processador_tb




ghdl -r processador_tb --stop-time=5000ns --wave=processador.ghw


PAUSE


gtkwave -asinais.gtkw processador.ghw
