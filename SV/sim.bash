	#!/bin/bash
	
	RTL_DIR=..
	UVM_DEF="+define+UVM_TRIAL"
    UVM_TB="$RTL_DIR/dsi_host_uvm.svh";

	vcs -sverilog -full64 -debug_all -R -gui \
	-cm line+cond+fsm+tgl+branch \
	+define+SEED=$1 \
	-timescale=1ns/1ps \
	../count_ones.sv \
	../cnt_one_tb.sv \
	-top cnt_one_tb &
	# +define+TESTCASE=$1
	#$UVM_DEF \
	#$UVM_TB \
