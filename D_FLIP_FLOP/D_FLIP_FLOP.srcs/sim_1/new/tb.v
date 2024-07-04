module tb;

reg clk, res, din0, din1, din2, din3, SEL0, SEL1, SEL2, SEL3;
wire out0, out1, out2, out3, MUX_OUT0, MUX_OUT1, MUX_OUT2, MUX_OUT3;

MUX21 MUX_inst_0(1'b1, din0, SEL0, MUX_OUT0);
MUX21 MUX_inst_1(out0, din1, SEL1, MUX_OUT1);
MUX21 MUX_inst_2(out1, din2, SEL2, MUX_OUT2);
MUX21 MUX_inst_3(out2, din3, SEL3, MUX_OUT3);

//PIPO
//D_FLIP_FLOP D0(clk, din0, res, out0);
//D_FLIP_FLOP D1(clk, din1, res, out1);
//D_FLIP_FLOP D2(clk, din2, res, out2);
//D_FLIP_FLOP D3(clk, din3, res, out3);  

//SISO
//D_FLIP_FLOP D0(clk, din0, res, out0);
//D_FLIP_FLOP D1(clk, out0, res, out1);
//D_FLIP_FLOP D2(clk, out1, res, out2);
//D_FLIP_FLOP D3(clk, out2, res, out3);

//PISO
D_FLIP_FLOP D0(clk, MUX_OUT0, res, out0);
D_FLIP_FLOP D1(clk, MUX_OUT1, res, out1);
D_FLIP_FLOP D2(clk, MUX_OUT2, res, out2);
D_FLIP_FLOP D3(clk, MUX_OUT3, res, out3);



initial begin
    #0 clk = 1;
    forever #5 clk = ~clk;
end

initial begin

    #0 res = 1; SEL0 = 1; SEL1 = 0; SEL2 = 0; SEL3 = 0; 
    
    #10 res = 0; din0 = 1'b1;
    
    #10 din0 = 1'b0; din3 = 1'b0; SEL3 = 1;
    
    #40 $finish;

end

endmodule