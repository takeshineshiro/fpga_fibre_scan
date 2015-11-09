--*****************************************************************************
--  @Copyright 2013 by SIAT_HFUS_TEAM, All rights reserved.                    
--  Module name : ADS58C48
--  Call by     : 
--  Description : this module is the top module of ADS58C48.
--  IC          : 5CGXFC7D7F31C8N
--  Version     : A                                                    
--  Note:       : 
--  Author      : Peitian Mu 
--  Date        : 2013.12.02                                                  
--  Update      : 
--*****************************************************************************
library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ADS58C48 is
port
    ( 
    O_adca_sen      : out   std_logic;
    I_adca_sd       : in    std_logic;
    O_adca_sdata    : out   std_logic;
    O_adca_sclk     : out   std_logic;
    O_adca_rst      : out   std_logic;
    O_adca_pdn      : out   std_logic;
    O_adca_snrb0    : out   std_logic;
    O_adca_snrb1    : out   std_logic;   
    
    I_adca_oclk     : in    std_logic;

    I_adca_d        : in    std_logic_vector(5 downto 0);
    I_adcb_d        : in    std_logic_vector(5 downto 0);
    I_adcc_d        : in    std_logic_vector(5 downto 0);
    I_adcd_d        : in    std_logic_vector(5 downto 0);
    
    O_adca_data     : out   std_logic_vector(11 downto 0);
    O_adcb_data     : out   std_logic_vector(11 downto 0);
    O_adcc_data     : out   std_logic_vector(11 downto 0);
    O_adcd_data     : out   std_logic_vector(11 downto 0)
    );
end ADS58C48; 

architecture rtl of ADS58C48 is

component ADC_DDIO
port(
    datain          : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
    inclock         : IN STD_LOGIC ;
    dataout_h       : OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
    dataout_l       : OUT STD_LOGIC_VECTOR (5 DOWNTO 0)
    ); 
end component;

signal S_adca_ad_12 : std_logic_vector(11 downto 0);
signal S_adcb_ad_12 : std_logic_vector(11 downto 0);
signal S_adcc_ad_12 : std_logic_vector(11 downto 0);
signal S_adcd_ad_12 : std_logic_vector(11 downto 0);

begin

U0_ddio_in_a: ADC_DDIO
port map(
    datain          => I_adca_d,
    inclock         => I_adca_oclk,
    dataout_h       => S_adca_ad_12(11 downto 6),
    dataout_l       => S_adca_ad_12(5 downto 0)
    );
    
    O_adca_data(11) <= S_adca_ad_12(11);
    O_adca_data(10) <= S_adca_ad_12(5);
    O_adca_data(9)  <= S_adca_ad_12(10);
    O_adca_data(8)  <= S_adca_ad_12(4);
    O_adca_data(7)  <= S_adca_ad_12(9);
    O_adca_data(6)  <= S_adca_ad_12(3);
    O_adca_data(5)  <= S_adca_ad_12(8);
    O_adca_data(4)  <= S_adca_ad_12(2);
    O_adca_data(3)  <= S_adca_ad_12(7);
    O_adca_data(2)  <= S_adca_ad_12(1);
    O_adca_data(1)  <= S_adca_ad_12(6);
    O_adca_data(0)  <= S_adca_ad_12(0);

U1_ddio_in_b: ADC_DDIO
port map(
    datain          => I_adcb_d,
    inclock         => I_adca_oclk,
    dataout_h       => S_adcb_ad_12(11 downto 6),
    dataout_l       => S_adcb_ad_12(5 downto 0)
    );
    
    O_adcb_data(11) <= S_adcb_ad_12(11);
    O_adcb_data(10) <= S_adcb_ad_12(5);
    O_adcb_data(9)  <= S_adcb_ad_12(10);
    O_adcb_data(8)  <= S_adcb_ad_12(4);
    O_adcb_data(7)  <= S_adcb_ad_12(9);
    O_adcb_data(6)  <= S_adcb_ad_12(3);
    O_adcb_data(5)  <= S_adcb_ad_12(8);
    O_adcb_data(4)  <= S_adcb_ad_12(2);
    O_adcb_data(3)  <= S_adcb_ad_12(7);
    O_adcb_data(2)  <= S_adcb_ad_12(1);
    O_adcb_data(1)  <= S_adcb_ad_12(6);
    O_adcb_data(0)  <= S_adcb_ad_12(0);

U2_ddio_in_c: ADC_DDIO
port map(
    datain          => I_adcc_d,
    inclock         => I_adca_oclk,
    dataout_h       => S_adcc_ad_12(11 downto 6),
    dataout_l       => S_adcc_ad_12(5 downto 0)
    );
    
    O_adcc_data(11) <= S_adcc_ad_12(11);
    O_adcc_data(10) <= S_adcc_ad_12(5);
    O_adcc_data(9)  <= S_adcc_ad_12(10);
    O_adcc_data(8)  <= S_adcc_ad_12(4);
    O_adcc_data(7)  <= S_adcc_ad_12(9);
    O_adcc_data(6)  <= S_adcc_ad_12(3);
    O_adcc_data(5)  <= S_adcc_ad_12(8);
    O_adcc_data(4)  <= S_adcc_ad_12(2);
    O_adcc_data(3)  <= S_adcc_ad_12(7);
    O_adcc_data(2)  <= S_adcc_ad_12(1);
    O_adcc_data(1)  <= S_adcc_ad_12(6);
    O_adcc_data(0)  <= S_adcc_ad_12(0);

U3_ddio_in_d: ADC_DDIO
port map(
    datain          => I_adcd_d,
    inclock         => I_adca_oclk,
    dataout_h       => S_adcd_ad_12(11 downto 6),
    dataout_l       => S_adcd_ad_12(5 downto 0)
    );
    
    O_adcd_data(11) <= S_adcd_ad_12(11);
    O_adcd_data(10) <= S_adcd_ad_12(5);
    O_adcd_data(9)  <= S_adcd_ad_12(10);
    O_adcd_data(8)  <= S_adcd_ad_12(4);
    O_adcd_data(7)  <= S_adcd_ad_12(9);
    O_adcd_data(6)  <= S_adcd_ad_12(3);
    O_adcd_data(5)  <= S_adcd_ad_12(8);
    O_adcd_data(4)  <= S_adcd_ad_12(2);
    O_adcd_data(3)  <= S_adcd_ad_12(7);
    O_adcd_data(2)  <= S_adcd_ad_12(1);
    O_adcd_data(1)  <= S_adcd_ad_12(6);
    O_adcd_data(0)  <= S_adcd_ad_12(0);
 
end rtl;
