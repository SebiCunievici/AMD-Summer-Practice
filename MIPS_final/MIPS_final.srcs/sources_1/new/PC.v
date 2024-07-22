module PC(clk, res, in, out);

    input clk, res;
    input [31:0] in;
    output reg [31:0] out = 32'b0;

    always @(posedge clk)
        if(res)
            out = 0;
        else
            out = in;        

endmodule