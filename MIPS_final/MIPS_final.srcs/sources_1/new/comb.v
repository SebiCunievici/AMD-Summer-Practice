module SUM(A, B, out);

    input [31:0] A, B;
    output reg [31:0] out;

    always @(A, B)
        out = A + B; 

endmodule

module SHIFT_REG(A, B, out);

    input [31:0] A, B;
    output reg [31:0] out;
    
    always @(A, B)
        out = A << B;

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
       out = {{16{in[15]}}, in};
            
endmodule