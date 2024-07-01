module MUX #(parameter N = 8, IN_NR = 2) (IN, OUT, SEL);

    input [N*IN_NR-1:0] IN;
    input [$clog2(IN_NR)-1:0] SEL;
    output reg [N-1:0] OUT;
   
    
    always @(IN, SEL) 
        case(SEL)
            
            0 : OUT = IN[1*N-1:0];
            1 : OUT = IN[2*N-1:N];
            2 : OUT = IN[3*N-1:2*N];
            3 : OUT = IN[4*N-1:3*N];
            
                   
        endcase

    

endmodule