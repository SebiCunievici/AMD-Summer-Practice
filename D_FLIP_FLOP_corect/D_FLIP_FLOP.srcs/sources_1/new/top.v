module D_FLIP_FLOP(clk, din, res, out);

input clk, din, res;
output reg out;

always @(posedge clk)
    if(res)
        out = 1'b0;
    else 
        out = din;

endmodule

module MUX21(A, B, SEL, O);

input A, B, SEL;
output O;

assign O = (SEL) ? B : A;

endmodule