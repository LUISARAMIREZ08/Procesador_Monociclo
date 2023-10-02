module mux_dm_alu_sum(
    input [31:0] MUXdm,
    input [31:0] MUX4alu,
    input [31:0] MUXsum,
    input [1:0] MUXdm_alu_sumop,
    output reg [31:0] MUXdm_alu_sumout
    );

    always @(MUXdm, MUX4alu, MUXsum, MUXdm_alu_sumop)
    begin
        case(MUXdm_alu_sumop)
            2'b00: MUXdm_alu_sumout = MUXdm;
            2'b01: MUXdm_alu_sumout = MUX4alu;
            2'b10: MUXdm_alu_sumout = MUXsum;
        endcase
    end
endmodule