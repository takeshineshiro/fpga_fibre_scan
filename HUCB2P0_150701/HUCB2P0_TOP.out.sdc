## Generated SDC file "HUCB2P0_TOP.out.sdc"

## Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, the Altera Quartus II License Agreement,
## the Altera MegaCore Function License Agreement, or other 
## applicable license agreement, including, without limitation, 
## that your use is for the sole purpose of programming logic 
## devices manufactured by Altera and sold by Altera or its 
## authorized distributors.  Please refer to the applicable 
## agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 14.0.0 Build 200 06/17/2014 SJ Full Version"

## DATE    "Thu Apr 30 16:27:18 2015"

##
## DEVICE  "5CGXFC7D7F31C8ES"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 33.333 -waveform { 0.000 16.666 } [get_ports {altera_reserved_tck}]
create_clock -name {I_ref_clk} -period 50.000 -waveform { 0.000 25.000 } [get_ports {I_ref_clk}]
create_clock -name {I_adce_clk} -period 6.250 -waveform { 0.000 3.125 } [get_ports {I_adce_clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} -source [get_pins {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 36 -divide_by 2 -master_clock {I_ref_clk} [get_pins {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]}] 
create_generated_clock -name {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk} -source [get_pins {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]}] -duty_cycle 50.000 -multiply_by 1 -divide_by 4 -master_clock {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} [get_pins {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] 
create_generated_clock -name {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} -source [get_pins {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 9 -divide_by 4 -master_clock {I_adce_clk} [get_pins {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]}] 
create_generated_clock -name {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk} -source [get_pins {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]}] -duty_cycle 50.000 -multiply_by 1 -divide_by 9 -phase 49.997 -master_clock {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} [get_pins {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {I_adce_clk}] -rise_to [get_clocks {I_adce_clk}] -setup 0.100  
set_clock_uncertainty -rise_from [get_clocks {I_adce_clk}] -rise_to [get_clocks {I_adce_clk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {I_adce_clk}] -fall_to [get_clocks {I_adce_clk}] -setup 0.100  
set_clock_uncertainty -rise_from [get_clocks {I_adce_clk}] -fall_to [get_clocks {I_adce_clk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {I_adce_clk}] -rise_to [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.110  
set_clock_uncertainty -rise_from [get_clocks {I_adce_clk}] -fall_to [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.110  
set_clock_uncertainty -fall_from [get_clocks {I_adce_clk}] -rise_to [get_clocks {I_adce_clk}] -setup 0.100  
set_clock_uncertainty -fall_from [get_clocks {I_adce_clk}] -rise_to [get_clocks {I_adce_clk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {I_adce_clk}] -fall_to [get_clocks {I_adce_clk}] -setup 0.100  
set_clock_uncertainty -fall_from [get_clocks {I_adce_clk}] -fall_to [get_clocks {I_adce_clk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {I_adce_clk}] -rise_to [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.110  
set_clock_uncertainty -fall_from [get_clocks {I_adce_clk}] -fall_to [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.110  
set_clock_uncertainty -rise_from [get_clocks {I_ref_clk}] -rise_to [get_clocks {I_ref_clk}] -setup 0.100  
set_clock_uncertainty -rise_from [get_clocks {I_ref_clk}] -rise_to [get_clocks {I_ref_clk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {I_ref_clk}] -fall_to [get_clocks {I_ref_clk}] -setup 0.100  
set_clock_uncertainty -rise_from [get_clocks {I_ref_clk}] -fall_to [get_clocks {I_ref_clk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {I_ref_clk}] -rise_to [get_clocks {I_ref_clk}] -setup 0.100  
set_clock_uncertainty -fall_from [get_clocks {I_ref_clk}] -rise_to [get_clocks {I_ref_clk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {I_ref_clk}] -fall_to [get_clocks {I_ref_clk}] -setup 0.100  
set_clock_uncertainty -fall_from [get_clocks {I_ref_clk}] -fall_to [get_clocks {I_ref_clk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.120  
set_clock_uncertainty -rise_from [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.120  
set_clock_uncertainty -rise_from [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.140  
set_clock_uncertainty -rise_from [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.140  
set_clock_uncertainty -fall_from [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.120  
set_clock_uncertainty -fall_from [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.120  
set_clock_uncertainty -fall_from [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.140  
set_clock_uncertainty -fall_from [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.140  
set_clock_uncertainty -rise_from [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {I_ref_clk}]  0.110  
set_clock_uncertainty -rise_from [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {I_ref_clk}]  0.110  
set_clock_uncertainty -rise_from [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.140  
set_clock_uncertainty -rise_from [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.140  
set_clock_uncertainty -rise_from [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.070  
set_clock_uncertainty -rise_from [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.070  
set_clock_uncertainty -rise_from [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {I_ref_clk}]  0.110  
set_clock_uncertainty -fall_from [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {I_ref_clk}]  0.110  
set_clock_uncertainty -fall_from [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.140  
set_clock_uncertainty -fall_from [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {U4_usb_pll|usb_121pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.140  
set_clock_uncertainty -fall_from [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.070  
set_clock_uncertainty -fall_from [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.070  
set_clock_uncertainty -fall_from [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {U5_adc_pll|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -setup 0.280  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -hold 0.270  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -setup 0.280  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -setup 0.280  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -setup 0.280  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -hold 0.270  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_qe9:dffpipe16|dffe17a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_pe9:dffpipe13|dffe14a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_5f9:dffpipe19|dffe20a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_3f9:dffpipe15|dffe16a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_0v8:dffpipe14|dffe15a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_vu8:dffpipe11|dffe12a*}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

