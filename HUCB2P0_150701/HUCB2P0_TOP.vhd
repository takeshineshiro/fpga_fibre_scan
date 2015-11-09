--*****************************************************************************
--  @Copyright 2013 by SIAT_HFUS_TEAM, All rights reserved.                    
--  Module name : HUCB2P0_TOP
--  Call by     : 
--  Description : this module is the top module of HUCB2P0.
--  IC          : 5CGXFC7D7F31C8N
--  Version     : A                                                    
--  Note:       : 
--  Author      : Peitian Mu 
--  Date        : 2013.09.12                                                  
--  Update      : 
--*****************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
library work;

entity HUCB2P0_TOP is
port
(       
    I_reset             : in    std_logic; -- 复位，低有效--
    I_ref_clk           : in    std_logic; -- 20M时钟
                        
    DDR3_A0             : out   std_logic; -- not used
    DDR3_A1             : out   std_logic; -- not used
    DDR3_A2             : out   std_logic; -- not used
    DDR3_A3             : out   std_logic; -- not used
    DDR3_A4             : out   std_logic; -- not used
    DDR3_A5             : out   std_logic; -- not used
    DDR3_A6             : out   std_logic; -- not used
    DDR3_A7             : out   std_logic; -- not used
    DDR3_A8             : out   std_logic; -- not used
    DDR3_A9             : out   std_logic; -- not used
    DDR3_A10            : out   std_logic; -- not used
    DDR3_A11            : out   std_logic; -- not used
    DDR3_A12            : out   std_logic; -- not used
    DDR3_A13            : out   std_logic; -- not used
                        
    DDR3_D0             : inout std_logic; -- not used
    DDR3_D1             : inout std_logic; -- not used
    DDR3_D2             : inout std_logic; -- not used
    DDR3_D3             : inout std_logic; -- not used
    DDR3_D4             : inout std_logic; -- not used
    DDR3_D5             : inout std_logic; -- not used
    DDR3_D6             : inout std_logic; -- not used
    DDR3_D7             : inout std_logic; -- not used
    DDR3_D8             : inout std_logic; -- not used
    DDR3_D9             : inout std_logic; -- not used
    DDR3_D10            : inout std_logic; -- not used
    DDR3_D11            : inout std_logic; -- not used
    DDR3_D12            : inout std_logic; -- not used
    DDR3_D13            : inout std_logic; -- not used
    DDR3_D14            : inout std_logic; -- not used
    DDR3_D15            : inout std_logic; -- not used
                        
    DDR3_BA0            : out   std_logic; -- not used
    DDR3_BA1            : out   std_logic; -- not used
    DDR3_BA2            : out   std_logic; -- not used
                        
    DDR3_CAS            : out   std_logic_vector(0 downto 0);  -- not used
    DDR3_RAS            : out   std_logic_vector(0 downto 0);  -- not used
    DDR3_WE             : out   std_logic_vector(0 downto 0);  -- not used
    DDR3_CLK            : out   std_logic_vector(0 downto 0);  -- not used
    DDR3_CLK_n          : out   std_logic_vector(0 downto 0);  -- not used
    DDR3_DQS0           : inout std_logic; --not used 
    DDR3_DQS0_n         : inout std_logic; --not used 
    DDR3_DQS1           : inout std_logic; --not used 
    DDR3_DQS1_n         : inout std_logic; --not used 
    DDR3_ODT            : out   std_logic_vector(0 downto 0); --not used 
    DDR3_DML            : out   std_logic; --not used 
    DDR3_CKE            : out   std_logic_vector(0 downto 0); --not used 
    DDR3_DMU            : out   std_logic; --not used 
    DDR3_CS             : out   std_logic_vector(0 downto 0); --not used 
    DDR3_RST            : out   std_logic; --not used 
                        
    --ADC ADS58C48
    O_adca_sen          : out   std_logic; -- 此ADC未使用
    I_adca_sd           : in    std_logic;
    O_adca_sdata        : out   std_logic;
    O_adca_sclk         : out   std_logic;
    O_adca_rst          : out   std_logic;
    O_adca_pdn          : out   std_logic;
    O_adca_snrb0        : out   std_logic;
    O_adca_snrb1        : out   std_logic;   
                        
    I_adca_oclk         : in    std_logic;
                        
    I_adca_d            : in    std_logic_vector(5 downto 0);
    I_adcb_d            : in    std_logic_vector(5 downto 0);
    I_adcc_d            : in    std_logic_vector(5 downto 0);
    I_adcd_d            : in    std_logic_vector(5 downto 0);
                        
    --ADC AD9634        
    I_adce_clk          : in    std_logic; -- 此ADC未使用
    I_adce_d            : in    std_logic_vector(5 downto 0);
    I_adce_or           : in    std_logic;
    O_adce_csb          : out   std_logic;
    O_adce_sdio         : out   std_logic;
    O_adce_sclk         : out   std_logic;
                        
    --ADC AD9230        
    I_adcf_clk          : in    std_logic; -- 此ADC用于本项目数据采集 --240M
    I_adcf_d            : in    std_logic_vector(11 downto 0);   
    I_adcf_or           : in    std_logic;                      
    O_adcf_pwdn         : out   std_logic; 
    O_adcf_csb          : out   std_logic;
    O_adcf_sclk         : out   std_logic;
    O_adcf_sdio         : out   std_logic;         
    O_adcf_reset        : out   std_logic;
                        
    --ADC AD9235        
    I_m_adc_d           : in    std_logic_vector(11 downto 0); -- 此ADC未使用
    O_m_adc_clk         : out   std_logic;
    I_m_adc_otr         : in    std_logic;
    O_m_adc_pdwn        : out   std_logic;                        
                        
    O_pulse             : out   std_logic_vector(3 downto 0); -- 未使用
    O_pulse_0pd         : out   std_logic; -- 未使用
    O_pulse_1pd         : out   std_logic; -- 未使用
    O_pulse_2pd         : out   std_logic; -- 未使用
    O_pulse_3pd         : out   std_logic; -- 未使用
    O_8220pulse         : out   std_logic_vector(3 downto 0); -- 发射通道
    O_8020islpulse      : out   std_logic_vector(3 downto 0); -- 未使用
    O_8020mdpulse       : out   std_logic_vector(7 downto 0); -- 未使用
    
    ----------pll configuration
    O_pll_rst           : out   std_logic; -- 此PLL用于ADC时钟配置，使用方法可参考AD9518的datasheet。
    O_pll_sync          : out   std_logic;
    O_pll_sdio          : out   std_logic;
    O_pll_pd            : out   std_logic;
    O_pll_cs            : out   std_logic;
    O_pll_sclk          : out   std_logic;                   
    I_pll_refmon        : in    std_logic;      --not used
    I_pll_ld            : in    std_logic;      --not used
    I_pll_status        : in    std_logic;      --not used
    I_pll_sdo           : in    std_logic;      --not used 
                        
    I_iotrig            : in    std_logic; -- X10 I/O    -- not  used 
    I_ioenable          : in    std_logic; -- X2 I/O     -- not  used 
                        
    BEEP                : in    std_logic; -- 蜂鸣器未使用  -- not used 
	 
    DA_SYNC             : out   std_logic; -- AD5300，是ADI公司的DAC，用于输出sine给功放驱动电磁铁。
    DA_SCLK             : out   std_logic; -- AD5300
    DA_DIN              : out   std_logic; -- AD5300
                        
    FPGA_IO0            : in    std_logic; -- 未使用     --not used
    FPGA_IO1            : in    std_logic; -- 未使用     --not used 
                        
    SRAM_WE             : in    std_logic; -- 未使用     --not used 
    SRAM_OE             : in    std_logic; --not used 
    SRAM_CLK            : in    std_logic; --not used                                 
    SRAM_ADV            : in    std_logic; --not used 
    SRAM_CRE            : in    std_logic; --not used 
    SRAM_LB             : in    std_logic; --not used 
    SRAM_UB             : in    std_logic; --not used 
                        
    O_swi_dir           : out   std_logic; -- 电压转换芯片74LVC4245APW
    O_swi_oe            : out   std_logic; -- 电压转换芯片74LVC4245APW
	 
	 
    I_swi0              : in    std_logic; --not used 
    I_swi1              : in    std_logic; --not used 
    I_swi2              : in    std_logic; --not used 
    I_swi3              : in    std_logic; --not used 
    I_swi4              : in    std_logic; --not used 
    PCIE_SMCLK          : in    std_logic; --not used 
    PCIE_SMDAT          : in    std_logic; --not used 
    PCIE_WAKE           : in    std_logic; --not used 
    PCIE_PERST          : in    std_logic; --not used 
    DAC_SLEEP           : in    std_logic; --not used 
    DAC_GD0             : in    std_logic; --not used 
    DAC_GD1             : in    std_logic; --not used 
    DAC_GD2             : in    std_logic; --not used 
    DAC_GD3             : in    std_logic; --not used 
    DAC_GD4             : in    std_logic; --not used 
    DAC_GD5             : in    std_logic; --not used 
    DAC_GD6             : in    std_logic; --not used 
    DAC_GD7             : in    std_logic; --not used 
    
    SRAM_D0             : in    std_logic; --not used 
    SRAM_D1             : in    std_logic; --not used 
    SRAM_D2             : in    std_logic; --not used 
    SRAM_D3             : in    std_logic; --not used 
    SRAM_D4             : in    std_logic; --not used 
    SRAM_D5             : in    std_logic; --not used 
    SRAM_D6             : in    std_logic; --not used 
    SRAM_D7             : in    std_logic; --not used 
    SRAM_D8             : in    std_logic; --not used 
    SRAM_D9             : in    std_logic; --not used 
    SRAM_D10            : in    std_logic; --not used 
    SRAM_D11            : in    std_logic; --not used 
    SRAM_D12            : in    std_logic; --not used 
    SRAM_D13            : in    std_logic; --not used 
    SRAM_D14            : in    std_logic; --not used 
    SRAM_D15            : in    std_logic; --not used 
                        
    SRAM_A0             : in    std_logic; --not used 
    SRAM_A1             : in    std_logic; --not used 
    SRAM_A2             : in    std_logic; --not used 
    SRAM_A3             : in    std_logic; --not used 
    SRAM_A4             : in    std_logic; --not used 
    SRAM_A5             : in    std_logic; --not used 
    SRAM_A6             : in    std_logic; --not used 
    SRAM_A7             : in    std_logic; --not used 
    SRAM_A8             : in    std_logic; --not used 
    SRAM_A9             : in    std_logic; --not used 
    SRAM_A10            : in    std_logic; --not used 
    SRAM_A11            : in    std_logic; --not used 
    SRAM_A12            : in    std_logic; --not used 
    SRAM_A13            : in    std_logic; --not used 
    SRAM_A14            : in    std_logic; --not used 
    SRAM_A15            : in    std_logic; --not used  
    SRAM_A16            : in    std_logic; --not used 
    SRAM_A17            : in    std_logic; --not used 
    SRAM_A18            : in    std_logic; --not used 
    SRAM_A19            : in    std_logic; --not used 
    SRAM_A20            : in    std_logic; --not used 
    SRAM_A21            : in    std_logic; --not used 
                        
    SRAM_WAIT           : in    std_logic; --not used 
    SRAM_CE             : in    std_logic; --not used 
                        
    ----------USB                 
    O_usb_pclk          : out   std_logic;                             --CTL[0] SLCS#    
                                                                       --CTL[1] SLWR#    
    I_usb_flga          : in    std_logic := '0';                      --CTL[2] SLOE#    
    I_usb_flgb          : in    std_logic := '0';                      --CTL[3] SLRD#    
                                                                       --CTL[4] FLAGA    
    O_usb_cs            : out   std_logic;                             --CTL[5] FLAGB    
    O_usb_wr            : out   std_logic;                             --CTL[7] PKTEND#  
    O_usb_rd            : out   std_logic;                             --CTL[11] A1      
    O_usb_oe            : out   std_logic;                             --CTL[12] A0      
    O_usb_a0            : out   std_logic;
    O_usb_a1            : out   std_logic;
    O_usb_pkt           : out   std_logic;    
    O_usb_int           : out   std_logic;
    O_usb_reset         : out   std_logic; 
    IO_usb_dq           : inout std_logic_vector(31 downto 0);
                        
    O_usb_uart_rxd      : out   std_logic;
    I_usb_uart_rts      : in    std_logic; --not used 
    I_usb_uart_txd      : in    std_logic;
    O_usb_uart_cts      : out   std_logic; --not used 
    ----------USB unused
    USB_CTL6            : in    std_logic; --not used 
    USB_CTL8            : in    std_logic; --not used 
    USB_CTL9            : in    std_logic; --not used 
    USB_CTL10           : in    std_logic; --not used 
    O_usb_clk           : out   std_logic;  
    O_usb_i2s           : out   std_logic_vector(3 downto 0);   --not used 
    O_usb_gpio          : out   std_logic_vector(5 downto 0);   --not used 
     
--    PCIE_RX_0           : in    std_logic;
--    PCIE_RX_1           : in    std_logic;
--    PCIE_RX_2           : in    std_logic;
--    PCIE_RX_3           : in    std_logic;
--    PCIE_TX_0           : out   std_logic;
--    PCIE_TX_1           : out   std_logic;
--    PCIE_TX_2           : out   std_logic;
--    PCIE_TX_3           : out   std_logic;
--    PCIE_RCLK           : in    std_logic;

    USB_CLKIN           : in    std_logic;                     --not used 
--    FPGA_CLK            : in    std_logic;--LVDS
                             
    DAC_GCLK            : in    std_logic; -- 未使用            --not used 
	 
    KEYIN0              : in    std_logic;   -- button 
                        
    O_led               : out   std_logic_vector(3 downto 0) -- LED
    );
	 
	 
end HUCB2P0_TOP;





architecture arc_HUCB2P0_TOP of HUCB2P0_TOP is



component pll_conf -- PLL AD9518 
port
(
     I_clk              : in    std_logic;
     I_reset_n          : in    std_logic; 
                        
     O_ADC_ready        : out   std_logic;                                
     O_FPGA_ADC_d       : out   std_logic; 
     O_FPGA_ADC_clk     : out   std_logic;  
     O_FPGA_ADC_en      : out   std_logic;
     O_FPGA_ADC_reset   : out   std_logic 
);
end component;

component  LED_HANDLE -- 未使用
port
    (
    I_26M_clk           : in    std_logic;
    I_reset_n           : in    std_logic;
                        
    I_led_dis           : in    std_logic_vector(3 downto 0);
    I_adc_dis           : in    std_logic;
    I_fifo_full         : in    std_logic;
                        
    O_fpga_led0         : out   std_logic; 
    O_fpga_led1         : out   std_logic;                                     
    O_fpga_led2         : out   std_logic; 
    O_fpga_led3         : out   std_logic
    );
end component;

component frontend -- 重要，数据采集时序。
port
    (
    I_reset_n           : in    std_logic;                     
    I_sys_clk           : in    std_logic;                    
                                
    I_scan_trig         : in    std_logic;   --scan triger
    I_reg_csr           : in    std_logic_vector(31 downto 0);
                                
    --ADC                       
    I_adc_d             : in    std_logic_vector(11 downto 0); 
    I_adc_or            : in    std_logic;               
                                
    I_f2pc_full         : in    std_logic;
                                
    O_pixel_symbol      : out   std_logic; 
    O_pixel_en          : out   std_logic; 
    O_pixel_data        : out   std_logic_vector(15 downto 0);
    O_pulse_trig        : out   std_logic;
    O_shake_start       : out   std_logic
    );
end component; 



component Interface -- 采集时序和USB3.0时序之间的连接
port
    (
    I_reset_n           : in    std_logic;          
    I_sys_clk           : in    std_logic;                     
                                
    --work control              
    O_register          : out   std_logic_vector(31 downto 0);    
    
    --image data output
    I_data_en           : in    std_logic; 
    I_data_symbol       : in    std_logic; 
    I_data              : in    std_logic_vector(15 downto 0); 
                        
    ---usb FIFO         
    O_wfifo_reset       : out   std_logic; 
                                
    O_usb_wrreq         : out   std_logic;  
    O_usb_din           : out   std_logic_vector(15 downto 0);
                        
    O_usb_rdreq         : out   std_logic; 
    I_usb_dout          : in    std_logic_vector(31 downto 0);
    I_usb_rdempty       : in    std_logic   
    );
end component;



component usb_121pll -- USB逻辑时钟倍频 20->60
port
    (
    refclk              : in    std_logic := '0'; --  refclk.clk
    rst                 : in    std_logic := '0'; --   reset.reset
    outclk_0            : out   std_logic;        -- outclk0.clk
    outclk_1            : out   std_logic;        -- outclk0.clk
    locked              : out   std_logic         --  locked.export
    );
end component;




component adc_pll -- ADC时钟分频，240->60
port
    (
    refclk              : in    std_logic := '0'; --  refclk.clk
    rst                 : in    std_logic := '0'; --   reset.reset
    outclk_0            : out   std_logic;        -- outclk0.clk
    outclk_1            : out   std_logic         --  locked.export
    );
end component;



component pulse -- 超声发射
port
    (
    I_clk               : in    std_logic;
    I_reset_n           : in    std_logic;     
    I_pulse_trig        : in    std_logic;
                          
    O_pulse             : out   std_logic_vector(3 downto 0)
    );
end component;



component AD9634 -- 未使用
port
    ( 
    I_adce_clk          : in    std_logic;
    I_adce_d            : in    std_logic_vector(5 downto 0);
    I_adce_or           : in    std_logic;--LVDS
    O_adce_csb          : out   std_logic;
    O_adce_sdio         : out   std_logic;
    O_adce_sclk         : out   std_logic;
                        
    O_adce_data         : out std_logic_vector(11 downto 0)
    );                  
end component;      

    
                        
component AD9235 -- 未使用       
port                    
    (                   
    I_m_adc_d           : in    std_logic_vector(11 downto 0);
    O_m_adc_clk         : out    std_logic;
    I_m_adc_otr         : in    std_logic;
    O_m_adc_pdwn        : out    std_logic
    );                  
end component;    


      
                        
component ADS58C48 -- 未使用     
port                    
    (                   
    O_adca_sen          : out   std_logic;
    I_adca_sd           : in    std_logic;
    O_adca_sdata        : out   std_logic;
    O_adca_sclk         : out   std_logic;
    O_adca_rst          : out   std_logic;
    O_adca_pdn          : out   std_logic;
    O_adca_snrb0        : out   std_logic;
    O_adca_snrb1        : out   std_logic;   
                        
    I_adca_oclk         : in    std_logic;
                        
    I_adca_d            : in    std_logic_vector(5 downto 0);
    I_adcb_d            : in    std_logic_vector(5 downto 0);
    I_adcc_d            : in    std_logic_vector(5 downto 0);
    I_adcd_d            : in    std_logic_vector(5 downto 0);
                        
    O_adca_data         : out   std_logic_vector(11 downto 0);
    O_adcb_data         : out   std_logic_vector(11 downto 0);
    O_adcc_data         : out   std_logic_vector(11 downto 0);
    O_adcd_data         : out   std_logic_vector(11 downto 0)
    );
end component; 





component p2s_dac -- AD5300，DAC时序，串行控制。
port( 
    a,clk,clr           : in    std_logic;
    datain1             : in    std_logic_vector(15 downto 0);
    ld,s_data           : out   std_logic);
end component;




component sine_rom -- 正弦波查找表
	PORT
	(
    address             : IN    STD_LOGIC_VECTOR (6 DOWNTO 0);
    clock               : IN    STD_LOGIC  := '1';
    q                   : OUT   STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END component;




COMPONENT usb_top -- 新版本USB3.0时序，对用户来说就是操作FIFO。
	PORT
	(
		I_sys_clk		:	 IN STD_LOGIC := '1';
		I_usb_clk		:	 IN STD_LOGIC;
		I_sys_rst		:	 IN STD_LOGIC ;
		I_usb_rst		:	 IN STD_LOGIC;
		I_usb_wfifo_aclr		:	 IN STD_LOGIC;
		I_usb_wrreq		:	 IN STD_LOGIC;
		I_usb_din		:	 IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		O_usb_wrfull		:	 OUT STD_LOGIC;
		O_usb_wruesdw		:	 OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		I_usb_rdreq		:	 IN STD_LOGIC;
		O_usb_dout		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		O_usb_rdempty		:	 OUT STD_LOGIC;
		I_usb_uart_tx_req		:	 IN STD_LOGIC;
		I_usb_uart_tx_data		:	 IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		O_usb_uart_tx_full		:	 OUT STD_LOGIC;
		I_usb_uart_rx_req		:	 IN STD_LOGIC;
		O_usb_uart_rx_data		:	 OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		O_usb_uart_rx_empty		:	 OUT STD_LOGIC;
		O_usb_pclk		:	 OUT STD_LOGIC;
		O_usb_clk		:	 OUT STD_LOGIC;
		I_usb_flga		:	 IN STD_LOGIC;
		I_usb_flgb		:	 IN STD_LOGIC;
		O_usb_cs		:	 OUT STD_LOGIC;
		O_usb_wr		:	 OUT STD_LOGIC;
		O_usb_rd		:	 OUT STD_LOGIC;
		O_usb_oe		:	 OUT STD_LOGIC;
		O_usb_a0		:	 OUT STD_LOGIC;
		O_usb_a1		:	 OUT STD_LOGIC;
		O_usb_pkt		:	 OUT STD_LOGIC;
		O_usb_reset		:	 OUT STD_LOGIC;
		IO_usb_dq		:	 INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		O_usb_uart_txd		:	 OUT STD_LOGIC;
		I_usb_uart_rxd		:	 IN STD_LOGIC;
		I_usb_dir		:	 IN STD_LOGIC
	);
END COMPONENT;




COMPONENT register_ctrl_top -- USB桥接芯片的串口通信部分，主要功能是接收上位机控制命令。
	PORT
	(
		I_sys_clk		:	 IN STD_LOGIC := '1';
		I_sys_rst		:	 IN STD_LOGIC := '1';
		O_usb_uart_tx_req		:	 OUT STD_LOGIC;
		O_usb_uart_tx_data		:	 OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		I_usb_uart_tx_full		:	 IN STD_LOGIC := '0';
		O_usb_uart_rx_req		:	 OUT STD_LOGIC;
		I_usb_uart_rx_data		:	 IN STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
		I_usb_uart_rx_empty		:	 IN STD_LOGIC := '0';
		O_usb_dir		:	 OUT STD_LOGIC;
		O_motor_start		:	 OUT STD_LOGIC;
		tp		:	 OUT STD_LOGIC;
        I_key_start :	 IN STD_LOGIC := '1'
	);
END COMPONENT;



signal S_usb_wrfull     : std_logic:= '0';
                        
signal S_pulse          : std_logic_vector (3 downto 0);
signal s_trig_pulse     : std_logic;
                        
constant c_speed_test   : integer := 40000;                          
                        
signal s_reset          : std_logic := '0';
                        
signal s_scan_trig      : std_logic; 
signal s_scan_trig_buf  : std_logic; 
                        
signal s_pll_reset      : std_logic;
signal S_pll_ready      : std_logic;
                        
signal S_usb_wrreq      : std_logic;
signal S_usb_din        : std_logic_vector(15 downto 0);
                        
signal S_usb_wrusedw    : std_logic_vector(15 downto 0):="0000000000000000";
signal S_usb_rdreq      : std_logic;
signal S_usb_dout       : std_logic_vector(31 downto 0);
signal S_usb_rdempty    : std_logic;
signal S_usb_rdusedw    : std_logic_vector(4 downto 0);    
------------usb write state-------------
signal S_usb_wr_state   : std_logic_vector(1 downto 0);
signal S_usb_wr_cnt     : std_logic_vector(9 downto 0);
------------usb read state--------------
signal S_usb_pulse_state: std_logic_vector(1 downto 0);

signal s_usb_clk        : std_logic; 
signal s_pll_locked     : std_logic; 

-------constant for reset and logic judgement------------------
constant C_RST_ON       : std_logic := '0';                             --reset signal the system is low reset 
constant C_ACT_ON       : std_logic := '1';                             --logic  judgement signal 
constant C_ACT_OFF      : std_logic := '0';    
                        
signal S_case_test      : std_logic_vector(1 downto 0);
signal S_case_work      : std_logic_vector(1 downto 0);
                        
signal S_ad_buf         : std_logic_vector(11 downto 0);
signal S_ad_1buf        : std_logic_vector(15 downto 0);
                        
signal S_register       : std_logic_vector(31 downto 0):="00000000000000000000000000000000";
signal s_test_cn        : std_logic_vector(19 downto 0);
signal s_work_cn        : std_logic_vector(19 downto 0);
signal s_line_no        : std_logic_vector(15 downto 0);
signal s_line_comb      : std_logic_vector(15 downto 0);
                        
signal s_pixel_data     : std_logic_vector(15 downto 0); 
signal S_pixel_symbol   : std_logic; 
signal S_pixel_en       : std_logic; 
                        
signal s_sys_clk        : std_logic; 
                        
signal s_sys_reset      : std_logic; 
signal s_pll_lock       : std_logic; 
signal S_pulse_trig     : std_logic; 
                        
signal S_swi4           : std_logic;
signal S_key_start_dcnt       : std_logic_vector (15 downto 0):="0000000000000000";
signal S_key_start_dclk      : std_logic;

signal S_adce_data      : std_logic_vector(11 downto 0);
                        
signal S_adca_data      : std_logic_vector(11 downto 0);
signal S_adcb_data      : std_logic_vector(11 downto 0);
signal S_adcc_data      : std_logic_vector(11 downto 0);
signal S_adcd_data      : std_logic_vector(11 downto 0);

signal s_clk_60m        : std_logic;
signal s_clk_60m_st     : std_logic;

signal S_DA_SYNC        : std_logic;
signal S_DA_cnt         : std_logic_vector(4 downto 0):="00000";
signal S_DA_a           : std_logic;
signal S_DA_addr        : std_logic_vector(7 downto 0);
signal S_DA_rom_q       : std_logic_vector(7 downto 0);
signal S_KEYIN0         : std_logic;
signal S_clk_4883_cnt   : std_logic_vector(7 downto 0);
signal S_clk_4883       : std_logic:='0';
signal S_key0_cnt       : std_logic_vector(24 downto 0);           
signal S_key0_dclk      : std_logic;

signal S_usb_uart_tx_req   : std_logic;
signal S_usb_uart_tx_data  : std_logic_vector(7 downto 0);
signal S_usb_uart_tx_full  : std_logic;
signal S_usb_uart_rx_req   : std_logic;
signal S_usb_uart_rx_data  : std_logic_vector(7 downto 0);
signal S_usb_uart_rx_empty : std_logic;    
signal S_usb_dir           : std_logic;
signal S_motor_start       : std_logic;
signal s_usb_clk_180       : std_logic;

signal S_motor_start_delay : std_logic;
signal S_shake_start       : std_logic:='0';

signal S_key_start_temp1   : std_logic;
signal S_key_start_temp2   : std_logic;
signal S_key_start         : std_logic;







begin   

--s_sys_clk <= I_adcf_clk;

O_pll_pd     <= '1';   --Chip Power Down, Active Low
O_pll_sync   <= '1';   --Manual Synchronizations and Manual Holdover, Active Low
O_pll_rst    <= not s_pll_reset;

O_adcf_pwdn  <= '0';
O_adcf_csb   <= '1';
O_adcf_sclk  <= '1';
O_adcf_sdio  <= '1';
O_adcf_reset <= '1';

--------------------------------
--pulse
--------------------------------
--O_pulse_0pd <= '0';  --1 power down
--O_pulse_1pd <= '0'; 
--O_pulse_2pd <= '0';  
--O_pulse_3pd <= '0'; 

--O_pulse <= S_pulse; 
--O_8020islpulse <= S_pulse; 
--O_8020mdpulse(7 downto 6) <= S_pulse(1 downto 0);


O_8220pulse(3 downto 0) <= S_pulse(3 downto 0);





U0 : pll_conf -- 用于片外PLL配置ADC时钟，也可以不看。
port map
    (
    I_clk               => I_ref_clk,    --20M 
    I_reset_n           => s_pll_lock  ,
                        
    O_ADC_ready         => S_pll_ready,                           
    O_FPGA_ADC_d        => O_pll_sdio,    
    O_FPGA_ADC_clk      => O_pll_sclk,
    O_FPGA_ADC_en       => O_pll_cs, 
    O_FPGA_ADC_reset    => s_pll_reset       
    ); 

	 
	 
	 
	 
U1_LED_HANDLE : LED_HANDLE
port map
    (   
    I_26M_clk           => I_ref_clk    ,
    I_reset_n           => s_pll_lock      ,
    I_led_dis           => "0100"       ,
                        
    I_adc_dis           => '0'   ,
    I_fifo_full         => S_usb_wrfull  ,
                        
    O_fpga_led0         => open,--O_led(0)     ,
    O_fpga_led1         => open,--O_led(1)     ,
    O_fpga_led2         => open,--O_led(2)     ,
    O_fpga_led3         => open--O_led(3)
    );
	 
	 
	 
	 

U0_pulse :   pulse -- 5M发射，60M时钟，类似于分频实现，可参考TC8220的发射时序。
port  map
    (
    I_clk               => s_clk_60m,--s_sys_clk,     
    I_reset_n           => s_pll_lock,      
    I_pulse_trig        => S_pulse_trig,--s_trig_pulse,
                           
    O_pulse             => S_pulse
    );  

	 
	 
--------------------------------
--pulse
--------------------------------
O_pulse_0pd <= '0';  --1 power down
O_pulse_1pd <= '0'; 
O_pulse_2pd <= '1';  
O_pulse_3pd <= '1'; 

s_sys_reset <= not I_reset;





U4_usb_pll : usb_121pll -- USB逻辑时钟
port map
    (
    refclk              => I_ref_clk,         --20M--         
    rst                 => s_sys_reset,
    outclk_0            => s_usb_clk,         --60M--
    outclk_1            => s_usb_clk_180,     --60M--
    locked              => s_pll_lock         ----
    );
    
	 
	 
U5_adc_pll : adc_pll -- ADC随路时钟分频得到的60M，用于数据采集。
port map
    (
    refclk              => I_adcf_clk,             --240M
    rst                 => s_sys_reset,
    outclk_0            => s_clk_60m,         
    outclk_1            => s_clk_60m_st
    );

	 
	 
	 
U0_frontend : frontend -- 重要，数据采集时序。
port map
    (
    I_reset_n            => s_pll_lock      ,         
    I_sys_clk           => s_clk_60m    ,         
                        
    I_scan_trig         => S_motor_start_delay,   --motor start--
    I_reg_csr           => s_register,            -- not used --   
                        
    --ADC                                    
    I_adc_d             => I_adcf_d,
    I_adc_or            => I_adcf_or    ,       
                                                     
    I_f2pc_full         => S_usb_wrfull ,        --not used--
                        
    O_pixel_symbol      => S_pixel_symbol,       --receive valid--
    O_pixel_en          => S_pixel_en,           --18000 period valid --                           
    O_pixel_data        => S_pixel_data,         --receive data --
    O_pulse_trig        => S_pulse_trig,         --trans valid  --     
    O_shake_start       => S_shake_start         -- shake valid --
    ); 
	 
	 
	 
	 
	 

U4_interface : Interface -- 采集时序和USB3.0时序之间的连接
port map
    (
    I_reset_n           => s_pll_lock,        
    I_sys_clk           => s_clk_60m,                        
                       
    --work control     
    O_register          => s_register,           -- output not used--
    
    --image data output
    I_data_en           => S_pixel_en,            --18000 period valid--
    I_data_symbol       => S_pixel_symbol,        --receive valid--   
    I_data              => S_pixel_data,          --receive data --
                        
    ---usb FIFO         
    O_wfifo_reset       => s_reset,               --output for usb_top--
    O_usb_wrreq         => S_usb_wrreq,           --output for usb_top--     
    O_usb_din           => S_usb_din,             --output for usb_top--                  
    O_usb_rdreq         => S_usb_rdreq,           --output for usb_top--
    I_usb_dout          => S_usb_dout,            --input from usb_top--
    I_usb_rdempty       => S_usb_rdempty          --input from usb_top--
    );                  

	 
	 
	 
	 
U33_usbcore : usb_top -- USB3.0
port map
    (    
	 I_sys_clk           => s_clk_60m,         --60M--
	 
    I_usb_clk           => s_usb_clk,         --60M--

    I_sys_rst           => not s_pll_lock,
    I_usb_rst           => not s_pll_lock,

    I_usb_wfifo_aclr    => s_reset,          --input 
    I_usb_wrreq         => S_usb_wrreq,      --input 
    I_usb_din           => S_usb_din,        --input
    O_usb_wrfull        => S_usb_wrfull,     --output-- not used--
    O_usb_wruesdw       => S_usb_wrusedw,    --output-- not used-- 

    I_usb_rdreq         => S_usb_rdreq,      --input--
    O_usb_dout          => S_usb_dout,       --output--
    O_usb_rdempty       => S_usb_rdempty,    --output--

    I_usb_uart_tx_req   => S_usb_uart_tx_req, --input--
    I_usb_uart_tx_data  => S_usb_uart_tx_data,--input--
    O_usb_uart_tx_full  => S_usb_uart_tx_full,--output--

    I_usb_uart_rx_req   => S_usb_uart_rx_req, --input--
    O_usb_uart_rx_data  => S_usb_uart_rx_data,--output--
    O_usb_uart_rx_empty => S_usb_uart_rx_empty,--output--

    O_usb_pclk          => open,               --O_usb_pclk,
    O_usb_clk           => open,

    I_usb_flga          => I_usb_flga,         --input--
	 
    I_usb_flgb          => I_usb_flgb,         --input--

    O_usb_cs            => O_usb_cs,           --output--
	 
    O_usb_wr            => O_usb_wr,           --output--
	 
    O_usb_rd            => O_usb_rd,           --output--
	 
    O_usb_oe            => O_usb_oe,           --output--
	 
    O_usb_a0            => O_usb_a0,           --output--
	 
    O_usb_a1            => O_usb_a1,           --output--
	 
    O_usb_pkt           => O_usb_pkt,          --output--  not used --
	 
    O_usb_reset         => O_usb_reset,        --output--  not used--

    IO_usb_dq           => IO_usb_dq,          --inout--
	 
	 

    O_usb_uart_txd      => O_usb_uart_rxd,     --output--
	 
    I_usb_uart_rxd      => I_usb_uart_txd,     --input--

    I_usb_dir           => S_usb_dir           --input--
	 
);    






O_usb_pclk   <= s_usb_clk_180;





U44_register_ctrl_top : register_ctrl_top

port map
    (
    I_sys_clk           => s_clk_60m, 
    I_sys_rst           => not s_pll_lock,

    O_usb_uart_tx_req   => S_usb_uart_tx_req,
    O_usb_uart_tx_data  => S_usb_uart_tx_data,
    I_usb_uart_tx_full  => S_usb_uart_tx_full,

    O_usb_uart_rx_req   => S_usb_uart_rx_req,
    I_usb_uart_rx_data  => S_usb_uart_rx_data,
    I_usb_uart_rx_empty => S_usb_uart_rx_empty,    

    O_usb_dir           => S_usb_dir,
    O_motor_start       => S_motor_start,
    
    tp                  => open,
    I_key_start         => S_key_start
	 
);
    
	 
	 
	 
	 
U5_AD9634 : AD9634 -- 未使用
port map
    ( 
    I_adce_clk          => I_adce_clk,
    I_adce_d            => I_adce_d,
    I_adce_or           => I_adce_or,
    O_adce_csb          => O_adce_csb,
    O_adce_sdio         => O_adce_sdio,
    O_adce_sclk         => O_adce_sclk,
                       
    O_adce_data         => S_adce_data
    );

	 
	 
U6_AD9235 : AD9235 -- 未使用
port map
    ( 
    I_m_adc_d           => I_m_adc_d,
    O_m_adc_clk         => O_m_adc_clk,
    I_m_adc_otr         => I_m_adc_otr,
    O_m_adc_pdwn        => O_m_adc_pdwn
    );
	 
	 

U7_ADS58C48 : ADS58C48 -- 未使用
port map
    ( 
    O_adca_sen          => O_adca_sen,
    I_adca_sd           => I_adca_sd,
    O_adca_sdata        => O_adca_sdata,
    O_adca_sclk         => O_adca_sclk,
    O_adca_rst          => O_adca_rst,
    O_adca_pdn          => O_adca_pdn,
    O_adca_snrb0        => O_adca_snrb0,
    O_adca_snrb1        => O_adca_snrb1,
                        
    I_adca_oclk         => I_adca_oclk, 
                        
    I_adca_d            => I_adca_d,
    I_adcb_d            => I_adcb_d,
    I_adcc_d            => I_adcc_d,
    I_adcd_d            => I_adcd_d,
                                  
    O_adca_data         => S_adca_data,
    O_adcb_data         => S_adcb_data,
    O_adcc_data         => S_adcc_data,
    O_adcd_data         => S_adcd_data
    );                    

	 
	 
	 
	 
U8_p2s_dac : p2s_dac -- AD5300，DAC时序，串行控制。
port map( 
    a         => S_DA_a,
    clk       => S_clk_4883,
    clr       => not s_pll_lock,
    datain1   => "0000000" & S_DA_rom_q(7 downto 3) & "0000",
    ld        => S_DA_SYNC,
    s_data    => DA_DIN);
	 
	 

	 
	 
DA_SYNC <= not S_DA_SYNC;

DA_SCLK <= not S_clk_4883;





process(I_ref_clk, s_pll_lock) -- 20M时钟分频，最终实现100Hz正弦，20M/128（查找表）/32（串行数据长度）/100（设计频率）=48
begin
    if s_pll_lock = '0' then
        S_clk_4883_cnt <= (others=>'0');
        S_clk_4883 <= '0';
    elsif rising_edge(I_ref_clk) then
        if (S_clk_4883_cnt /= 24)then -- 24翻转一次电平，实现48分频。
            S_clk_4883_cnt <= S_clk_4883_cnt + 1;       
        else
            S_clk_4883 <= not S_clk_4883;  
            S_clk_4883_cnt <= (others=>'0');
        end if;
    end if;
end process; 





process(S_clk_4883)
begin

    if rising_edge(S_clk_4883) then      -- 分频后的时钟用作串行时钟，此处生成16个高电平用于串行DAC时序。
        S_DA_cnt <= S_DA_cnt + 1;
        if S_DA_cnt >= "00001" and S_DA_cnt <= "10001" then
            S_DA_a <= '1';             --valid--
        else 
            S_DA_a <= '0';
        end if;
    end if;

	 
	 
end process;





O_led(0) <= S_motor_start_delay; -- 软件界面点开始之后，灯会灭一下，其他时间常亮，用于工作指示

O_led(1) <= S_motor_start_delay;

O_led(2) <= S_motor_start_delay;

O_led(3) <= S_motor_start_delay;




process(s_clk_60m_st, s_pll_lock,S_motor_start) -- 将上位机通过USB串口发送的开始信号的边沿转变成持续一段时间的电平，作为采集时序的开始使能。
begin

    if s_pll_lock = '0' then
        S_key0_cnt <= (others=>'0');
    elsif rising_edge(s_clk_60m_st) then
        if(S_motor_start='1') then
            S_motor_start_delay <= '1';
            S_key0_cnt   <= "0000000000000000000000001";
        elsif((S_key0_cnt>"0000000000000000000000000") and (S_key0_cnt<"1000000000000000000000000")) then
            S_key0_cnt   <= S_key0_cnt + 1;
        else
            S_motor_start_delay <= '0';
            S_key0_cnt   <= "0000000000000000000000000";              -- dian  deng !--
        end if;
    end if;

end process;




process(S_DA_a,S_shake_start)--,s_register)--S_KEYIN0)
begin

--    if s_register(0) = '1' then
        if S_shake_start = '0' then   
            S_DA_addr <= "00000000";
        elsif rising_edge(S_DA_a) then -- 每发射一组串行数据，地址+1，直到128完成一次正弦波查找表。
            S_DA_addr <= S_DA_addr + 1;
            if S_DA_addr > "01111111" then
                S_DA_addr <= "10000000";
            end if;
        end if;
--    else
--        S_DA_addr <= "00000000";
--    end if;
        
end process;





U9_sine_rom : sine_rom -- 正弦波查找表
	PORT map
	(
    address             => S_DA_addr(6 downto 0),
    clock               => S_DA_a,
    q                   => S_DA_rom_q
	);
	
	
	
          
O_swi_dir <= '1'; -- 电压转换芯片的方向

O_swi_oe <= '0'; -- 电压转换芯片的使能





process(I_ref_clk, s_pll_lock)
begin
    if s_pll_lock = '0' then
	 
        S_key_start_dcnt <= (others=>'0');
		  
        S_key_start_dclk <= '0';
		  
    elsif rising_edge(I_ref_clk) then
	 
        S_key_start_dcnt <= S_key_start_dcnt + 1; 
		  
        if (S_key_start_dcnt = 0)then    
		  
            S_key_start_dclk <= not S_key_start_dclk;                    -- 20*10^6/2^16/2    clk  period -- 
				
        end if;
		  
    end if;
	 
end process; 







process(S_key_start_dclk)
begin
    if rising_edge(S_key_start_dclk) then
        S_key_start_temp1 <= KEYIN0;
    end if;
end process; 




process(s_clk_60m,S_key_start_temp1)
begin
    if rising_edge(s_clk_60m) then
        S_key_start_temp2 <= S_key_start_temp1;
        if S_key_start_temp2 = '0' and S_key_start_temp1 = '1' then                  --rise-- 
            S_key_start <= '1';
        else
            S_key_start <= '0';
        end if;
    end if;
end process; 






end arc_HUCB2P0_TOP;                                                                                                                         
                      