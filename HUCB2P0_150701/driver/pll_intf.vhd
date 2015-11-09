--*****************************************************************************
--  @Copyright  All rights reserved.                    
--  Module name : adc_intf
--  Call by     : 
--  Description : adc_intf,ADS5517 ADC�������ܣ�
--                �������ݲ���16λ,����MSB��������.
--                I_ADC_trig,�������������뵽�ڲ���λ�Ĵ���,
--                ADC��һ����������O_ADC_ready�ź� 
--  IC          : 
--  Version     : A
--  Note:       : 
--  Author      : Derek Qiu
--  Date        : 2010.08
--  Update      : 
--                 2010.08.05  updated for PLL in Pulser board, change the name to pll_conf  
--                             Set the sending data to 24 bits.
--                             The maximal speed for SPI clock is 25MHz, sclk is 16 divide for main clock
--                             For the sclk, write data are registered on the rising edge, read data are registered on the falling edge 
--                  
--*****************************************************************************
library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity pll_intf is
port
(
     I_clk              : in    std_logic;
     I_reset_n          : in    std_logic; 
     I_ADC_data         : in    std_logic_vector(23 downto 0);  
     O_ADC_ready        : out   std_logic;                     --���໷��������״̬,�ߵ�ƽ��ʾ����             
     I_ADC_trig         : in    std_logic;                     --���໷���ô����ź�,������ͬʱ����ʱ�����ٱ������clock����
     
     O_FPGA_ADC_d       : out   std_logic; 
     O_FPGA_ADC_clk     : out   std_logic;  
     O_FPGA_ADC_en      : out   std_logic;
     O_FPGA_ADC_reset   : out   std_logic 
);
end pll_intf;

architecture rtl of pll_intf is

signal S_ADC_data       : std_logic_vector(23 downto 0);--���໷�����Ĵ���
signal S_trig_1buf      : std_logic;                    --���������źŻ���
signal S_trig_2buf      : std_logic;                    --���������źŻ���
signal S_trig_3buf      : std_logic;                    --���������źŻ���
signal S_adcclk_cn      : std_logic_vector(3 downto 0); --adc����ʱ������,������λ���ɼ�����
signal S_adc_cn         : std_logic_vector(4 downto 0); --adc����������
signal S_adc_ready      : std_logic;                    --adc��������״̬
signal S_ready_timeout  : std_logic_vector(11 downto 0);--æ״̬��ʱ������
signal S_adc_flag       : std_logic;                    --��������

signal S_FPGA_ADC_clk       : std_logic;  
signal S_FPGA_ADC_en       : std_logic; 
 

signal S_reset_cnt       : std_logic_vector(15 downto 0);
signal S_FPGA_ADC_reset       : std_logic; 

constant C_DATA_WIDTH : std_logic_vector := "11000";   --The width of pending data is 24 bit

begin

O_ADC_ready <= S_adc_ready and (not S_FPGA_ADC_reset);--����״̬����

--O_FPGA_ADC_clk <= not S_FPGA_ADC_clk;  --Falling edge to register data
O_FPGA_ADC_clk <= S_FPGA_ADC_clk;      --rising edge to register data
O_FPGA_ADC_en <= S_FPGA_ADC_en;
O_FPGA_ADC_reset <= S_FPGA_ADC_reset;

 --   O_5517reset <= '1';  
 --   O_5517sclk  <= '0';  
 --   O_5517sdata <= '0';  
 --   O_5517sen   <= '1';  

--------------------------------------------------------------------------------------------------
--ȡtrig�ź�������,��������������ADC_reg,��ʼ����������
--------------------------------------------------------------------------------------------------
process(I_reset_n,I_clk)
begin
    if(I_reset_n = '0')then
        S_trig_1buf <= '0';
        S_trig_2buf <= '0';
        S_adc_flag  <= '0';
        S_ADC_data  <= (others => '0');
        S_adcclk_cn <= (others => '0');
        S_adc_cn    <= (others => '0');
        S_FPGA_ADC_en  <= '1';
    elsif(I_clk'event and I_clk = '1')then
        S_trig_2buf <= S_trig_1buf;
        S_trig_1buf <= I_ADC_trig;
        --trig�ź������ؽ����ݴ���reg
        if(S_trig_2buf = '0')and (S_trig_1buf = '1')then
            S_ADC_data <= I_ADC_data;
            S_adc_flag <= '1';
            S_adcclk_cn <= (others => '0');
            S_adc_cn    <= (others => '0');
            
            S_FPGA_ADC_en  <= '0';
        --��ʼ����������
        elsif(S_adc_flag = '1')then
            S_adcclk_cn <= S_adcclk_cn + '1';
            if( S_adcclk_cn = x"F")then
                if(S_adc_cn = C_DATA_WIDTH)then    --last data is arriving
                    S_adc_flag <= '0';
                    S_adcclk_cn <= (others => '0');
                    S_adc_cn <= (others => '0');
                    S_FPGA_ADC_en  <= '1';
                else
                    S_adc_cn <= S_adc_cn + '1';
                    S_ADC_data(23 downto 1) <= S_ADC_data(22 downto 0);
                end if;
            end if;
        end if;
        
    end if;
end process;
--------------------------------------------------------------------------------------------------
--״̬���,
--------------------------------------------------------------------------------------------------
process(I_reset_n,I_clk)
begin
    if(I_reset_n = '0')then
        S_adc_ready <= '1';
        S_ready_timeout <= (others => '0');
    elsif(I_clk'event and I_clk = '1')then
        if(S_trig_2buf = '0')and (S_trig_1buf = '1')then--��������
            S_adc_ready <= '0';
        elsif(S_ready_timeout(11) = '1')or(S_adc_flag = '0')then--æ״̬timeout,��һ������������������������̬
            S_adc_ready <= '1';
        end if;
        --æ״̬��������
        if(S_adc_ready = '0')then--adc����æ
            S_ready_timeout <= S_ready_timeout + '1';
        else
            S_ready_timeout <= (others => '0');
        end if; 
        
    end if;
end process;
--------------------------------------------------------------------------------------------------
--ADC��������
--------------------------------------------------------------------------------------------------
process(I_reset_n,I_clk)
begin
    if(I_reset_n = '0')then
        O_FPGA_ADC_d   <= '0'; 
        S_FPGA_ADC_clk <= '0';
    elsif(I_clk'event and I_clk = '1')then
        if(S_adc_flag = '1')then
            if(S_adc_cn =C_DATA_WIDTH)then --��le�ź�, last data is arriving
                O_FPGA_ADC_d   <= '0';
                S_FPGA_ADC_clk <= '0';
            else--����������
                O_FPGA_ADC_d   <= S_ADC_data(23);
                S_FPGA_ADC_clk <= S_adcclk_cn(3);   --sclk is 16 divide for the main clock
            end if;
        else
            O_FPGA_ADC_d   <= '0';
            S_FPGA_ADC_clk <= '0';
        end if;
    end if;
end process;
--------------------------------------------------------------------------------------------------
--Reset
--------------------------------------------------------------------------------------------------
process(I_reset_n,I_clk)
begin
    if(I_reset_n = '0')then
        S_FPGA_ADC_reset <= '1';
        S_reset_cnt <= (others => '0');
    elsif(I_clk'event and I_clk = '1')then
       -- S_FPGA_ADC_reset <= '0';
       
        S_reset_cnt <= S_reset_cnt + 1;
        if(S_reset_cnt = x"FF00")then--adc����æ
            S_FPGA_ADC_reset <= '1';
        elsif((S_reset_cnt = x"FFFE"))then
            S_FPGA_ADC_reset <= '0';
            S_reset_cnt <= S_reset_cnt - 1;
        elsif(S_trig_2buf = '0')and (S_trig_1buf = '1') and (I_ADC_data = x"FFFFFF")then
            S_reset_cnt <= x"FEFF";
        end if; 
        
    end if;
end process;
end rtl;