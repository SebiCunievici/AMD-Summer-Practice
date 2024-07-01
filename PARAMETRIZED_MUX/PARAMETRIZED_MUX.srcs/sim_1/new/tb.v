module tb;

    parameter N = 16;
    
    reg [N-1:0] A, B;
    reg SEL;
    wire [N-1:0] O1, O2;
    
    MUX_CASE #(N) MUX_CASE_inst(A, B, SEL, O1);
    MUX_GATE #(N) MUX_GATE_inst(A, B, SEL, O2);
    
    initial begin
    
        #0 SEL = 1'b0; A = 4'b0110; B = 4'b0001;
        
        #5 SEL = 1'b1;
        
        #5 A = 2'b11; SEL = 1'b0;
        
        #20 $finish;
    
    end

endmodule
