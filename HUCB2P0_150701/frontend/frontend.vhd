--*****************************************************************************
--  @Copyright  All rights reserved.                    
--  Module name : frontend
--  Call by     : 
--  Description : 
--  IC          : 
--  Version     : 1.0
--  Note:       : 
--  Author      : QIU Weibao
--  Date        : 2013.08.06
--  Update      : 
--  
--                                            
--*****************************************************************************
library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity frontend is
port
(
    I_reset_n        : in std_logic;                     
    I_sys_clk        : in std_logic;    
                   
    I_scan_trig      : in std_logic;   --scan triger
    I_reg_csr        : in std_logic_vector(31 downto 0);
     
    --ADC
    I_adc_d          : in std_logic_vector(11 downto 0); 
    I_adc_or         : in std_logic;               
    
    I_f2pc_full      : in std_logic;
    
    O_pixel_symbol   : out std_logic; 
    O_pixel_en       : out std_logic; 
    O_pixel_data     : out std_logic_vector(15 downto 0);
	O_pulse_trig      : out std_logic;
    O_shake_start    : out std_logic
);
end frontend; 

architecture rtl of frontend is

--component fir_band_pass is                            
--PORT 
--(
--    clk                : IN STD_LOGIC;
--    reset_n            : IN STD_LOGIC;
--    ast_sink_data    : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
--    ast_sink_valid    : IN STD_LOGIC;
--    ast_source_ready: IN STD_LOGIC;
--    ast_sink_error    : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
--    ast_source_data    : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
--    ast_sink_ready    : OUT STD_LOGIC;
--    ast_source_valid: OUT STD_LOGIC;
--    ast_source_error: OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
--);
--end component;

component analytic_filter_h_a1 is                    -- component hilbert tansform
generic(
     input_data_width      : integer := 16;
     output_data_width     : integer := 16;
     filter_delay_in_clks    : integer := 7         --delay of hilbert filter (including pipeline delay)
);
port(
    clk_i        : in std_logic;
    rst_i        : in std_logic;                    --high level reset 
    data_str_i    : in std_logic;                    --hilbert tranform enable
    data_i        : in std_logic_vector(input_data_width-1 downto 0);
    data_i_o     : out std_logic_vector(output_data_width-1 downto 0);
    data_q_o     : out std_logic_vector(output_data_width-1 downto 0);
    data_str_o     : out std_logic
);
end component;

component r2p_corproc
	port(
		clk	: in std_logic;
		ena	: in std_logic;
		Xin	: in STD_LOGIC_VECTOR(15 downto 0);
		Yin : in STD_LOGIC_VECTOR(15 downto 0);		
		Rout	: out STD_LOGIC_VECTOR(19 downto 0);
		Aout	: out STD_LOGIC_VECTOR(19 downto 0)
	);
end component;

--constant C_FILTER_DELAY    : integer := 17;      --filter delay 15, adc buffer 2
constant C_CORDIC_DELAY    : integer := 1000;--20; 

signal s_scan_trig      :   std_logic:='0';                             
signal s_work_start     :   std_logic;  

signal S_fir_sink_valid     : std_logic;                        --filter input data valid 
signal S_fir_sink_ready     : std_logic;                        --filter is able to accept data
signal S_fir_source_valid   : std_logic;                        --assert by fir filter when there is valid data to output
signal S_fir_source_error   : std_logic_vector(1 downto 0);        --"00" no error 
signal S_fir_source_data    : std_logic_vector(15 downto 0);    --filter output data 

signal S_hilbert_reset      : std_logic;                        --high level reset 
signal S_hilbert_data_str_i : std_logic;
signal S_hilbert_data_io    : std_logic_vector(15 downto 0);
signal S_hilbert_data_qo    : std_logic_vector(15 downto 0);
signal S_hilbert_data_str_o : std_logic;

signal S_cordic_rout        :   std_logic_vector(19 downto 0):=x"00000";
signal S_cordic_aout        :   std_logic_vector(19 downto 0);
                        
signal S_ad_buf         :   std_logic_vector(11 downto 0);                          
                                                          
signal S_ocnt       : std_logic_vector(19 downto 0):="00000000000000000000";

signal S_state   :   std_logic_vector(2 downto 0); 

signal s_oen    : std_logic;
signal s_den        : std_logic;                  

signal s_scan_start : std_logic; 
signal S_scan_state : std_logic_vector(1 downto 0);

signal s_work_start_buf : std_logic; 
signal S_line_num : std_logic_vector(9 downto 0);

constant C_line_delay  : integer := 17000;--4700;--181250;--40000;

signal S_line_delay    : std_logic_vector(19 downto 0):="00000000000000000000";  

signal S_hilbert_data_i_0 : std_logic_vector(15 downto 0); 
signal S_hilbert_data_i_1 : std_logic_vector(15 downto 0); 
signal S_hilbert_data_i : std_logic_vector(15 downto 0);   
signal S_hilbert_data_i_temp : std_logic_vector(15 downto 0);                  
signal S_pulse_trig   : std_logic;

signal S_data_type          : std_logic_vector(1 downto 0);
signal S_delay_cnt          : std_logic_vector(20 downto 0);   




begin




s_work_start          <= '1';--I_reg_csr(0);   

S_hilbert_data_i_temp <= I_adc_d(11) &  I_adc_d(11) & I_adc_d(11) & I_adc_d(11) & I_adc_d;


O_pixel_symbol        <= s_den;                     
O_pixel_data          <= S_hilbert_data_i; -- 将AD9230采集到的数据未经任何处理，直接上传上位机。 
O_pixel_en            <= s_oen;  
O_pulse_trig          <= S_pulse_trig;

--------------------RF DATA--------------------
S_data_type          <= "01";--I_reg_csr(5 downto 4);




process(I_sys_clk, I_reset_n) -- 打拍，把AD9230的数据读进来。
begin
  
  if (I_reset_n='0')  then
        
   S_hilbert_data_i_0  <= (others=>'0');
   S_hilbert_data_i_1  <= (others=>'0');
	S_hilbert_data_i    <= (others=>'0');
			
  elsif(I_sys_clk'event and I_sys_clk='1') then
    S_hilbert_data_i_0 <= S_hilbert_data_i_temp;
    S_hilbert_data_i_1 <= S_hilbert_data_i_0;
    S_hilbert_data_i <= S_hilbert_data_i_1;
end if;

end process;


 
process(I_sys_clk,I_reset_n)
  begin
    if (I_reset_n = '0') then
		S_state               <= (others=>'0');
		S_ocnt                <= (others=>'0');
		s_oen                 <= '0';
		s_den                 <= '0';
		S_pulse_trig          <= '0';
	  	S_hilbert_reset       <= '1';
	  	S_hilbert_data_str_i  <= '0'; 
      S_delay_cnt           <= (others=>'0');
		S_line_num            <= (others => '0');
		S_line_delay          <= (others => '0');
		
	elsif rising_edge(I_sys_clk) then  
	
	     s_work_start_buf       <= s_work_start;  	    	    
	     s_scan_trig            <= I_scan_trig;
        S_hilbert_data_str_i   <= '1';   
        S_hilbert_reset        <= '0';
	  
		case S_state is
		    when "000" =>   -- 等待开始。			    							
				if (s_scan_trig = '0' and I_scan_trig = '1' and s_work_start_buf = '1')then
                    S_state      <= "001";	
                    s_oen        <= '1'; 
                    S_line_num   <= (others => '0');
                    S_line_delay <= (others => '0');
				else 
				        S_ocnt       <= (others=>'0');
				        s_oen        <= '0';
		              s_den        <= '0';
		              S_line_num   <= (others => '0');
					     S_line_delay <= (others => '0');
					     S_pulse_trig <= '0';
				end if;
			when "001" =>
            if S_delay_cnt >= 1000 then -- 丢掉测试前的1000个点，此处没特殊意义，调试遗留，不影响使用，可删除。
                    S_state     <= "010";	
                    S_delay_cnt <= (others=>'0');
                else
                    S_delay_cnt <= S_delay_cnt +1;
                end if;

			 when "010" => 	
				      S_pulse_trig <= '1'; -- 超声发射使能有效，开始超声激励。   --start trans--
                  S_delay_cnt  <= (others=>'0');
				  if (S_ocnt >= C_CORDIC_DELAY) then -- 每条线丢掉前1000个点，因为离表面太近，数据不参与计算。   --recive delay time-- 
				     S_state      <= "011";	
				     s_den        <= '1';            --  start receive  --  
					  S_ocnt       <= (others=>'0');	 
				  else
				     S_ocnt       <= S_ocnt + 1;				
				  end if;
				  
			 when "011" => 
			      if (S_ocnt >= 4095) then         -- 每条线采集4096点 
				     S_state      <= "100";	    
					  S_ocnt       <= (others=>'0');
					  s_den        <= '0';           -- stop  receive--    
					  S_line_num   <= S_line_num + 1;
					  S_pulse_trig <= '0';           -- stop  trans ---  
				  else
				     S_ocnt       <= S_ocnt + 1;				
				  end if;
				  
				  S_line_delay    <= S_line_delay + 1;
				  
			 when "100" => 
			      if S_line_num > 299 then        -- 采集300条线
					    	S_state      <= "101";
					else
						if S_line_delay > C_line_delay then
							S_state      <= "010";
							S_line_delay <= (others => '0');
						else
							S_line_delay <= S_line_delay + 1;
						end if;
					end if;		
					
					
					
					
		     when "101"  => 
		               	  
					    S_state      <= (others=>'0');
		             S_ocnt       <= (others=>'0');
		             s_oen        <= '0';
		             s_den        <= '0';
			          S_pulse_trig <= '0';   
                   S_line_num   <= (others => '0');
					
					
					
					
			 when others=>
			 
			          S_state      <= (others=>'0');
		             S_ocnt       <= (others=>'0');
		             s_oen        <= '0';
		             s_den        <= '0';
			          S_pulse_trig <= '0';   
                   S_line_num   <= (others => '0');
		end case ;
  end if;
  
  if S_line_num > 33 then -- 在采集第33条线时，电磁铁开始振动，此数值需结合算法修改，不能随意变动。
            O_shake_start <= '1';
        else
            O_shake_start <= '0';
        end if;
  
  
  
  
end process; 
 




U2_analytic_filter_h_a1_inst:analytic_filter_h_a1 -- 未使用
generic map( 
    input_data_width     => 16,         
    output_data_width    => 16,
    filter_delay_in_clks => 7                             --delay of hilbert filter (including pipeline delay)
)
port map(
    clk_i      => I_sys_clk,--I_sys_clk,
    rst_i      => S_hilbert_reset,                        --high reset
    data_str_i => S_hilbert_data_str_i,
    data_i     => S_hilbert_data_i,--S_fir_source_data,
    data_i_o   => S_hilbert_data_io,
    data_q_o   => S_hilbert_data_qo,
    data_str_o => S_hilbert_data_str_o                    -- delay 7 clock than data_str_i
);                                                                                               
  
  
  
  
  
U6_r2p_corproc_inst:r2p_corproc -- 未使用
port map
(
    clk  => I_sys_clk,--I_sys_clk,
    ena  => '1',
    Xin  => S_hilbert_data_io,
    Yin  => S_hilbert_data_qo,
    Rout => S_cordic_rout,
    Aout => S_cordic_aout
); 






--    
end rtl;