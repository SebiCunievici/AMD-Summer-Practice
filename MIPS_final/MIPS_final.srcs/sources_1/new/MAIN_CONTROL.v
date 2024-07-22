module MAIN_CONTROL(OPCODE, FUNC, PCSRC, JUMP, ZERO, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP);

    input [5:0] OPCODE, FUNC;
    input ZERO;
    output reg PCSRC, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, JUMP;
    output reg [3:0] ALUOP;
    
    initial
        {PCSRC, JUMP, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 12'b0_0_0_0_0_0_0_0_0000;
    
    always @(OPCODE, FUNC, ZERO)
        case(OPCODE)
            6'b0 : case(FUNC) // R-TYPE
                    6'b100000 : {PCSRC, JUMP, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 12'b0_0_1_1_0_0_1_0_0010; // ADD
                    6'b100010 : {PCSRC, JUMP, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 12'b0_0_1_1_0_0_1_0_0001; // SUB
                    6'b100100 : {PCSRC, JUMP, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 12'b0_0_1_1_0_0_1_0_0010; // AND
                    6'b100101 : {PCSRC, JUMP, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 12'b0_0_1_1_0_0_1_0_0111; // OR
                    6'b101010 : {PCSRC, JUMP, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 12'b0_0_1_1_0_0_1_0_1100; // SLT
                endcase
                
            // I-TYPE    
            6'b001000 : {PCSRC, JUMP, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 12'b0_0_0_1_1_0_1_1_0010; // ADDI
            6'b101011 : {PCSRC, JUMP, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 12'b0_0_0_0_1_1_0_1_0010; // sw     
            6'b100011 : {PCSRC, JUMP, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 12'b0_0_0_1_1_0_0_1_0010; // lw
            6'b000100 : begin
                {JUMP, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 11'b0_0_0_0_0_0_1_0110; // beq
                if(ZERO)
                    PCSRC = 1'b1;    
            end
            6'b000010 : {PCSRC, JUMP, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 12'b0_1_0_0_0_0_0_0_0010; // J
        endcase

endmodule