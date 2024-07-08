module tb;

    reg clk;
    reg [3:0] din;
    reg [1:0] AIN;
    wire [6:0] dout;
    wire [3:0] AOUT;
    wire [1:0] CNT_OUT; 
    
    DIG_DEC DIG_DEC_inst(din, dout);
    DEC2_4 DEC2_4_inst(AIN, AOUT);
    CNT CNT_inst(clk, CNT_OUT);
    
    integer i;
    
    initial begin
        #0 clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
    
        #0 AIN = 2'b10;
    
        #0 for(i = 0; i < 15; i = i+1) begin
            din = i;
            #10;
        end
        
        #10 $finish;
    
    end
    
endmodule