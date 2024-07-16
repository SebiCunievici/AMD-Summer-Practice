module MAIN_CONTROL(OPCODE, FUNC, PCSRC, ZERO, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP);

    input [5:0] OPCODE, FUNC;
    input ZERO;
    output reg PCSRC, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP;
    output reg [3:0] ALUOP;
    
    initial
        {REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 0_0_0_0_0_0_0000;
    
    always @(OPCODE, FUNC, ZERO)
        case(OPCODE)
            6'b0 : case(FUNC) // R-TYPE
                    6'b100000 : {PCSRC, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 11'b0_1_1_0_0_1_0_0010; // ADD
                    6'b100010 : {PCSRC, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 11'b0_1_1_0_0_1_0_0001; // SUB
                    6'b100100 : {PCSRC, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 11'b0_1_1_0_0_1_0_0010; // AND
                    6'b100101 : {PCSRC, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 11'b0_1_1_0_0_1_0_0111; // OR
                    6'b101010 : {PCSRC, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 11'b0_1_1_0_0_1_0_1100; // SLT
                endcase
                
            // I-TYPE    
            6'b001000 : {PCSRC, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 11'b0_0_1_1_0_1_1_0010; // ADDI
            /*6'b011001 : {REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 10'b0_1_1_0_1_1_0000; // LUI
            6'b011000 : {REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 10'b0_1_1_0_1_1_0000; // LLI */
            6'b101011 : {PCSRC, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 11'b0_0_0_1_1_0_1_0010; // sw     
            6'b100011 : {PCSRC, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 11'b0_0_1_1_0_0_1_0010; // lw
            6'b000100 : begin
                {REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 10'b0_0_0_0_0_1_0110; // beq
                if(ZERO)
                    PCSRC = 1'b1;    
            end
        endcase

endmodule