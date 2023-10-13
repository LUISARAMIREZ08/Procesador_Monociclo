module mux_alu_sum(
    input [31:0] MUXsum,
    input [31:0] MUX1alu,
    input branch_next,
    output reg [31:0] MUXsum_aluout
    );

    always @(MUXsum, MUX1alu, branch_next)
    begin
        if (branch_next == 1) begin
            MUXsum_aluout = MUXsum;
        end
        else begin
            MUXsum_aluout = MUX1alu;
        end
    end
endmodule

/* module mux_alu_sum(
    input [31:0] MUXsum,
    input [31:0] MUX1alu,
    input MUXsum_aluop,
    output reg [31:0] MUXsum_aluout
    );

    always @(MUXsum, MUX1alu, MUXsum_aluop)
    begin
        case(MUXsum_aluop)
            0: MUXsum_aluout = MUXsum;
            1: MUXsum_aluout = MUX1alu;
        endcase
    end
endmodule */