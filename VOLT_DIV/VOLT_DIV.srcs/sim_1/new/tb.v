module tb;

    reg [15:0] DIN;
    reg clk, PL, EN;
    wire clk_out;
    
    VOLT_DIV VOLT_DIV_inst(DIN, clk, EN, clk_out, PL);
    
    initial begin
        #0 clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
    
        #0 DIN = 16'b0; PL = 0; EN = 0;
        
        #5 DIN = 4; PL = 1;

        #5 PL = 0; EN = 1;
        
        #33 PL = 1; DIN = 7; EN = 0;
        
        #5 PL = 0; EN = 1;
        
        #200 $finish;
            
    end

endmodule