module IM(addr, instr);

    input [31:0] addr;
    output reg [31:0] instr;
    
    reg [7:0] MEM [1023:0];
    
    initial
        $readmemb("IM.mem", MEM);
        
    always @(addr) begin
        instr[7:0] = MEM[addr];
        instr[15:8] = MEM[addr+1];
        instr[23:16] = MEM[addr+2];
        instr[31:24] = MEM[addr+3];
    end

endmodule