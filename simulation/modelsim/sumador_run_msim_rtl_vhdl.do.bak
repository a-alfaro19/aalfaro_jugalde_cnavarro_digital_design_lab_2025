transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {D:/sumador/sumador.vhd}
vcom -93 -work work {D:/sumador/sumador_top.vhd}
vcom -93 -work work {D:/sumador/sumador_4_bits.vhd}

vcom -93 -work work {D:/sumador/sumador_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  sumador_tb

add wave *
view structure
view signals
run -all
