module SUM4(in, out);

    input [31:0] in;
    output reg [31:0] out;

    always @(in)
        out = in + 3'b100; 

endmodule

module MUX2_1 #(parameter N = 32) (A, B, sel, out);

    input [N-1:0] A, B;
    input sel;
    output reg [N-1:0] out;
    
    always @(A, B, sel)
        case(sel)
            1'b0 : out = A;
            1'b1 : out = B;
        endcase

endmodule

module EXT_SIGN(in, EXTOP, out);

    input EXTOP;
    input [15:0] in;
    output reg [31:0] out;

    always @(in, EXTOP)
       out = {{16{EXTOP}}, in};
            
endmodule