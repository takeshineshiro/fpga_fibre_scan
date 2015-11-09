--*****************************************************************************
--  @Copyright 2013 by SIAT_HFUS_TEAM, All rights reserved.                    
--  Module name : AD9634
--  Call by     : 
--  Description : this module is the top module of AD9634.
--  IC          : 5CGXFC7D7F31C8N
--  Version     : A                                                    
--  Note:       : 
--  Author      : Peitian Mu 
--  Date        : 2013.11.29                                                  
--  Update      : 
--*****************************************************************************
library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity AD9634 is
port
    ( 
    I_adce_clk      : in    std_logic;
    I_adce_d        : in    std_logic_vector(5 downto 0);
    I_adce_or       : in    std_logic;--LVDS
    O_adce_csb      : out   std_logic;
    O_adce_sdio     : out   std_logic;
    O_adce_sclk     : out   std_logic;
 
    O_adce_data     : out std_logic_vector(11 downto 0)
    );
end AD9634; 

architecture rtl of AD9634 is

component ADC_DDIO
port(
    datain          : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
    inclock         : IN STD_LOGIC ;
    dataout_h       : OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
    dataout_l       : OUT STD_LOGIC_VECTOR (5 DOWNTO 0)
    );
end component;

signal S_adc_ad_12  : std_logic_vector(11 downto 0);

begin

U0_ddio_in: ADC_DDIO
port map(
    datain          => I_adce_d,
    inclock         => I_adce_clk,
    dataout_h       => S_adc_ad_12(11 downto 6),
    dataout_l       => S_adc_ad_12(5 downto 0)
    );
process(I_adce_clk)
begin

    if rising_edge(I_adce_clk) then  
        O_adce_data(11) <= S_adc_ad_12(11);
        O_adce_data(10) <= S_adc_ad_12(5);
        O_adce_data(9)  <= S_adc_ad_12(10);
        O_adce_data(8)  <= S_adc_ad_12(4);
        O_adce_data(7)  <= S_adc_ad_12(9);
        O_adce_data(6)  <= S_adc_ad_12(3);
        O_adce_data(5)  <= S_adc_ad_12(8);
        O_adce_data(4)  <= S_adc_ad_12(2);
        O_adce_data(3)  <= S_adc_ad_12(7);
        O_adce_data(2)  <= S_adc_ad_12(1);
        O_adce_data(1)  <= S_adc_ad_12(6);
        O_adce_data(0)  <= S_adc_ad_12(0);
    end if;

end process;
 
end rtl;
