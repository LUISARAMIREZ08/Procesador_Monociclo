module mux_reg2_imm(
    input [31:0] MUX3reg2,
    input [31:0] MUX3imm,
    input MUX3control,
    output reg [31:0] MUX3out
    );

    always @(MUX3reg2, MUX3imm, MUX3control)
    begin
        case(MUX3control)
            0: MUX3out = MUX3reg2;
            1: MUX3out = MUX3imm;
        endcase
    end
endmodule