module tb;

    reg clk;
    wire [31:0] PC_in, PC_OUT, instr, RB_RD1, RB_RD2, EXT_SIGN_OUT, ALU_MUX_OUT, ALU_OUT, DM_MUX_OUT, DM_RD;
    wire [3:0] ALUOP;
    wire [4:0] WA_MUX_OUT;
    wire ZERO, REGWRITE, REGDST, EXTOP, ALUSRC, MEMWRITE, MEM2REG; // flags
    
    reg PC_RES;
    
    PC PC_inst(clk, PC_RES, PC_in, PC_OUT);
    SUM4 SUM4_inst(PC_OUT, PC_in);
    
    IM IM_inst(PC_OUT, instr);
    
    MUX2_1 #(5) WA_MUX (instr[20:16], instr[15:11], REGDST, WA_MUX_OUT);
    REGISTERS_BANK REGISTERS_BANK_inst(clk, instr[25:21], instr[20:16], WA_MUX_OUT, DM_MUX_OUT, REGWRITE, RB_RD1, RB_RD2);
    EXT_SIGN EXT_SIGN_inst(instr[15:0], EXTOP, EXT_SIGN_OUT);
    
    MUX2_1 #(32) ALU_MUX(RB_RD2, EXT_SIGN_OUT, ALUSRC, ALU_MUX_OUT);
    ALU ALU_inst(RB_RD1, ALU_MUX_OUT, ALUOP, ZERO, ALU_OUT);
    
    DM DM_inst(clk, ALU_OUT, RB_RD2, MEMWRITE, DM_RD);
    MUX2_1 #(32) DM_MUX(DM_RD, ALU_OUT, MEM2REG, DM_MUX_OUT);
    
    MAIN_CONTROL MAIN_CONTROL_inst(instr[31:26], instr[5:0], ZERO, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP);
    
    
    
    initial begin
        #0 clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        #0 PC_RES = 1;
        
        #7 PC_RES = 0;
    
        #100 $finish;
    end

endmodule