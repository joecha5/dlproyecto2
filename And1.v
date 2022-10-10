module And1(clk, rst, Q1, Q2);
	input clk, rst;
	output Q1, Q2;


	 wire [18:0] Cout;
	 
 Cont Refresh(clk, rst, Cout);


 assign an1=(Cout==1),
			an1=(Cout==0),
			an12=(Cout==120000),
			an2=(Cout==240000),
			an21=(Cout==360000);
 
 
 FFT FFTX(clk, rst, {an1 | an12}, Q1);

 
 FFT FFTY(clk, rst, {an2 | an21}, Q2);
 


endmodule
