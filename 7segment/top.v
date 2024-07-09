module top(in, clk, COUT, AOUT);

    input clk;
    input [15:0] in;
    output [6:0] COUT;
    output [3:0] AOUT; 
    wire [1:0] CNT_OUT;
    wire [3:0] MUX_OUT;
    wire clk_div;

    MUX4_1 MUX_inst(in[15:12], in[11:8], in[7:4], in[3:0], CNT_OUT, MUX_OUT);
    CNT CNT_inst(clk_div, CNT_OUT);
    DIG_DEC DIG_DEC_inst(MUX_OUT, COUT);
    DEC2_4(CNT_OUT, AOUT);
    
    FREQ_DIV FREQ_DIV_inst(clk, clk_div);

endmodule

module FREQ_DIV(clk, clk_out);

    input clk;
    output reg clk_out;
    
    integer count = 0;//, CURRENT_DATA = 100000;
    //reg UP = 1'b1;
    
    
    always @(clk) begin
      count = count + 1;
      if (count == 100000) begin
        count = 0;
        clk_out = ~clk_out;
      end
      end

endmodule

module MUX4_1(A, B, C, D, sel, out);

    input [3:0] A, B, C, D;
    input [1:0] sel;
    output reg [3:0] out;

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


