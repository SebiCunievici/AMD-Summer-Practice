module top(in, BT, clk, pl_bt, COUT, AOUT);

    input clk, pl_bt;
    input [11:0] in;
    input [2:0] BT;
    output [6:0] COUT;
    output [3:0] AOUT; 
    wire [1:0] CNT_OUT, DEBUG_CMD;
    wire [11:0] MUX_ALU_OUT;
    wire [11:0] REG_A_OUT, REG_B_OUT, REG_OP_OUT, ALU_OUT;
    wire clk_div, ERR, OF, UF, ZERO; // 8 - OF   E - ERR    2 - ZERO    U - UF   0 - OK
    
    FREQ_DIV FREQ_DIV_inst(clk, clk_div);
    
    CNT CNT_inst(clk_div, CNT_OUT);
    DIG_DEC DIG_DEC_inst(MUX_OUT_7SEG, COUT);
    DEC2_4 DEC2_4_inst(CNT_OUT, AOUT);
    
    
    REG #(12) REG_A(in, pl_bt, REG_A_OUT);
    REG #(12) REG_B(in, pl_bt, REG_B_OUT);
    REG #(4) REG_OP(in[3:0], pl_bt, REG_OP_OUT);
    
    ALU #(12) ALU_inst(REG_A_OUT, REG_B_OUT, REG_OP_OUT, ALU_OUT, ERR, OF, UF, ZERO);
    
    DEC_BT DEC_BT_inst(BT, DEBUG_CMD);
    
    MUX4_1 #(12) MUX_ALU(ALU_OUT, REG_A_OUT, REG_B_OUT, REG_OP_OUT, DEBUG_CMD, MUX_ALU_OUT);
    
    DEC_ERRF DEC_ERRG_inst(ERR, OF, UF, ZERO, ERRF_OUT);
    
    MUX4_1 #(4) MUX_inst_7SEGMENT(ERRF_OUT, MUX_ALU_OUT[11:8], MUX_ALU_OUT[7:4], MUX_ALU_OUT[3:0], CNT_OUT, MUX_OUT_7SEG);
    
    

endmodule

module DEC_BT(BT, OUT);

    input [2:0] BT;
    output reg [1:0] OUT;

    always @(BT)
        case(BT)
            3'b000 : OUT = 2'b00;
            3'b001 : OUT = 2'b01;
            3'b010 : OUT = 2'b10;
            3'b100 : OUT = 2'b11;
        endcase

endmodule

module DEC_ERRF(ERR, OF, UF, ZERO, OUT);

    input ERR, OF, UF, ZERO;
    output reg [3:0] OUT;
    
    always @(ERR, OF, UF, ZERO)
        casex({ERR, OF, UF, ZERO})
            4'b1xxx : OUT = 14; // ERR - E
            4'b01xx : OUT = 8; // OF - 8
            4'b001x : OUT = 4'bx; // UF - U
            4'b0001 : OUT = 2; // ZERO - 2
            4'b0000 : OUT = 0; // OK - 0
        endcase

endmodule

module REG #(parameter N = 8) (in, pl, out);

    input [N-1:0] in;
    input pl;
    output reg [N-1:0] out;
    
    always @(in, pl)
        if(pl)
            out = in;
        
endmodule

module FREQ_DIV(clk, clk_out);

    input clk;
    output reg clk_out;
    
    integer count = 0;//, CURRENT_DATA = 100000;
    //reg UP = 1'b1;
    
    
    always @(posedge clk) begin
      count = count + 1;
      if (count == 100000) begin
        count = 0;
        clk_out = ~clk_out;
      end
      end

endmodule

module MUX4_1 #(parameter N = 8) (A, B, C, D, sel, out);

    input [N-1:0] A, B, C, D;
    input [1:0] sel;
    output reg [N-1:0] out;

    always @(A, B, C, D, sel)
    case(sel)
    
        2'b00 : out = D;
        2'b01 : out = C;
        2'b10 : out = B;
        2'b11 : out = A;
    
    endcase

endmodule


module DIG_DEC(din, dout);

    input [3:0] din;
    output reg [6:0] dout;
    
    always @(din)
    case(din)
        
        4'b0000 : dout = ~7'b011_1111; // 0
        4'b0001 : dout = ~7'b000_0110; // 1
        4'b0010 : dout = ~7'b101_1011; // 2 
        4'b0011 : dout = ~7'b100_1111; // 3 
        4'b0100 : dout = ~7'b110_0110; // 4 
        4'b0101 : dout = ~7'b110_1101; // 5 
        4'b0110 : dout = ~7'b111_1101; // 6 
        4'b0111 : dout = ~7'b000_0111; // 7 
        4'b1000 : dout = ~7'b111_1111; // 8 
        4'b1001 : dout = ~7'b110_1111; // 9 
        4'b1010 : dout = ~7'b111_0111; // A 
        4'b1011 : dout = ~7'b111_1100; // B 
        4'b1100 : dout = ~7'b011_1001; // C 
        4'b1101 : dout = ~7'b101_1110; // D 
        4'b1110 : dout = ~7'b111_1001; // E 
        4'b1111 : dout = ~7'b111_0001; // F 
        default : dout = 7'b111_1111;
       
    endcase
    
endmodule

module DEC2_4(AIN, AOUT);

    input [1:0] AIN;
    output reg [3:0] AOUT;

    always @(AIN)
    case(AIN)
    
        2'b00 : AOUT = ~4'b0001;
        2'b01 : AOUT = ~4'b0010;
        2'b10 : AOUT = ~4'b0100;
        2'b11 : AOUT = ~4'b1000;
    
    endcase

endmodule

module CNT(clk, out);

    input clk;
    output reg [1:0] out;
    
    always @(posedge clk)
        out = out + 1;
        
endmodule

module ALU #(parameter N = 8) (A, B, OP, O, ERR, OF, UF, ZERO);

input [N-1:0] A, B;
input [3:0] OP;
output reg [N-1:0] O;
output reg ERR, OF, UF, ZERO;

always @(A, B, OP)
    case(OP)
    
        3'b000 : if(A[N-1] == 1'b1 && B[N-1] == 1'b1) begin
                        {OF, UF, ERR, ZERO} = 4'b1010;
                        O = 0;
                    end else begin
                        {OF, UF, ERR, ZERO} = 4'b0000;
                        O = A+B;
                    end
                    
        3'b001 : if(A < B) begin
                    {OF, UF, ERR, ZERO} = 4'b0110;
                    O = 0;
                end else if(A == B) begin
                    {OF, UF, ERR, ZERO} = 4'b0001;
                    O = A-B;
                end else begin
                    {OF, UF, ERR, ZERO} = 4'b0000;
                    O = A-B;
                end
                
        3'b010 : begin 
                    O = A << B;
                    if(O == 0)
                        ZERO = 1;
                    else
                        ZERO = 0;
                        
                    {OF, UF, ERR} = 3'b000;
                 end
                 
        3'b011 : begin 
                    O = A >> B;
                    if(O == 0)
                        ZERO = 1;
                    else
                        ZERO = 0;
                        
                    {OF, UF, ERR} = 3'b000;
                 end
                 
        3'b100 : begin
                    O = A == B;
                    if(O == 0)
                        ZERO = 1;
                    else
                        ZERO = 0;
                        
                    {OF, UF, ERR} = 3'b000;
                 end
                 
        3'b101 : begin
                    O = A > B;
                    if(O == 0)
                        ZERO = 1;
                    else
                        ZERO = 0;
                        
                    {OF, UF, ERR} = 3'b000;
                 end
                 
        3'b110 : begin
                    O = A < B;
                    if(O == 0)
                        ZERO = 1;
                    else
                        ZERO = 0;
                        
                    {OF, UF, ERR} = 4'b000;
                 end
                 
         default : begin
                        O = 0;
                        {OF, UF, ERR, ZERO} = 4'b0010;
                   end        
    endcase

endmodule


