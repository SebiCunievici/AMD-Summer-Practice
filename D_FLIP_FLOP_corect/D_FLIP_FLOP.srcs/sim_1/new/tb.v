module tb;

reg clk, res, din0, din1, din2, din3, SEL;
wire out0, out1, out2, out3, MUX_OUT0, MUX_OUT1, MUX_OUT2, MUX_OUT3;
reg [2:0] OUT_FLAG;

MUX21 MUX_inst_0(1'bx, din0, SEL, MUX_OUT0);
MUX21 MUX_inst_1(out0, din1, SEL, MUX_OUT1);
MUX21 MUX_inst_2(out1, din2, SEL, MUX_OUT2);
MUX21 MUX_inst_3(out2, din3, SEL, MUX_OUT3);

//PIPO
//D_FLIP_FLOP D0(clk, din0, res, out0);
//D_FLIP_FLOP D1(clk, din1, res, out1);
//D_FLIP_FLOP D2(clk, din2, res, out2);
//D_FLIP_FLOP D3(clk, din3, res, out3);  

//SISO SIPO?
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

    #0 res = 1; SEL = 1; OUT_FLAG = 0; //PI
    
    #10 res = 0; din0 = 1'b1; din1 = 1'b0; din2 = 1'b0; din3 = 1'b1; OUT_FLAG = 1;
    
    forever #10 begin
        SEL = 0; // SO
        if(OUT_FLAG == 4)  begin
            OUT_FLAG = 0;
            #10;
            $finish;
        end
        
        OUT_FLAG = OUT_FLAG + 1;
    end
    
    //#50 $finish;

end

endmodule