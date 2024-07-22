module DM(clk, addr, WD, MEMWRITE, RD);

    input clk, MEMWRITE;
    input [31:0] addr, WD;
    output [31:0] RD;
    
    reg [31:0] MEM [31:0];
    
    reg [5:0] i;
    initial begin
        for(i = 0; i < 32; i = i+1)
            MEM[i] = 8'b0;
    end
    
    always @(posedge clk)
        if(MEMWRITE) begin
            MEM[addr] = WD[7:0];
            MEM[addr+1] = WD[15:8];
            MEM[addr+2] = WD[23:16];
            MEM[addr+3] = WD[31:24];
        end
                
    assign RD = {MEM[addr+3], MEM[addr+2], MEM[addr+1], MEM[addr]};

endmodule