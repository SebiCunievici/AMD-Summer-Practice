module DM(clk, addr, WD, MEMWRITE, RD);

    input clk, MEMWRITE;
    input [31:0] addr, WD;
    output reg [31:0] RD;
    
    reg [7:0] MEM [31:0];
    
    reg [9:0] i;
    initial begin
        for(i = 0; i < 1024; i = i+1)
            MEM[i] = 32'b0;
    end
    
    always @(posedge clk)
        if(MEMWRITE) begin
            MEM[addr] = WD[7:0];
            MEM[addr+1] = WD[15:8];
            MEM[addr+2] = WD[23:16];
            MEM[addr+3] = WD[31:24];
        end
                
     always @(negedge clk)
        RD = {MEM[addr], MEM[addr+1], MEM[addr+2], MEM[addr+3]};


endmodule