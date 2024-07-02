module ALU #(parameter N = 8) (A, B, OP, O, ERR, OF, UF, ZERO);

input [N-1:0] A, B;
input [2:0] OP;
output reg [N-1:0] O;
output reg ERR, OF, UF, ZERO;

always @(A, B, OP)
    case(OP)
    
        3'b000 : if(A[N-1] == 1'b1 && B[N-1] == 1'b1) begin
                        {OF, UF, ERR, ZERO} = 4'b1010;
                        O = 0;
                    end else begin
                        {OF, UF, ERR, ZERO} = 4'b0000;
                        O = A+B;
                    end
                    
        3'b001 : if(A < B) begin
                    {OF, UF, ERR, ZERO} = 4'b0110;
                    O = 0;
                end else if(A == B) begin
                    {OF, UF, ERR, ZERO} = 4'b0001;
                    O = A-B;
                end else begin
                    {OF, UF, ERR, ZERO} = 4'b0000;
                    O = A-B;
                end
                
        3'b010 : begin 
                    O = A << B;
                    if(O == 0)
                        ZERO = 1;
                    else
                        ZERO = 0;
                        
                    {OF, UF, ERR} = 3'b000;
                 end
                 
        3'b011 : begin 
                    O = A >> B;
                    if(O == 0)
                        ZERO = 1;
                    else
                        ZERO = 0;
                        
                    {OF, UF, ERR} = 3'b000;
                 end
                 
        3'b100 : begin
                    O = A == B;
                    if(O == 0)
                        ZERO = 1;
                    else
                        ZERO = 0;
                        
                    {OF, UF, ERR} = 3'b000;
                 end
                 
        3'b101 : begin
                    O = A > B;
                    if(O == 0)
                        ZERO = 1;
                    else
                        ZERO = 0;
                        
                    {OF, UF, ERR} = 3'b000;
                 end
                 
        3'b110 : begin
                    O = A < B;
                    if(O == 0)
                        ZERO = 1;
                    else
                        ZERO = 0;
                        
                    {OF, UF, ERR} = 4'b000;
                 end
                 
         default : begin
                        O = 0;
                        {OF, UF, ERR, ZERO} = 4'b0010;
                   end        
        
        
    
    endcase

endmodule