module tb;

    reg clk;
    wire [31:0] PC_in, PC_out, instr;
    
    wire ZERO, REGWRITE;
    
    PC PC_inst(clk, PC_in, PC_out);
    SUM4 SUM4_inst(PC_out, PC_in);
    
    IM IM_inst(PC_OUT, instr);
    
    REGISTERS_BANK(clk, RA1, RA2, WA, WD, REGWRITE, RD1, RD2);

endmodule