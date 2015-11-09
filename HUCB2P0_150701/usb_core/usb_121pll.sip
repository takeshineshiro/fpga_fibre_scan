set_global_assignment -entity "usb_121pll" -library "lib_usb_121pll" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "usb_121pll" -library "lib_usb_121pll" -name IP_TOOL_VERSION "14.0"
set_global_assignment -entity "usb_121pll" -library "lib_usb_121pll" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_usb_121pll" -name SPD_FILE [file join $::quartus(sip_path) "usb_121pll.spd"]

set_global_assignment -library "lib_usb_121pll" -name MISC_FILE [file join $::quartus(sip_path) "usb_121pll_sim/usb_121pll.vho"]
