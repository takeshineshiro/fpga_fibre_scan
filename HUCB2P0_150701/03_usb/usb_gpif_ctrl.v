module usb_gpif_ctrl(
    input                   I_sys_clk           ,
	 
    input                   I_usb_clk           ,
        
    input                   I_sys_rst           ,
	 
    input                   I_usb_rst           ,
    //===================System GPIF data in/out====================
    input                   I_usb_wfifo_aclr    ,
    
    input                   I_usb_wrreq         ,
    input   [15: 0]         I_usb_din           ,
    output                  O_usb_wrfull        ,
    output  [12: 0]         O_usb_wruesdw       ,
        
    input                   I_usb_rdreq         ,
    output  [31: 0]         O_usb_dout          ,
    output                  O_usb_rdempty       ,
	 
    //==================USB3.0 IO=======================================
    output                  O_usb_pclk          ,
    output                  O_usb_clk           ,
            
    input                   I_usb_flga          ,
    input                   I_usb_flgb          ,
            
    output                  O_usb_cs            , 
    output                  O_usb_wr            , 
    output                  O_usb_rd            , 
    output                  O_usb_oe            , 
    output                  O_usb_a0            , 
    output                  O_usb_a1            , 
    output                  O_usb_pkt           , 
    output                  O_usb_reset         , 
                                                  
    inout  [31:0]           IO_usb_dq           ,
    
    input                   I_usb_dir
	 
);
//======================================================================
wire	[31: 0]		  S_usb_din			;
wire	[31: 0]		  S_usb_dout		;
reg                 R_usb_flga      ;
reg                 R_usb_flgb      ;

reg                 R_usb_cs        ; 
reg                 R_usb_wr        ; 
reg                 R_usb_rd        ; 
reg                 R_usb_oe        ; 
reg   [1 : 0]       R_usb_a         ;  
reg                 R_usb_pkt       ;

reg                 R_usb_cs_d0     ; 
reg                 R_usb_wr_d0     ; 
reg                 R_usb_rd_d0     ; 
reg                 R_usb_oe_d0     ; 
reg   [1 : 0]       R_usb_a_d0      ;  
reg                 R_usb_pkt_d0    ;

reg                 R_usb_cs_d1     ; 
reg                 R_usb_wr_d1     ; 
reg                 R_usb_rd_d1     ; 
reg                 R_usb_oe_d1     ; 
reg   [1 : 0]       R_usb_a_d1      ;  
reg                 R_usb_pkt_d1    ;


reg   [3 : 0]       R_usb_wr_state  ;
reg   [3 : 0]       R_usb_rd_state  ;

reg   [7 : 0]       R_usb_wr_cnt    ;
reg   [7 : 0]       R_usb_rd_cnt    ;

reg                 R_usb_rd_d2     ;
reg                 R_usb_rd_d3     ;

wire                S_wr_fifo_rdreq    ;
wire  [31: 0]       S_wr_fifo_dout     ;
reg   [31: 0]       R_wr_fifo_dout     ;
wire                S_wr_fifo_rdempty  ;
wire                S_wr_fifo_rdfull   ;
wire  [11: 0]       S_wr_fifo_rduesdw  ;

reg                 R_rd_fifo_wrreq    ;
wire                S_rd_fifo_wrreq    ;
reg   [31: 0]       R_rd_fifo_din      ;

reg   [31: 0]       R_usb_dq           ;
wire  [31: 0]       S_usb_dq           ;

//======================================================================


usb_wr_fifo_32x512 usb_wr_fifo_inst(
            .aclr           (I_usb_wfifo_aclr   ),
            .data           (I_usb_din          ),
            .rdclk          (I_usb_clk          ),
            .rdreq          (S_wr_fifo_rdreq&&(!S_wr_fifo_rdempty)),
            .wrclk          (I_sys_clk          ),
            .wrreq          (I_usb_wrreq        ),
            .q              (S_wr_fifo_dout     ),
            .rdempty        (S_wr_fifo_rdempty  ),
            .rdfull         (S_wr_fifo_rdfull   ),
            .rdusedw        (S_wr_fifo_rduesdw  ),
            .wrfull         (O_usb_wrfull       ),
            .wrusedw        (O_usb_wruesdw      )
        );
		  
		  
		  
		  
		  
		  
        
usb_rd_fifo_32x512 usb_rd_fifo_inst(
            .aclr           (I_usb_rst          ),
            .data           (R_rd_fifo_din      ),
            .rdclk          (I_sys_clk          ),
            .rdreq          (I_usb_rdreq        ),
            .wrclk          (I_usb_clk          ),
            .wrreq          (S_rd_fifo_wrreq    ),
            .q              (O_usb_dout         ),
            .rdempty        (O_usb_rdempty      ),
            .wrfull         ()
        );
//======================================================================


always@(posedge I_usb_clk or posedge I_usb_rst)
begin
     if (I_usb_rst)
		 
		   begin
			        R_usb_flga   <=      1'b0 ;
			        R_usb_flgb   <=      1'b0 ;
			end
       else
		    begin
                 R_usb_flga   <=     I_usb_flga;				  
                 R_usb_flgb   <=     I_usb_flgb;
			 end

end



always@(posedge I_usb_clk  or  posedge  I_usb_rst )
begin
    if(I_usb_rst)
        begin
            R_usb_cs            <= 1'b1; 
            R_usb_wr            <= 1'b1; 
            R_usb_rd            <= 1'b1; 
            R_usb_oe            <= 1'b1; 
            R_usb_a             <= 2'b0;  
            R_usb_pkt           <= 1'b1;

            R_usb_wr_state      <= 4'd0;
				
            R_usb_rd_state      <= 4'd0;
            
            R_usb_wr_cnt        <= 8'd0;
          
        end
    else if(I_usb_dir==1'b0)//DATA_DIR->0->EXT TO USB     //wr
        begin
            R_usb_rd_state      <= 4'd0;
            R_usb_oe            <= 1'b1;
            R_usb_rd            <= 1'b1; 
            //R_usb_rd_cnt        <= 4'd0;
            R_usb_a             <= 2'b00;
            //
            case(R_usb_wr_state)
                4'd0:
                    begin
                        R_usb_wr_state      <= 4'd1;
                    end
                4'd1:
                    begin
                        R_usb_wr_state      <= 4'd2;
                    end
                4'd2:
                    begin
                        R_usb_wr_state      <= 4'd3;
                    end    
                4'd3:
                    begin
                        R_usb_wr_state      <= 4'd4;
                    end
                4'd4:
                    begin
                        if(((S_wr_fifo_rduesdw>=12'd256)||(S_wr_fifo_rdfull==1'b1))&&(R_usb_flgb==1'b1))      //>512
                            begin
                                R_usb_wr_state      <= 4'd5;
                                R_usb_cs            <= 1'd0; 
                            end
                        else
                            begin
                                R_usb_wr_state      <= 4'd4;
                            end
                    end
                4'd5:
                    begin
                        if(R_usb_flgb==1'b1)
                            begin
                                R_usb_wr    <= 1'b0;
                                //
                                if(R_usb_wr_cnt<8'd255)
                                    begin
                                        R_usb_wr_cnt    <= R_usb_wr_cnt + 8'd1;
                                        R_usb_wr_state  <= 4'd5;
                                    end
                                else
                                    begin
                                        R_usb_pkt       <= 1'b0;
                                        R_usb_wr_cnt    <= 8'd0;
                                        R_usb_wr_state  <= 4'd6;
                                    end
                            end
                        else
                            begin
                                R_usb_wr        <= 1'b1;
                                R_usb_wr_state  <= 4'd5;
                            end
                    end
                4'd6:
                    begin
                        R_usb_wr        <= 1'b1;
                        R_usb_pkt       <= 1'b1;
                        R_usb_wr_state  <= 4'd7;
                    end
                4'd7:
                    begin
                        R_usb_cs        <= 1'd1;
                        R_usb_wr_state  <= 4'd0;
                    end
                default: R_usb_wr_state <= 4'd0;
            endcase
        end
    else //DATA_DIR->1->USB TO EXT          //rd
        begin
            R_usb_wr_state      <= 4'd0;
            R_usb_wr            <= 1'b1;
            R_usb_wr_cnt        <= 4'd0;
            R_usb_a             <= 2'b11;
            //
            case(R_usb_rd_state)
                4'd0:
                    begin
                        if(R_usb_flga==1'b1)
                            begin
                                R_usb_rd_state      <= 4'd1;
                            end
                        else
                            begin
                                R_usb_rd_state      <= 4'd0;
                            end
                    end
                4'd1:
                    begin
                        R_usb_cs        <= 1'd0;
                        R_usb_rd_state  <= 4'd2;
                    end
                4'd2:
                    begin
                        R_usb_oe        <= 1'd0;
                        R_usb_rd_state  <= 4'd3;
                    end
                4'd3:
                    begin
                        R_usb_rd        <= 1'b0;
                        R_usb_rd_state  <= 4'd4;
                    end
                4'd4:
                    begin
                        if(R_usb_flga==1'b0)
                            begin
                                R_usb_rd        <= 1'b1;
                                R_usb_rd_state  <= 4'd5;
                            end
                        else
                            begin
                                R_usb_rd_state  <= 4'd4;
                            end
                    end
                4'd5:
                    begin
                        R_usb_oe        <= 1'd1;
                        R_usb_rd_state  <= 4'd6;
                    end
                4'd6:
                    begin
                        R_usb_cs        <= 1'd1;
                        R_usb_rd_state  <= 4'd0;
                    end
                default: R_usb_rd_state  <= 4'd0;
            endcase
        end
end


always@(posedge I_usb_clk)
begin
    R_usb_cs_d0     <= R_usb_cs    ;
    R_usb_wr_d0     <= R_usb_wr    ;
    R_usb_rd_d0     <= R_usb_rd    ;
    R_usb_oe_d0     <= R_usb_oe    ;
    R_usb_a_d0      <= R_usb_a     ;
    R_usb_pkt_d0    <= R_usb_pkt   ;

    R_usb_cs_d1     <= R_usb_cs_d0 ;
    R_usb_wr_d1     <= R_usb_wr_d0 ;
    R_usb_rd_d1     <= R_usb_rd_d0 ;
    R_usb_oe_d1     <= R_usb_oe_d0 ;
    R_usb_a_d1      <= R_usb_a_d0  ;
    R_usb_pkt_d1    <= R_usb_pkt_d0;   
end




always@(posedge I_usb_clk)
begin
    R_usb_rd_d2     <= R_usb_rd_d1;
    R_usb_rd_d3     <= R_usb_rd_d2;
end



always@(posedge I_usb_clk)
begin
    if(R_usb_rd_d3==1'b0)
        begin
            R_rd_fifo_din   <= S_usb_din;
            R_rd_fifo_wrreq <= 1'b1;
        end
    else
        begin
            R_rd_fifo_din   <= R_rd_fifo_din;
            R_rd_fifo_wrreq <= 1'b0;
        end
end







assign S_rd_fifo_wrreq  = R_rd_fifo_wrreq & R_usb_flga;

assign S_wr_fifo_rdreq  = ~R_usb_wr;



assign S_usb_dq         = R_usb_oe_d0 ? S_usb_dout : 32'hz;



always@(posedge I_usb_clk)
begin
    R_usb_dq    <= S_usb_dq;
end

assign S_usb_dout		   = S_wr_fifo_dout;

assign IO_usb_dq        = R_usb_dq;

assign S_usb_din        = IO_usb_dq;

assign O_usb_reset      = ~I_usb_rst;




assign O_usb_cs         = R_usb_cs_d1      ;

assign O_usb_wr         = R_usb_wr_d1      ;

assign O_usb_rd         = R_usb_rd_d1      ;

assign O_usb_oe         = R_usb_oe_d1      ;

assign O_usb_a0         = R_usb_a_d1[0]    ;

assign O_usb_a1         = R_usb_a_d1[1]    ;

assign O_usb_pkt        = 1'b1             ;





endmodule