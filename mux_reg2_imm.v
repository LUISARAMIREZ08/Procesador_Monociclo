module mux_reg2_imm(
    input [31:0] MUXreg2,
    input [31:0] MUXimm,
    input MUXimm_reg2op,
    output reg [31:0] MUXimm_reg2out
    );

    always @(MUXreg2, MUXimm, MUXimm_reg2op)
    begin
        case(MUXimm_reg2op)
            0: MUXimm_reg2out = MUXreg2;
            1: MUXimm_reg2out = MUXimm;
        endcase
    end
endmodule