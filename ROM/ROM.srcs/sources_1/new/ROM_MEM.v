module ROM_MEM(CLK, EN, OUT);

    input CLK, EN;
    output reg [31:0] OUT;
    
    reg [31:0] ROM [99:0];
    
    integer cnt = 0;
    
    initial
        $readmemh("ROM.mem", ROM);
    
    always @(posedge CLK)
        if(EN && (cnt < 100)) begin
            OUT = ROM[cnt];
            cnt = cnt + 1;
        end else
            cnt = 0;
            
endmodule

module bt_filter(clk, bt, bt_out);

    input clk, bt;
    output reg bt_out;
    
    reg [31:0] cnt = 32'b0;
    reg bt_lag = 0;
    
    always @(posedge clk)
        cnt = cnt + 1;
        
    always @(posedge cnt[16]) begin
        if(bt==1 & bt_lag==0) begin
            bt_out = 1;
            bt_lag = 1;
        end
        if(bt==0 & bt_lag==1) begin
            bt_out = 0;
            bt_lag = 0;
        end
    end

endmodule