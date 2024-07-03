module VOLT_DIV(DIN, clk, EN, clk_out, PL);

    input [15:0] DIN;
    input clk, EN, PL;
    output reg clk_out;
    
    reg [15:0] DATA, CURRENT_DATA;
    reg UP = 0;
    
    
    always @(clk)
        if(EN)
            if(~UP) begin
                    clk_out = 1;
                    DATA = DATA - 1;
                    UP = (DATA == 0) ? 1 : 0;
                end
            else begin
                    clk_out = 0;
                    DATA = DATA + 1;   
                    UP = (DATA >= CURRENT_DATA) ? 0 : 1; 
                end else if(PL) begin
                    DATA = DIN;
                    CURRENT_DATA = DIN;
                end 
            
            

endmodule