module tb;

parameter N = 8;

reg [N-1:0] A, B, C;
reg [2:0] OP;
wire OF, UF, ERR, ZERO;
wire [N-1:0] O;

ALU #(N) ALU_inst(A, C, OP, O, ERR, OF, UF, ZERO);

initial begin

    #0 A = 0; B = 0; OP = 0;
    
    #5 A = 8'b0000_0001; B = 8'b0000_1000; C = A;
    
    forever #5 if(B > 2) multiply(); else $finish;

end

task multiply;
begin
    OP = 3'b000;
    A = A + C;
    B = B - 1;
end
endtask

endmodule