transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/PrograP/aalfaro_jugalde_cnavarro_digital_design_lab_2025/Problema1 {D:/PrograP/aalfaro_jugalde_cnavarro_digital_design_lab_2025/Problema1/DecodificadorBinario.sv}
vlog -sv -work work +incdir+D:/PrograP/aalfaro_jugalde_cnavarro_digital_design_lab_2025/Problema1 {D:/PrograP/aalfaro_jugalde_cnavarro_digital_design_lab_2025/Problema1/Top.sv}
vlog -sv -work work +incdir+D:/PrograP/aalfaro_jugalde_cnavarro_digital_design_lab_2025/Problema1 {D:/PrograP/aalfaro_jugalde_cnavarro_digital_design_lab_2025/Problema1/DisplayController.sv}
vlog -sv -work work +incdir+D:/PrograP/aalfaro_jugalde_cnavarro_digital_design_lab_2025/Problema1 {D:/PrograP/aalfaro_jugalde_cnavarro_digital_design_lab_2025/Problema1/BCD_to_7Seg.sv}

vlog -sv -work work +incdir+D:/PrograP/aalfaro_jugalde_cnavarro_digital_design_lab_2025/Problema1 {D:/PrograP/aalfaro_jugalde_cnavarro_digital_design_lab_2025/Problema1/DecodificadorBinario_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  DecodificadorBinario_tb

add wave *
view structure
view signals
run -all
