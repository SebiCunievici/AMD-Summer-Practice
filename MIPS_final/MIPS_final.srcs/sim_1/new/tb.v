module tb;

    reg clk;
    wire [31:0] PC_OUT, instr, RB_RD1, RB_RD2, EXT_SIGN_OUT, ALU_MUX_OUT, ALU_OUT, DM_MUX_OUT, DM_RD, BEQ_OFFSET, SUM_PC_OUT, SUM_BEQ_OUT, MUX_BEQ_OUT, MUX_JUMP_OUT;
    wire [3:0] ALUOP;
    wire [4:0] WA_MUX_OUT;
    wire PCSRC, JUMP, ZERO, REGWRITE, REGDST, EXTOP, ALUSRC, MEMWRITE, MEM2REG; // flags
    
    reg PC_RES;
    
    PC PC_inst(clk, PC_RES, MUX_JUMP_OUT, PC_OUT);
    SUM SUM_PC_inst(PC_OUT, 4, SUM_PC_OUT);
    
    SHIFT_REG SHIFT_REG_inst(EXT_SIGN_OUT, 2, BEQ_OFFSET);
    SUM SUM_BEQ_inst(SUM_PC_OUT, BEQ_OFFSET, SUM_BEQ_OUT);
    MUX2_1 MUX_BEQ_inst(SUM_PC_OUT, SUM_BEQ_OUT, PCSRC, MUX_BEQ_OUT);
    
    MUX2_1 #(32) MUX_JUMP(MUX_BEQ_OUT, {PC_OUT[31:28], instr[25:0], 2'b00}, JUMP, MUX_JUMP_OUT);
    
    IM IM_inst(PC_OUT, instr);
    
    MUX2_1 #(5) WA_MUX (instr[20:16], instr[15:11], REGDST, WA_MUX_OUT);
    REGISTERS_BANK REGISTERS_BANK_inst(clk, instr[25:21], instr[20:16], WA_MUX_OUT, DM_MUX_OUT, REGWRITE, RB_RD1, RB_RD2);
    EXT_SIGN EXT_SIGN_inst(instr[15:0], EXTOP, EXT_SIGN_OUT);
    
    MUX2_1 #(32) ALU_MUX(RB_RD2, EXT_SIGN_OUT, ALUSRC, ALU_MUX_OUT);
    ALU ALU_inst(RB_RD1, ALU_MUX_OUT, ALUOP, ZERO, ALU_OUT);
    
    DM DM_inst(clk, ALU_OUT, RB_RD2, MEMWRITE, DM_RD);
    MUX2_1 #(32) DM_MUX(DM_RD, ALU_OUT, MEM2REG, DM_MUX_OUT);
    
    MAIN_CONTROL MAIN_CONTROL_inst(instr[31:26], instr[5:0], PCSRC, JUMP, ZERO, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP);
    
    
    
    initial begin
        #0 clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        #0 PC_RES = 1;
        
        #3 PC_RES = 0;
    
        #200 $finish;
    end

endmodule