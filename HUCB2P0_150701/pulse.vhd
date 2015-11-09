--*****************************************************************************
--  @Copyright 2010 by guyoubao, All rights reserved.                    
--  Module name : Pulse control
--  Call by     : 
--  Description :
--  IC          : EP3C16F484C6
--  Version     : A                                                   
--  Note:       : 
--  Author      : Weibao Qiu 
--  Date        : 2010.08.28                                                  
--  Update      :   
--                
--              
--                
--*****************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity pulse is
port
(
    I_clk         :   in    std_logic;
    I_reset       :   in    std_logic;       
    I_pulse_trig  :   in    std_logic;
    
    O_pulse       :   out std_logic_vector(3 downto 0)                    
);
end pulse;

architecture ARC_pulse of pulse is

signal S_cnt     : std_logic_vector(7 downto 0);
signal s_case     : std_logic_vector(1 downto 0);
signal s_pulse_buf         : std_logic; 
signal s_pulse     : std_logic_vector(3 downto 0);

begin

O_pulse <= s_pulse;

process(I_reset,I_clk)
begin
  if I_reset = '0' then
    s_case <= (others=>'0');
    S_cnt <= (others=>'0');
    s_pulse(0) <= '0';             
    s_pulse(1) <= '1'; 
    s_pulse_buf <= '0';
  elsif rising_edge(I_clk) then
    
    s_pulse_buf <= I_pulse_trig;
  
    case s_case is
      when "00" =>                             
        if(s_pulse_buf = '0' and I_pulse_trig = '1')then     
            s_case <= "01";
            S_cnt <= S_cnt + '1';
        else              
            s_case <= (others=>'0');
            S_cnt <= (others=>'0');
            s_pulse(0) <= '0';             
            s_pulse(1) <= '1'; 
        end if;
        
      when "01" =>
        S_cnt <= S_cnt + '1';  
        if(S_cnt >= 4 and S_cnt <= 5)then                 
            s_pulse(1) <= '0';
        else
            s_pulse(1) <= '1';
        end if;
        
        if(S_cnt >= 2 and S_cnt <= 3)then        
            s_pulse(0) <= '1'; 
        else
            s_pulse(0) <= '0';
        end if;                 
             
        if(S_cnt = 0)then        
            s_case <= (others=>'0');
        end if;                                  
         
      when others =>            
        s_case <= (others=>'0');
        S_cnt <= (others=>'0');
        s_pulse(0) <= '0';             
        s_pulse(1) <= '1';
          
    end case;

  end if;
end process;

end ARC_pulse;