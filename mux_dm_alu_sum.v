module mux_dm_alu_sum(
    input [31:0] MUX4dm,
    input [31:0] MUX4alu,
    input [31:0] MUX4sum,
    input [1:0] MUX4control,
    output reg [31:0] MUX4out
    );

    always @(MUX4dm, MUX4alu, MUX4sum, MUX4control)
    begin
        case(MUX4control)
            2'b00: MUX4out = MUX4dm;
            2'b01: MUX4out = MUX4alu;
            2'b10: MUX4out = MUX4sum;
        endcase
    end
endmodule