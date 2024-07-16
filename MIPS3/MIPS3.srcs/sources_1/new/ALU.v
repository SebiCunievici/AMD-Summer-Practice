module ALU(A, B, OP, ZERO, out);

input [31:0] A, B;
input [3:0] OP;
output reg ZERO;
output reg [31:0] out;

always @(A, B, OP)
    case(OP)
        4'b0000 : begin // AND
            out = A & B;
            ZERO = (out) ? 0 : 1;
        end
        4'b0001 : begin // OR
            out = A | B;
            ZERO = (out) ? 0 : 1;
        end
        4'b0010 : begin // ADD
            out = A + B;
            ZERO = (out) ? 0 : 1;
        end
        4'b0110 : begin // SUB
            out = A - B;
            ZERO = (out) ? 0 : 1;
        end
        4'b0111 : begin // SLT
            out = A < B;
            ZERO = (out) ? 0 : 1;
        end
        4'b1100 : begin // NOR
            out = ~(A | B);
            ZERO = (out) ? 0 : 1;
        end
        
    endcase

endmodule
