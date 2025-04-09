transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib activehdl/xbip_utils_v3_0_13
vlib activehdl/xbip_pipe_v3_0_9
vlib activehdl/xbip_bram18k_v3_0_9
vlib activehdl/mult_gen_v12_0_21
vlib activehdl/xil_defaultlib

vmap xbip_utils_v3_0_13 activehdl/xbip_utils_v3_0_13
vmap xbip_pipe_v3_0_9 activehdl/xbip_pipe_v3_0_9
vmap xbip_bram18k_v3_0_9 activehdl/xbip_bram18k_v3_0_9
vmap mult_gen_v12_0_21 activehdl/mult_gen_v12_0_21
vmap xil_defaultlib activehdl/xil_defaultlib

vcom -work xbip_utils_v3_0_13 -93  \
"../../../../testPIP23_11.gen/sources_1/bd/importBD/ipshared/24e7/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work xbip_pipe_v3_0_9 -93  \
"../../../../testPIP23_11.gen/sources_1/bd/importBD/ipshared/713b/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \

vcom -work xbip_bram18k_v3_0_9 -93  \
"../../../../testPIP23_11.gen/sources_1/bd/importBD/ipshared/cd0f/hdl/xbip_bram18k_v3_0_vh_rfs.vhd" \

vcom -work mult_gen_v12_0_21 -93  \
"../../../../testPIP23_11.gen/sources_1/bd/importBD/ipshared/f2b8/hdl/mult_gen_v12_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../../testPIP23_11.gen/sources_1/bd/importBD/ip/multiply_mult_gen_0_0/sim/multiply_mult_gen_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 -l xbip_utils_v3_0_13 -l xbip_pipe_v3_0_9 -l xbip_bram18k_v3_0_9 -l mult_gen_v12_0_21 -l xil_defaultlib \
"../../../../testPIP23_11.gen/sources_1/bd/importBD/sim/multiply.v" \


vlog -work xil_defaultlib \
"glbl.v"

