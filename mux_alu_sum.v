module mux_alu_sum(
    input [31:0] MUX1sum,
    input [31:0] MUX1alu,
    input MUX1control,
    output reg [31:0] MUX1out
    );

    always @(MUX1sum, MUX1alu, MUX1control)
    begin
        if (MUX1control == 0) begin
            MUX1out = MUX1sum;
        end
        else begin
            MUX1out = MUX1alu;
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