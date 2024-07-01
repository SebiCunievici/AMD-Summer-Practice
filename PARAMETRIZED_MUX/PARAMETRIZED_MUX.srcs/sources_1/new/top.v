module MUX_CASE #(parameter N = 8) (A, B, SEL, O);

    input [N-1:0] A, B;
    input SEL;
    output reg [N-1:0] O;
    
    always @(A, B, SEL)
        case(SEL)
            1'b0 : O = A;
            1'b1 : O = B;
        endcase

endmodule

module MUX_GATE #(parameter N = 8) (A, B, SEL, O);

    input [N-1:0] A, B;
    input SEL;
    output [N-1:0] O;
    
    assign O = (SEL) ? B : A;

endmodule