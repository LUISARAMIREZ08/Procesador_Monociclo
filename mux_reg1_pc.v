module mux_reg1_pc(
    input [31:0] MUXpc,
    input [31:0] MUXreg1,
    input MUXpc_reg1op,
    output reg [31:0] MUXpc_reg1out
    );

    always @(MUXpc, MUXreg1, MUXpc_reg1op)
    begin
        case(MUXpc_reg1op)
            0: MUXpc_reg1out = MUXpc;
            1: MUXpc_reg1out = MUXreg1;
        endcase
    end
endmodule