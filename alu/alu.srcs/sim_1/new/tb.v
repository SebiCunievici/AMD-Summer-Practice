module tb;

parameter N = 8;

reg [N-1:0] A, B;
reg [2:0] OP;
wire OF, UF, ERR, ZERO;
wire [N-1:0] O;

ALU #(N) ALU_inst(A, B, OP, O, ERR, OF, UF, ZERO);

initial begin

    #0 A = 0; B = 0; OP = 0;
    
    #5 A = 8'b1000_0000; B = 8'b1000_0110;
    
    #5 A = 8'b0000_0100;
    
    #5 OP = 3'b001;
    
    #5 B = 8'b0000_0011;
    
    #5 OP = 3'b010;
    
    #5 OP = 3'b011;
    
    #5 OP = 3'b100;
    
    #5 OP = 3'b101;
    
    #5 OP = 3'b110;
    
    #5 OP = 3'b111;
    
    #5 OP = 3'b000;
    
    #20 $finish;

end

endmodule
