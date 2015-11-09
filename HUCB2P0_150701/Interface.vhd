--*****************************************************************************
--  @Copyright  All rights reserved.                    
--  Module name : Interface
--  Call by     : 
--  Description : 
--  IC          : EP2S60F672I4
--  Version     : 1.0
--  Note:       : 
--  Author      : Weibao Qiu
--  Date        : 2009.05.24
--  Update      : 
--                                
--*****************************************************************************
library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Interface is
port
(
    I_reset_n       : in std_logic;  
	 
    I_sys_clk       : in std_logic;                     
    
    --work control
    O_register      : out std_logic_vector(31 downto 0);    
    
    --image data output
    I_data_en       : in std_logic; 
	 
    I_data_symbol   : in std_logic; 
	 
    I_data          : in std_logic_vector(15 downto 0); 
    
    ---usb FIFO
    O_wfifo_reset   : out std_logic; 
    
    O_usb_wrreq     : out std_logic;  
	 
    O_usb_din       : out std_logic_vector(15 downto 0);
                    
    O_usb_rdreq	  : out std_logic; 
	 
    I_usb_dout		  : in std_logic_vector(31 downto 0);
	 
    I_usb_rdempty	  : in std_logic  
	 
);
end Interface;

architecture rtl of Interface is
 
-----------------------------  
constant c_speed_test  : integer := 180000;--40000;                         
                    
signal s_work_start    : std_logic := '0';
signal s_work_mode     : std_logic_vector (1 downto 0); 

--signal s_scan_trig     : std_logic; 

signal S_usb_wrreq     : std_logic;
signal S_usb_din       : std_logic_vector(15 downto 0);

signal S_usb_rdreq     : std_logic;
signal S_usb_dout      : std_logic_vector(31 downto 0);
signal S_usb_rdempty   : std_logic;

------------usb read state--------------
signal S_usb_pulse_state : std_logic_vector(1 downto 0);

-------constant for reset and logic judgement------------------
constant C_RST_ON		: std_logic := '0'; 							--reset signal the system is low reset 
constant C_ACT_ON		: std_logic := '1'; 							--logic  judgement signal 
constant C_ACT_OFF	: std_logic := '0';    

signal S_case_test  : std_logic_vector(1 downto 0);
signal S_case_work  : std_logic_vector(1 downto 0);

signal S_register   :   std_logic_vector(31 downto 0):="00000000000000000000000000000000";
signal s_test_cn    :   std_logic_vector(19 downto 0);
signal s_work_cn    :   std_logic_vector(19 downto 0);
signal s_line_no    :   std_logic_vector(15 downto 0);
signal s_line_comb  :   std_logic_vector(15 downto 0);






begin   

O_usb_wrreq     <= S_usb_wrreq;

O_usb_din       <= S_usb_din;


O_usb_rdreq     <= S_usb_rdreq;

S_usb_dout      <= I_usb_dout;

S_usb_rdempty   <= I_usb_rdempty;





---------
s_work_start    <= '1';--S_register(0);

s_work_mode     <= "00";--S_register(3 downto 2);

O_register      <= S_register ;

O_wfifo_reset   <= '0';--not S_register(0);
 
--s_scan_trig     <= I_data_symbol;

---------------------------------------------------------------------
-- To navigate the dsc data between the test and work    
--------------------------------------------------------------------- 


process(I_reset_n, I_sys_clk)
begin
    if(I_reset_n = '0')then                                     
        S_usb_wrreq  <= '0'; 
        S_usb_din    <= (others => '0'); 
        s_test_cn    <= (others => '0'); 
        s_work_cn    <= (others => '0'); 
        S_case_test  <= (others => '0'); 
        S_case_work  <= (others => '0');  
        s_line_no    <= (others => '0');   
        s_line_comb  <= (others => '0');                                                                                                           
    elsif rising_edge(I_sys_clk) then      
        case s_work_mode is
            when "10" =>   --Test USB  这种模式不用，可忽略。
                case S_case_test is
                    when "00" =>
                        if (s_work_start = '1') then
                            S_case_test <= "01";   
                        else
                            S_case_test <= "00";
                            s_test_cn   <=  (others => '0'); 
                            s_line_no   <=  (others => '0');  
                            s_line_comb   <=  (others => '0'); 
                        end if;
                
                    when "01" =>                                                  
                        s_test_cn <= s_test_cn + 1;
                        if s_test_cn < 1024 then-- fpga 512 * 32 -> cpu 1024 *16
                            S_usb_wrreq <= '1';--wr fifo 
                        else
                            S_usb_wrreq <= '0';
                            S_case_test <= "10"; 
                        end if;          
                        
                        if S_usb_wrreq = '1' then
                            S_usb_din <= S_usb_din + x"0001";--s_line_comb + x"0001";
                        else
                            S_usb_din <= (others => '0');
                        end if;                                                           
                
                    when "10" =>  
                        if (s_work_start = '0') then
                            S_case_test <= "00";                                       
                        elsif(s_test_cn > c_speed_test)then
                            S_case_test <= "00";   
                            s_test_cn   <=  (others => '0'); 
                            
                            if(s_line_no < 499)then   
                                s_line_no <= s_line_no + '1';
                            else
                                s_line_no <= (others => '0'); 
                            end if;                        
                            s_line_comb <= "000" & s_line_no(15 downto 3);
                        
                        else
                            s_test_cn <= s_test_cn + '1'; 
                        end if;  
                
                    when others =>            
                        S_case_test <= "00";  
                        s_test_cn <= (others => '0');   
                        s_line_no <= (others => '0');  
                        s_line_comb <= (others => '0');                      
                end case;                                                                         
            
            when "00" =>--"01" =>   --Work 只用这一种模式
                
                S_usb_din <= I_data;                                                                 
                if (s_work_start = '1' and I_data_en = '1') then                                                       
                    S_usb_wrreq <= I_data_symbol;                             
                else
                    S_usb_wrreq <= '0';                            
                end if;                

            when OTHERS =>        
                S_usb_wrreq <= '0'; 
                S_usb_din <= (others => '0'); 
                s_test_cn <= (others => '0'); 
                s_work_cn <= (others => '0'); 
                S_case_test <= (others => '0'); 
                S_case_work <= (others => '0');    
                                                       
        end case;                          
    end if; 
end process;  




	      
------------read data from usb 3.0 to FPGA----------work well
process(I_sys_clk,I_reset_n)
begin
    if I_reset_n = '0' then -- 此进程用于校验上位机通过USB主通道下发的数据的头。
	 
        S_usb_rdreq	      <= C_ACT_OFF; 
        S_usb_pulse_state	<= (others=> '0');
        S_register	      <= (others=> '0');
    elsif rising_edge(I_sys_clk) then 
	 
        if S_usb_rdempty	= C_ACT_OFF then 					--data not empty usb has write data into fifo 		
          S_usb_rdreq		<= C_ACT_ON; 
        else
          S_usb_rdreq		<= C_ACT_OFF; 
        end if;
         
        case S_usb_pulse_state is										--execute and pause correct
		  
          when "00" =>
			 
            if S_usb_dout = x"5b5a0000" then
       	      S_usb_pulse_state		<= S_usb_pulse_state + 1;
				 else 
				   S_usb_pulse_state    <= "00"; 
       	    end if;
       	    
       	  when "01" =>
			  
       	    if S_usb_dout = x"7f7e0000" then
				 
       	      S_usb_pulse_state		<= S_usb_pulse_state + 1;
					
				  else
				   S_usb_pulse_state    <= "01";
					
       	    end if;
       	    
       	  when "10" =>
			  
       	    if S_usb_dout /= x"7f7e0000" then
				 
       	      S_usb_pulse_state			<= "00" ;
       	      S_register              <= S_usb_dout;
            end if;
            
       	  when others=>
			   
       	      S_usb_pulse_state			<= "00" ;
       	    
        end case;
    end if;
end process;  	 	
     	  
     
	
	
	
	
end rtl;