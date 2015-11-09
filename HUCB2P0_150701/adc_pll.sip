set_global_assignment -entity "adc_pll" -library "lib_adc_pll" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "adc_pll" -library "lib_adc_pll" -name IP_TOOL_VERSION "14.0"
set_global_assignment -entity "adc_pll" -library "lib_adc_pll" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_adc_pll" -name SPD_FILE [file join $::quartus(sip_path) "adc_pll.spd"]

set_global_assignment -library "lib_adc_pll" -name MISC_FILE [file join $::quartus(sip_path) "adc_pll_sim/adc_pll.vho"]
