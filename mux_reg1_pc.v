module mux_reg1_pc(
    input [31:0] MUX2pc,
    input [31:0] MUX2reg1,
    input MUX2control,
    output reg [31:0] MUX2out
    );

    always @(MUX2pc, MUX2reg1, MUX2control)
    begin
        case(MUX2control)
            0: MUX2out = MUX2pc;
            1: MUX2out = MUX2reg1;
        endcase
    end
endmodule