module REGISTERS_BANK(clk, RA1, RA2, WA, WD, REGWRITE, RD1, RD2);

    input [4:0] RA1, RA2, WA;
    input clk, REGWRITE;
    input [31:0] WD;
    output [31:0] RD1, RD2;
    
    reg [31:0] registers [31:0];
    
    reg [5:0] i;
    initial begin
        for(i = 0; i < 32; i = i+1)
            registers[i] = 32'b0;
    end
            
     always @(posedge clk)
        if(REGWRITE)
            registers[WA] = WD;
     
     
     assign RD1 = registers[RA1];
     assign RD2 = registers[RA2];
     
endmodule

