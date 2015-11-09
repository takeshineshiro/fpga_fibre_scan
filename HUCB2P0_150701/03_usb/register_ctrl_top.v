module register_ctrl_top(
    input                             I_sys_clk           , 
    input                             I_sys_rst           ,
    //=====================System usb_uart_if=========================== 
    output                            O_usb_uart_tx_req   ,
    output   [7 : 0]                  O_usb_uart_tx_data  ,
    input                             I_usb_uart_tx_full  ,
    
    output                            O_usb_uart_rx_req   ,
    input    [7 : 0]                  I_usb_uart_rx_data  ,
    input                             I_usb_uart_rx_empty ,    
    //==================================================================
    output                            O_usb_dir           ,
	 
    output                            O_motor_start       ,
    
    output                            tp                  ,
	 
    input                             I_key_start
);
//=======================================================================
reg                                   R_usb_uart_rx_req     ;
reg                                   R_usb_uart_rx_req_d1  ;

reg                                   R_tx_en       ;
reg          [7 : 0]                  R_tx_data     ;

reg                                   R_rx_en       ;
reg          [7 : 0]                  R_rx_data     ;

reg                                   R_usb_dir     ;

reg                                   R_motor_start ;

//=======================================================================

always@(posedge I_sys_clk)
begin
    if(I_sys_rst)
        begin
            R_usb_uart_rx_req     <= 1'd0     ;
        end
    else if(I_usb_uart_rx_empty == 1'b0)       //   if  has data .then  read 
        begin
            R_usb_uart_rx_req     <= 1'd1     ;
        end
    else
        begin
            R_usb_uart_rx_req     <= 1'd0     ;
        end
        
    //
    R_usb_uart_rx_req_d1          <= R_usb_uart_rx_req;
end




always@(posedge I_sys_clk)
begin
    if(I_sys_rst)
        begin
            R_rx_en       <= 1'd0   ;
            R_rx_data     <= 8'd0  ;
        end
    else if(R_usb_uart_rx_req_d1 == 1'b1)
        begin
            R_rx_en       <= 1'd1   ;
            R_rx_data     <= I_usb_uart_rx_data  ;
        end
    else
        begin
            R_rx_en       <= 1'd0   ;
        end
end





always@(posedge I_sys_clk)
begin
    if(I_sys_rst)
        begin
            R_tx_en       <= 1'd0   ;
            R_tx_data     <= 8'd0  ;
        end
    else if(I_usb_uart_tx_full==1'b0)           // not  full 
        begin
            if(I_key_start==1'b1)
                begin
                    R_tx_en       <= 1'b1  ;//R_rx_en;
                    R_tx_data     <= 8'h55 ;//R_rx_data;
                end
            else
                begin
                    R_tx_en       <= 1'b0  ;//R_rx_en;
                end
        end
    else
        begin
            R_tx_en       <= 1'b0  ;
        end
end 


 


always@(posedge I_sys_clk)
begin
    if(I_sys_rst)
        begin
            R_usb_dir       <= 1'd0;                    //目前采用了默认值
            R_motor_start   <= 1'b0;
        end
    else if(R_rx_en)
        begin
            case(R_rx_data)
                8'h00:
                    begin
                        R_usb_dir       <= 1'b0;      //wr TO USB 
                    end
                8'hff:
                    begin
                        R_usb_dir       <= 1'b1;     // rd  FROM  USB 
                    end
                8'h02:
                    begin
                        R_motor_start   <= 1'b1;    //  motor  
                    end
            endcase
        end
    else
        begin
            R_motor_start   <= 1'b0;
        end
        
end




assign O_usb_uart_rx_req   = R_usb_uart_rx_req;

assign O_usb_uart_tx_req   = R_tx_en  ;

assign O_usb_uart_tx_data  = R_tx_data;

assign O_usb_dir           = R_usb_dir  ;

assign O_motor_start       = R_motor_start;

assign  tp                 = R_rx_en & (&R_rx_data) & O_motor_start & O_usb_dir;




endmodule