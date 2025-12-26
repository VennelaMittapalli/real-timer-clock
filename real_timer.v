//FORMAT of the Timer is 24 hours


module real_timer(input RST, CLK, output reg [3:0] HRM, HRL, MIN_M, MIN_L, SEC_M, SEC_L);
	always @(posedge CLK or posedge RST) begin
      if(RST) {HRM,HRL,MIN_M,MIN_L,SEC_M,SEC_L} <= 24'h000000;
      else if((SEC_L == 9) & (SEC_M != 5)) begin
        	SEC_M <= SEC_M + 1;
        	SEC_L <= 0;
      end
      
      else if(({SEC_M,SEC_L} == 8'h59) & ({MIN_M,MIN_L} != 8'h59) ) begin
			{MIN_M,MIN_L} <= {MIN_M,MIN_L} + 1;
			{SEC_M,SEC_L} <= 0;
		end
      
      else if({MIN_L == 9} & (MIN_M != 5)) begin
        MIN_M <= MIN_M + 1;
        MIN_L <= 0;
      end
      
      else if(({MIN_M,MIN_L} == 8'h59) & ({SEC_M,SEC_L} == 8'h59) & ({HRM,HRL} != 8'h23)) begin
			{HRM,HRL} <= {HRM,HRL} + 1;
            {MIN_M,MIN_L,SEC_M,SEC_L} <= 16'h0000;
	  end
      else if(({HRM,HRL} == 8'h23) & ({MIN_M,MIN_L} == 8'h59) & ({SEC_M,SEC_L} == 8'h59)) begin
        {HRM,HRL,MIN_M,MIN_L,SEC_M,SEC_L} <= 24'h000000;
		end
		else
			{SEC_M,SEC_L} <= {SEC_M,SEC_L} + 1;
		end
  

endmodule

