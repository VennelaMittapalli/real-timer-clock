module real_timer_top(input RST, CLK, output reg [6:0] HRM, HRL, MIN_M, MIN_L, SEC_M, SEC_L);

	wire [3:0] HRM1,HRL1,MIN_M1,MIN_L1,SEC_M1,SEC_L1;

	real_timer realt(RST,CLK,HRM1,HRL1,MIN_M1,MIN_L1,SEC_M1,SEC_L1);
	seven_segment sseg1(HRM1,HRM);
	seven_segment sseg2(HRL1,HRL);
	seven_segment sseg3(MIN_M1,MIN_M);
	seven_segment sseg4(MIN_L1,MIN_L);
	seven_segment sseg5(SEC_M1,SEC_M);
	seven_segment sseg6(SEC_L1,SEC_L);

endmodule
