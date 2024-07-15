module MAIN_CONTROL(OPCODE, FUNC, ZERO, REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP);

    input [5:0] OPCODE, FUNC;
    input ZERO;
    output reg REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP;
    output reg [3:0] ALUOP;
    
    always @(OPCODE, FUNC, ZERO)
        case(OPCODE)
            6'b0 : case(FUNC) // R-TYPE
                    6'b100000 : {REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 1_1_0_0_0_0_0000; // ADD
                    6'b100010 : {REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 1_1_0_0_0_0_0001; // SUB
                    6'b100100 : {REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 1_1_0_0_0_0_0010; // AND
                    6'b100101 : {REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 1_1_0_0_0_0_0111; // OR
                    6'b101010 : {REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 1_1_0_0_0_0_1100; // SLT
                endcase
                
            // I-TYPE    
            6'b001000 : {REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 0_1_1_0_0_1_0000; // ADDI
            6'b011001 : {REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 0_1_1_0_0_1_0000; // LHI
            6'b011000 : {REGDST, REGWRITE, ALUSRC, MEMWRITE, MEM2REG, EXTOP, ALUOP} = 0_1_1_0_0_1_0000; // LOI     
        endcase

endmodule