module real_timer_top(RST,CLK,DIS0,DIS1,an0,an1);


    reg [23:0]Tclk=24'd0;
    reg Tclk1;
    
   
    
    
    output [6:0]DIS0,DIS1;
    output reg [3:0]an0,an1;
    input RST,CLK;
    
	wire [3:0] HRM1,HRL1,MIN_M1,MIN_L1,SEC_M1,SEC_L1;

 
	reg [3:0]nibble1,nibble0;
	reg [1:0]count=2'b00;
   always @(posedge CLK) begin
    if(RST) Tclk <= 24'd0;
    else Tclk <= Tclk + 24'd1;
    end
    
    always @(posedge Tclk[22]) begin
    if(RST) Tclk1 <= 24'd0;
    else Tclk1 <= ~Tclk1;
    end
 
  always @(posedge Tclk1)
	count <= count+1;
  
  real_timer realt(RST,Tclk1,HRM1,HRL1,MIN_M1,MIN_L1,SEC_M1,SEC_L1);
	
	always @(*) begin
	case(count)
	2'b00:an0={1'b1,1'b1,1'b1,1'b0};
	2'b01:an0={1'b1,1'b1,1'b0,1'b1};
	2'b10:an0={1'b1,1'b0,1'b1,1'b1};
	2'b11:an0={1'b0,1'b1,1'b1,1'b1};
	endcase
	end
	
  always @(*) begin
	case(count[0])
	1'b0: an1={1'b1,1'b0,1'b1,1'b1};
	1'b1: an1={1'b0,1'b1,1'b1,1'b1};
	endcase
	end
	
	//assign nibble0=(count[1]?(count[0]?MIN_M1:MIN_L1):(count[0]?SEC_M1:SEC_L1));
	
  always @(*) begin
	case(count)
	2'b00:nibble0=MIN_M1;
	2'b01:nibble0=MIN_L1;
	2'b10:nibble0=SEC_M1;
	2'b11:nibble0=SEC_L1;
	endcase
	end
	
	//assign nibble1=count[0]?HRM1:HRL1;
  always @(*) begin
	case(count[0])
	1'b0: nibble1=HRM1;
	1'b1: nibble1=HRL1;
	endcase
	end
	
	seven_segment sseg1(nibble0,DIS0);
	seven_segment sseg2(nibble1,DIS1);
	//seven_segment sseg3(MIN_M1,MIN_M);
	//seven_segment sseg4(MIN_L1,MIN_L);
	//seven_segment sseg5(SEC_M1,SEC_M);
	//seven_segment sseg6(SEC_L1,SEC_L);

endmodule
