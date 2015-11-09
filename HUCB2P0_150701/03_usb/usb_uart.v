module usb_uart#(
    parameter   BAUDRATE            = 115200    ,//115200bps
    parameter   CLOCK_FREQUENCY     = 60         //60MHz
)
(
    input                             I_sys_clk           , 
    input                             I_usb_clk           ,
    
    input                             I_sys_rst           ,
    input                             I_usb_rst           ,
    //=====================System usb_uart_if============================
    input                             I_usb_uart_tx_req   ,
	 
    input   [7 : 0]                   I_usb_uart_tx_data  ,
	 
    output                            O_usb_uart_tx_full  ,
	 
    
    input                             I_usb_uart_rx_req   ,
	 
    output  [7 : 0]                   O_usb_uart_rx_data  ,
	 
    output                            O_usb_uart_rx_empty ,
    //===================================================================
    output                            O_usb_uart_txd      , 
	 
    input                             I_usb_uart_rxd          
);
//=======================================================================
localparam   BDDIV               = (CLOCK_FREQUENCY * 1000000)/BAUDRATE;
//=======================================================================
//baudrate
reg     [15: 0]                 R_bddiv_reg = BDDIV ;
reg     [15: 0]                 R_tx_bd_cnt         ;
reg     [15: 0]                 R_rx_bd_cnt         ;
reg                             R_tx_bd_pulse       ;
reg                             R_rx_bd_pulse       ;
reg                             R_rx_busy           ;
//tx,rx state   
reg     [2 : 0]                 R_tx_state          ;
reg     [2 : 0]                 R_rx_state          ;
reg     [6: 0 ]                 R_tx_bit_index      ;
reg     [6: 0 ]                 R_rx_bit_index      ;

reg                             R_txd               ;
    
reg                             R_rxd_d0            ;
reg                             R_rxd_d1            ;
reg                             R_rxd_d2            ;
wire                            S_rx_start          ;
//tx,rx fifo
reg                             R_tx_rdreq          ;
reg                             R_tx_rdreq_d0       ;
reg                             R_rx_wrreq          ;
wire                            S_tx_rdempty        ;
wire                            S_rx_wrfull         ;

wire    [7 : 0]                 S_tx_data           ;
reg     [7 : 0]                 R_rx_data           ;
            
reg     [7 : 0]                 R_tx_data_reg       ;
reg     [7 : 0]                 R_rx_data_reg       ;
//=========================================================================
localparam      RX_IDLE     = 3'b000;
localparam      RX_DOING    = 3'b001;
localparam      RX_DONE     = 3'b011;

localparam      TX_IDLE     = 3'b000;
localparam      TX_DOING_PRE= 3'b001;
localparam      TX_DOING    = 3'b011;
localparam      TX_DONE_PRE = 3'b010;
localparam      TX_DONE     = 3'b110;
//=========================================================================


always@(posedge I_sys_clk)
begin
    R_rxd_d0    <= I_usb_uart_rxd   ;
    R_rxd_d1    <= R_rxd_d0         ;
    R_rxd_d2    <= R_rxd_d1         ;
end





assign  S_rx_start = (!R_rxd_d1 & R_rxd_d2) ? 1'b1 : 1'b0;       // fall  edge 



always@(posedge I_sys_clk)
begin
    if(I_usb_rst)
        begin
            R_tx_bd_cnt         <= 16'd0;
            R_rx_bd_cnt         <= 16'd0;
            R_tx_bd_pulse       <= 1'd0 ;
            R_rx_bd_pulse       <= 1'd0 ;
            R_rx_busy           <= 1'd0 ;
        end
    else
        begin
		  
            //====rx baudrate========================================
				
            if((S_rx_start == 1'b1)&&(R_rx_state == RX_IDLE))
                begin
                    R_rx_bd_cnt     <= 16'd3;
                end
            else if(R_rx_bd_cnt >= R_bddiv_reg)
                begin
                    R_rx_bd_cnt     <= 16'd0;
                end
            else
                begin
                    R_rx_bd_cnt     <= R_rx_bd_cnt + 16'd1;
                end
                
            //
            if((S_rx_start == 1'b1)&&(R_rx_state == RX_IDLE))
                begin
                    R_rx_busy       <= 1'd1 ;
                end
            else if((R_rx_bd_pulse == 1'b1)&&(R_rx_state == RX_DONE))
                begin
                    R_rx_busy       <= 1'd0 ;
                end
                
            //
            if((R_rx_busy == 1'b1)&&(R_rx_bd_cnt == R_bddiv_reg[15:1]))
                begin
                    R_rx_bd_pulse   <= 1'b1;
                end
            else
                begin
                    R_rx_bd_pulse   <= 1'b0;
                end
					 
            //=====tx baudrate================================================== 
				
            if(R_tx_bd_cnt >= R_bddiv_reg)
                begin
                    R_tx_bd_cnt     <= 16'd0;
                end
            else
                begin
                    R_tx_bd_cnt     <= R_tx_bd_cnt + 16'd1;
                end
            
            //
            if(R_tx_bd_cnt == R_bddiv_reg[15:1])
                begin
                    R_tx_bd_pulse   <= 1'b1;
                end
            else
                begin
                    R_tx_bd_pulse   <= 1'b0;
                end
        end
end




//============================================================================================================

//rx state


always@(posedge I_sys_clk)
begin
    if(I_usb_rst)
        begin
            R_rx_state      <= RX_IDLE              ;
            R_rx_wrreq      <= 1'b0                 ;
            R_rx_data       <= 8'd0                 ;
            R_rx_data_reg   <= 8'd0                 ;
            R_rx_bit_index  <= 7'd0  ;
        end
    else
        begin
            case(R_rx_state)
                RX_IDLE:
                    begin
                        if(R_rx_bd_pulse == 1'd1)
                            begin
                                R_rx_state      <= RX_DOING             ;
                                R_rx_wrreq      <= 1'b0                 ;
                            end
                        else
                            begin
                                R_rx_state      <= RX_IDLE              ;
                                R_rx_wrreq      <= 1'b0                 ;
                                R_rx_data       <= 8'd0                 ;
                                R_rx_data_reg   <= 8'd0                 ;
                                R_rx_bit_index  <= 7'd0  ;
                            end
                    end
                RX_DOING:
                    begin
                        if(R_rx_bd_pulse == 1'b1)
                            begin
                                if(R_rx_bit_index < 7'd8)
                                    begin
                                        R_rx_data_reg   <= {R_rxd_d2,R_rx_data_reg[7:1]};
                                        R_rx_bit_index  <= R_rx_bit_index + 7'd1;
                                        R_rx_state      <= RX_DOING;
                                    end
                                else
                                    begin
                                        R_rx_bit_index  <= 7'd0  ;
                                        R_rx_state      <= RX_DONE              ;
                                    end
                            end
                        else
                            begin
                                R_rx_state      <= RX_DOING         ;
                            end
                    end
                RX_DONE:
                    begin
                        if(R_rx_bd_pulse == 1'b1)
                            begin
                                R_rx_state      <= RX_IDLE         ;
                                //
                                if(S_rx_wrfull == 1'b0)
                                    begin
                                        R_rx_wrreq  <= 1'b1;
                                        R_rx_data   <= R_rx_data_reg;
                                    end
                            end
                    end
                default: R_rx_state      <= RX_IDLE;
            endcase
        end
end



//tx state


always@(posedge I_sys_clk)
begin
    if(I_usb_rst)
        begin
            R_tx_state      <= TX_IDLE              ;
            R_txd           <= 1'b1                 ;
            R_tx_rdreq      <= 1'b0                 ;
            R_tx_rdreq_d0   <= 1'b0                 ;
            R_tx_data_reg   <= 8'd0                 ;
            R_tx_bit_index  <= 7'd0  ;
        end
    else
        begin
            case(R_tx_state)
                TX_IDLE:
                    begin
                        if((R_tx_bd_pulse == 1'b1) && (S_tx_rdempty == 1'b0))
                            begin
                                
                                R_tx_rdreq  <= 1'b1;
                            end
                        else
                            begin
                                R_tx_rdreq      <= 1'b0;
                                R_tx_rdreq_d0   <= R_tx_rdreq   ;
                            end
                        //
                        if(R_tx_rdreq_d0 == 1'b1)
                            begin
                                R_tx_state      <= TX_DOING_PRE         ;
                                R_tx_data_reg   <= S_tx_data            ;
                            end
                        else
                            begin
                                R_tx_state      <= TX_IDLE              ;
                                R_txd           <= 1'b1                 ;
                                R_tx_data_reg   <= 8'd0                 ;
                                R_tx_bit_index  <= 7'd0                 ;
                            end
                    end
               TX_DOING_PRE:
                    begin
                        if(R_tx_bd_pulse == 1'b1)
                            begin
                                R_txd       <= 1'b0         ;
                                R_tx_state  <= TX_DOING     ;
                            end
                        else
                            begin
                                R_tx_state  <= TX_DOING_PRE ;
                            end
                    end
                TX_DOING:
                    begin
                        if(R_tx_bd_pulse == 1'b1)
                            begin
                                if(R_tx_bit_index < 7'd8)
                                    begin
                                        R_txd           <= R_tx_data_reg[0];
                                        R_tx_data_reg   <= {1'b0,R_tx_data_reg[7:1]};
                                        R_tx_bit_index  <= R_tx_bit_index + 7'd1;
                                        R_tx_state      <= TX_DOING;
                                    end
                                else
                                    begin
                                        R_tx_bit_index  <= 7'd0  ;
                                        R_tx_state      <= TX_DONE_PRE          ;
                                    end
                            end
                        else
                            begin
                                R_tx_state      <= TX_DOING         ;
                            end
                    end
                TX_DONE_PRE:
                    begin
                        if(R_tx_bd_pulse == 1'b1)
                            begin
                                R_txd           <= 1'b1     ;
                                R_tx_state      <= TX_DONE  ;
                            end
                        else
                            begin
                                R_tx_state      <= TX_DONE_PRE  ;
                            end
                    end
                TX_DONE:
                    begin
                        if(R_tx_bd_pulse == 1'b1)
                            begin
                                R_tx_state      <= TX_IDLE  ;
                            end
                        else
                            begin
                                R_tx_state      <= TX_DONE  ;
                            end
                    end
            
            endcase
        end
end


//======================================================================================


uart_fifo_64x128 uart_tx_fifo_inst(
	.aclr       (I_sys_rst              ),
	.data       (I_usb_uart_tx_data     ),
	.rdclk      (I_sys_clk              ),
	.rdreq      (R_tx_rdreq             ),
	.wrclk      (I_sys_clk              ),
	.wrreq      (I_usb_uart_tx_req      ),
	.q          (S_tx_data              ),
	.rdempty    (S_tx_rdempty), 
	.wrfull     (O_usb_uart_tx_full     )
);



    
	 
	 
	 
	 
uart_fifo_64x128 uart_rx_fifo_inst(
	.aclr       (I_usb_rst              ),
	.data       (R_rx_data              ),
	.rdclk      (I_sys_clk              ),
	.rdreq      (I_usb_uart_rx_req      ),
	.wrclk      (I_sys_clk              ),
	.wrreq      (R_rx_wrreq             ),
	.q          (O_usb_uart_rx_data     ),
	.rdempty    (O_usb_uart_rx_empty    ),
	.wrfull     (S_rx_wrfull            )
);


//==========================================================================================


assign O_usb_uart_txd  = R_txd;





endmodule