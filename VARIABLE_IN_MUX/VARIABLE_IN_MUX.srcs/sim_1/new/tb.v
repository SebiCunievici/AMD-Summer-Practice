module tb;

parameter N = 8, IN_NR = 4;

reg [N*IN_NR-1:0] IN; //maginstrala?
reg [$clog2(IN_NR)-1:0] SEL;
wire [N-1:0] OUT;

MUX #(N, IN_NR) MUX_inst(IN, OUT, SEL);

initial begin
    
    #0 IN = 0;

    #5 SEL = 1'b0; IN[31:24] = 8'b0000_1000; IN[23:16] = 8'b0000_0001; IN[15:8] = 8'b0000_0110; IN[7:0] = 8'b0001_0000;
    
    #5 SEL = 1'b1;
    
    #5 SEL = 2'b10; 
    
    #5 SEL = 2'b11; 
    
    #20 $finish;

end

endmodule
