--*****************************************************************************
--  @Copyright 2013 by SIAT_HFUS_TEAM, All rights reserved.                    
--  Module name : AD9235
--  Call by     : 
--  Description : this module is the top module of AD9235.
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

entity AD9235 is
port
    ( 
    I_m_adc_d       : in    std_logic_vector(11 downto 0);
    O_m_adc_clk     : out   std_logic;
    I_m_adc_otr     : in    std_logic;
    O_m_adc_pdwn    : out   std_logic
    );
end AD9235; 

architecture rtl of AD9235 is

begin
 
end rtl;
